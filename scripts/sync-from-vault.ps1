# Sync Script: Vault Publish Folder to Jekyll _posts
# This script copies markdown files from your vault's Publish folder to the Jekyll _posts directory
# Security: Includes path validation, input sanitization, and safe file operations

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$VaultPath = "",
    [Parameter(Mandatory=$false)]
    [switch]$Watch = $false
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Security: Validate and sanitize paths
function Test-SafePath {
    param(
        [string]$Path,
        [string]$BasePath
    )
    
    try {
        $resolvedPath = [System.IO.Path]::GetFullPath($Path)
        $resolvedBase = [System.IO.Path]::GetFullPath($BasePath)
        
        # Check if path is within base path (prevent path traversal)
        if (-not $resolvedPath.StartsWith($resolvedBase, [System.StringComparison]::OrdinalIgnoreCase)) {
            return $false
        }
        
        return $true
    } catch {
        return $false
    }
}

# Security: Sanitize filename to prevent directory traversal and invalid characters
function Get-SafeFilename {
    param([string]$Title)
    
    # Remove or replace dangerous characters
    $safe = $Title -replace '[<>:"/\\|?*]', '' -replace '[^\w\s-]', '' -replace '\s+', '-' -replace '-+', '-'
    $safe = $safe.Trim('-', '.', ' ')
    
    # Limit length to prevent filesystem issues
    if ($safe.Length -gt 200) {
        $safe = $safe.Substring(0, 200)
    }
    
    # Ensure not empty
    if ([string]::IsNullOrWhiteSpace($safe)) {
        $safe = "untitled"
    }
    
    return $safe.ToLower()
}

# Security: Validate file extension
function Test-ValidMarkdownFile {
    param([string]$FilePath)
    
    $extension = [System.IO.Path]::GetExtension($FilePath).ToLower()
    $validExtensions = @('.md', '.markdown')
    
    return $validExtensions -contains $extension
}

# Get project root
$ProjectRoot = Split-Path $PSScriptRoot -Parent
$ConfigPath = Join-Path $ProjectRoot "obsidian\vault-config.json"

# Load configuration with error handling
if (-not (Test-Path $ConfigPath)) {
    Write-Host "ERROR: vault-config.json not found at: $ConfigPath" -ForegroundColor Red
    Write-Host "Please create it from vault-config.json.example" -ForegroundColor Yellow
    exit 1
}

try {
    $configContent = Get-Content $ConfigPath -Raw -ErrorAction Stop
    $config = $configContent | ConvertFrom-Json -ErrorAction Stop
} catch {
    Write-Host "ERROR: Failed to parse vault-config.json. Invalid JSON format." -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Yellow
    exit 1
}

# Validate required config fields
$requiredFields = @('publishFolder', 'postsFolder')
foreach ($field in $requiredFields) {
    if (-not $config.$field) {
        Write-Host "ERROR: Missing required field '$field' in vault-config.json" -ForegroundColor Red
        exit 1
    }
}

# Use config vault path or parameter (environment variable takes precedence)
if ([string]::IsNullOrEmpty($VaultPath)) {
    # Check environment variable first (more secure)
    $envVaultPath = $env:JEKYLL_VAULT_PATH
    if (-not [string]::IsNullOrEmpty($envVaultPath)) {
        $VaultPath = $envVaultPath
        Write-Host "Using vault path from environment variable" -ForegroundColor Cyan
    } else {
        $VaultPath = $config.vaultPath
    }
}

if ([string]::IsNullOrEmpty($VaultPath)) {
    Write-Host "ERROR: Vault path not configured." -ForegroundColor Red
    Write-Host "Set 'vaultPath' in vault-config.json or use -VaultPath parameter" -ForegroundColor Yellow
    Write-Host "Or set environment variable: `$env:JEKYLL_VAULT_PATH" -ForegroundColor Yellow
    exit 1
}

# Security: Validate vault path exists and is accessible
if (-not (Test-Path $VaultPath -PathType Container)) {
    Write-Host "ERROR: Vault path does not exist or is not accessible: $VaultPath" -ForegroundColor Red
    exit 1
}

# Build paths with validation
$publishFolder = Join-Path $VaultPath $config.publishFolder
$postsFolder = Join-Path $ProjectRoot $config.postsFolder

# Security: Validate paths are safe (within expected directories)
if (-not (Test-SafePath -Path $publishFolder -BasePath $VaultPath)) {
    Write-Host "ERROR: Invalid publish folder path (security check failed)" -ForegroundColor Red
    exit 1
}

if (-not (Test-SafePath -Path $postsFolder -BasePath $ProjectRoot)) {
    Write-Host "ERROR: Invalid posts folder path (security check failed)" -ForegroundColor Red
    exit 1
}

# Check if vault publish folder exists
if (-not (Test-Path $publishFolder -PathType Container)) {
    Write-Host "ERROR: Publish folder not found at: $publishFolder" -ForegroundColor Red
    Write-Host "Please check your vault path and ensure the 'Publish' folder exists." -ForegroundColor Yellow
    exit 1
}

# Ensure _posts folder exists
if (-not (Test-Path $postsFolder -PathType Container)) {
    try {
        New-Item -ItemType Directory -Path $postsFolder -Force | Out-Null
        Write-Host "Created _posts directory" -ForegroundColor Green
    } catch {
        Write-Host "ERROR: Failed to create posts directory: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

function Sync-File {
    param(
        [string]$SourceFile,
        [string]$DestinationFolder
    )
    
    try {
        # Security: Validate file exists and is readable
        if (-not (Test-Path $SourceFile -PathType Leaf)) {
            Write-Host "  WARNING: Source file not found: $SourceFile" -ForegroundColor Yellow
            return
        }
        
        # Security: Validate file extension
        if (-not (Test-ValidMarkdownFile -FilePath $SourceFile)) {
            Write-Host "  SKIP: Invalid file type (not .md or .markdown): $SourceFile" -ForegroundColor Yellow
            return
        }
        
        # Security: Validate source file is within publish folder
        if (-not (Test-SafePath -Path $SourceFile -BasePath $publishFolder)) {
            Write-Host "  SECURITY: Skipping file outside publish folder: $SourceFile" -ForegroundColor Red
            return
        }
        
        $fileName = Split-Path $SourceFile -Leaf
        $fileContent = Get-Content $SourceFile -Raw -ErrorAction Stop
        
        # Security: Limit file size (prevent memory issues)
        $maxFileSize = 10 * 1024 * 1024  # 10MB in bytes
        if ($fileContent.Length -gt $maxFileSize) {
            Write-Host "  SKIP: File too large (>10MB): $fileName" -ForegroundColor Yellow
            return
        }
        
        # Extract front matter
        $frontMatterPattern = '(?s)^---\s*(.*?)\s*---\s*(.*)$'
        $match = [regex]::Match($fileContent, $frontMatterPattern)
        
        if ($match.Success) {
            $frontMatterText = $match.Groups[1].Value
            $content = $match.Groups[2].Value
            
            # Parse YAML front matter
            $date = Get-Date -Format $config.dateFormat
            $title = $fileName -replace '\.(md|markdown)$', ''
            
            # Extract date with validation
            if ($frontMatterText -match 'date:\s*(\d{4}-\d{2}-\d{2})') {
                $extractedDate = $matches[1]
                # Validate date format
                try {
                    [DateTime]::ParseExact($extractedDate, "yyyy-MM-dd", $null) | Out-Null
                    $date = $extractedDate
                } catch {
                    Write-Host "  WARNING: Invalid date format, using current date" -ForegroundColor Yellow
                }
            } elseif ($config.autoDate) {
                $date = Get-Date -Format $config.dateFormat
            }
            
            # Extract title with sanitization
            if ($frontMatterText -match 'title:\s*["'']?([^"'']+)["'']?') {
                $title = $matches[1].Trim()
            }
            
            # Security: Sanitize title for filename
            $titleSlug = Get-SafeFilename -Title $title
            
            # Create destination filename: YYYY-MM-DD-title-slug.md
            $destFileName = "$date-$titleSlug.md"
            $destPath = Join-Path $DestinationFolder $destFileName
            
            # Security: Final path validation
            if (-not (Test-SafePath -Path $destPath -BasePath $DestinationFolder)) {
                Write-Host "  SECURITY: Invalid destination path, skipping: $destFileName" -ForegroundColor Red
                return
            }
            
            # Check if file exists
            if ((Test-Path $destPath) -and (-not $config.overwriteExisting)) {
                Write-Host "  SKIP: $destFileName (already exists)" -ForegroundColor Yellow
                return
            }
            
            # Copy file with error handling
            try {
                Copy-Item $SourceFile $destPath -Force -ErrorAction Stop
                Write-Host "  SYNCED: $fileName -> $destFileName" -ForegroundColor Green
            } catch {
                Write-Host "  ERROR: Failed to copy file: $($_.Exception.Message)" -ForegroundColor Red
            }
            
        } else {
            # No front matter - add basic front matter
            $date = Get-Date -Format $config.dateFormat
            $title = $fileName -replace '\.(md|markdown)$', ''
            $titleSlug = Get-SafeFilename -Title $title
            
            $destFileName = "$date-$titleSlug.md"
            $destPath = Join-Path $DestinationFolder $destFileName
            
            # Security: Final path validation
            if (-not (Test-SafePath -Path $destPath -BasePath $DestinationFolder)) {
                Write-Host "  SECURITY: Invalid destination path, skipping: $destFileName" -ForegroundColor Red
                return
            }
            
            if ((Test-Path $destPath) -and (-not $config.overwriteExisting)) {
                Write-Host "  SKIP: $destFileName (already exists)" -ForegroundColor Yellow
                return
            }
            
            # Security: Escape title for YAML (prevent injection)
            $escapedTitle = $title -replace ':', ' -' -replace '"', '\"'
            
            # Create front matter
            $frontMatter = @"
---
title: $escapedTitle
date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss zzz")
categories: []
tags: []
---

"@
            
            $newContent = $frontMatter + $fileContent
            try {
                Set-Content -Path $destPath -Value $newContent -NoNewline -ErrorAction Stop
                Write-Host "  SYNCED: $fileName -> $destFileName (added front matter)" -ForegroundColor Green
            } catch {
                Write-Host "  ERROR: Failed to write file: $($_.Exception.Message)" -ForegroundColor Red
            }
        }
    } catch {
        Write-Host "  ERROR processing $SourceFile : $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Sync-All {
    Write-Host "Syncing files from vault..." -ForegroundColor Cyan
    Write-Host "  Source: $publishFolder" -ForegroundColor Gray
    Write-Host "  Destination: $postsFolder" -ForegroundColor Gray
    Write-Host ""
    
    try {
        $files = Get-ChildItem -Path $publishFolder -Filter "*.md" -File -ErrorAction Stop
    } catch {
        Write-Host "ERROR: Failed to read publish folder: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
    
    if ($files.Count -eq 0) {
        Write-Host "No markdown files found in Publish folder." -ForegroundColor Yellow
        return
    }
    
    $syncedCount = 0
    $errorCount = 0
    
    foreach ($file in $files) {
        try {
            Sync-File -SourceFile $file.FullName -DestinationFolder $postsFolder
            $syncedCount++
        } catch {
            $errorCount++
            Write-Host "  ERROR: $($file.Name) - $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    
    Write-Host ""
    if ($errorCount -eq 0) {
        Write-Host "Sync complete! Processed $syncedCount file(s)." -ForegroundColor Green
    } else {
        Write-Host "Sync complete with errors. Processed $syncedCount file(s), $errorCount error(s)." -ForegroundColor Yellow
    }
}

if ($Watch) {
    Write-Host "Watching for changes in: $publishFolder" -ForegroundColor Cyan
    Write-Host "Press Ctrl+C to stop watching" -ForegroundColor Yellow
    Write-Host ""
    
    # Initial sync
    Sync-All
    
    # Watch for changes with error handling
    try {
        $watcher = New-Object System.IO.FileSystemWatcher
        $watcher.Path = $publishFolder
        $watcher.Filter = "*.md"
        $watcher.IncludeSubdirectories = $false
        $watcher.EnableRaisingEvents = $true
        
        $action = {
            try {
                $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                Write-Host "[$changeType] $path" -ForegroundColor Cyan
                Start-Sleep -Seconds 1  # Wait for file to be fully written
                Sync-File -SourceFile $path -DestinationFolder $postsFolder
            } catch {
                Write-Host "  ERROR in watcher: $($_.Exception.Message)" -ForegroundColor Red
            }
        }
        
        Register-ObjectEvent $watcher "Created" -Action $action | Out-Null
        Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
        
        try {
            while ($true) {
                Start-Sleep -Seconds 1
            }
        } finally {
            $watcher.EnableRaisingEvents = $false
            $watcher.Dispose()
            Write-Host "File watcher stopped." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "ERROR: Failed to start file watcher: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    Sync-All
}
