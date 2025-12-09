# Pre-Commit Security Check Script
# Run this before committing to check for sensitive data

[CmdletBinding()]
param(
    [switch]$StagedOnly = $false
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Pre-Commit Security Check" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get project root
$ProjectRoot = Split-Path $PSScriptRoot -Parent
Set-Location $ProjectRoot

# Patterns to check for
$sensitivePatterns = @(
    @{ Pattern = "C:\\Users\\[^\\]+"; Description = "Windows user path" },
    @{ Pattern = "/home/[^/]+"; Description = "Linux user path" },
    @{ Pattern = "password\s*[:=]"; Description = "Password field" },
    @{ Pattern = "secret\s*[:=]"; Description = "Secret field" },
    @{ Pattern = "api[_-]?key\s*[:=]"; Description = "API key" },
    @{ Pattern = "token\s*[:=]"; Description = "Token field" },
    @{ Pattern = "\.env"; Description = ".env file reference" }
)

# Get files to check
if ($StagedOnly) {
    $files = git diff --cached --name-only 2>$null
    if (-not $files) {
        Write-Host "No staged files to check." -ForegroundColor Yellow
        exit 0
    }
    Write-Host "Checking staged files only..." -ForegroundColor Cyan
} else {
    $files = git diff --cached --name-only 2>$null
    if (-not $files) {
        Write-Host "No changes to check. Run 'git add .' first." -ForegroundColor Yellow
        exit 0
    }
    Write-Host "Checking all staged changes..." -ForegroundColor Cyan
}

Write-Host ""

$issuesFound = $false
$checkedFiles = 0

foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        continue
    }
    
    # Skip binary files
    $extension = [System.IO.Path]::GetExtension($file).ToLower()
    $binaryExtensions = @('.png', '.jpg', '.jpeg', '.gif', '.ico', '.svg', '.woff', '.woff2', '.ttf', '.eot', '.gem')
    if ($binaryExtensions -contains $extension) {
        continue
    }
    
    try {
        $content = Get-Content $file -Raw -ErrorAction Stop
        $checkedFiles++
        
        foreach ($check in $sensitivePatterns) {
            if ($content -match $check.Pattern) {
                $issuesFound = $true
                Write-Host "⚠ WARNING: $file" -ForegroundColor Red
                Write-Host "   Contains: $($check.Description)" -ForegroundColor Yellow
                
                # Show context (first match)
                $match = [regex]::Match($content, $check.Pattern)
                if ($match.Success) {
                    $lineNum = ($content.Substring(0, $match.Index) -split "`n").Count
                    Write-Host "   Line ~$lineNum : $($match.Value.Substring(0, [Math]::Min(50, $match.Value.Length)))" -ForegroundColor Gray
                }
                Write-Host ""
            }
        }
    } catch {
        # Skip files that can't be read
        continue
    }
}

Write-Host "========================================" -ForegroundColor Cyan
if ($issuesFound) {
    Write-Host "⚠ Issues found! Review before committing." -ForegroundColor Red
    Write-Host ""
    Write-Host "Common fixes:" -ForegroundColor Yellow
    Write-Host "  - Remove personal paths from example files" -ForegroundColor Cyan
    Write-Host "  - Use placeholders (YourName, YourPath) instead" -ForegroundColor Cyan
    Write-Host "  - Use environment variables for sensitive data" -ForegroundColor Cyan
    Write-Host "  - Check docs/reference/PRE_COMMIT_CHECKLIST.md for details" -ForegroundColor Cyan
    exit 1
} else {
    Write-Host "✓ Check complete! No obvious sensitive data found." -ForegroundColor Green
    Write-Host "  Checked $checkedFiles file(s)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Remember to:" -ForegroundColor Yellow
    Write-Host "  - Review git status before committing" -ForegroundColor Cyan
    Write-Host "  - Verify obsidian/vault-config.json is NOT staged" -ForegroundColor Cyan
    Write-Host "  - Check docs/reference/PRE_COMMIT_CHECKLIST.md for full checklist" -ForegroundColor Cyan
    exit 0
}

