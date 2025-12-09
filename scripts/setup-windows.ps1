# Windows Setup Script for Jekyll Site
# This script sets up a fresh Jekyll site installation on Windows
# Run this script after cloning the repository

[CmdletBinding()]
param(
    [switch]$SkipRuby = $false,
    [switch]$SkipObsidian = $false
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Jekyll Site Setup for Windows" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get project root
$ProjectRoot = Split-Path $PSScriptRoot -Parent
Set-Location $ProjectRoot

# Check PowerShell version
$psVersion = $PSVersionTable.PSVersion.Major
if ($psVersion -lt 5) {
    Write-Host "ERROR: PowerShell 5.0 or higher is required. Current version: $psVersion" -ForegroundColor Red
    exit 1
}
Write-Host "✓ PowerShell $psVersion detected" -ForegroundColor Green

# Step 1: Check Ruby installation
Write-Host ""
Write-Host "Step 1: Checking Ruby installation..." -ForegroundColor Yellow

$rubyCmd = Get-Command ruby -ErrorAction SilentlyContinue
if ($null -eq $rubyCmd) {
    if ($SkipRuby) {
        Write-Host "⚠ Ruby not found, but skipping installation (--SkipRuby flag)" -ForegroundColor Yellow
        Write-Host "  Please install Ruby manually from: https://www.ruby-lang.org/en/downloads/" -ForegroundColor Yellow
    } else {
        Write-Host "✗ Ruby not found" -ForegroundColor Red
        Write-Host ""
        Write-Host "Ruby is required for Jekyll. Please install Ruby:" -ForegroundColor Yellow
        Write-Host "  1. Download Ruby+Devkit from: https://rubyinstaller.org/downloads/" -ForegroundColor Cyan
        Write-Host "  2. Run the installer and select 'Add Ruby executables to your PATH'" -ForegroundColor Cyan
        Write-Host "  3. After installation, restart PowerShell and run this script again" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Or use Chocolatey: choco install ruby" -ForegroundColor Cyan
        exit 1
    }
} else {
    $rubyVersion = ruby -v
    Write-Host "✓ Ruby found: $rubyVersion" -ForegroundColor Green
}

# Step 2: Check Bundler
Write-Host ""
Write-Host "Step 2: Checking Bundler..." -ForegroundColor Yellow

$bundleCmd = Get-Command bundle -ErrorAction SilentlyContinue
if ($null -eq $bundleCmd) {
    Write-Host "⚠ Bundler not found. Installing..." -ForegroundColor Yellow
    try {
        gem install bundler
        Write-Host "✓ Bundler installed successfully" -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed to install Bundler: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    $bundleVersion = bundle -v
    Write-Host "✓ Bundler found: $bundleVersion" -ForegroundColor Green
}

# Step 3: Install Jekyll dependencies
Write-Host ""
Write-Host "Step 3: Installing Jekyll dependencies..." -ForegroundColor Yellow

if (-not (Test-Path "Gemfile")) {
    Write-Host "✗ Gemfile not found in current directory" -ForegroundColor Red
    exit 1
}

try {
    Write-Host "Running bundle install (this may take a few minutes)..." -ForegroundColor Cyan
    bundle install
    if ($LASTEXITCODE -ne 0) {
        throw "Bundle install failed"
    }
    Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to install dependencies: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "  Try running: bundle install" -ForegroundColor Yellow
    exit 1
}

# Step 4: Setup Obsidian configuration (optional)
if (-not $SkipObsidian) {
    Write-Host ""
    Write-Host "Step 4: Setting up Obsidian configuration..." -ForegroundColor Yellow
    
    $configFile = Join-Path $ProjectRoot "obsidian\vault-config.json"
    $configExample = Join-Path $ProjectRoot "obsidian\vault-config.json.example"
    
    if (-not (Test-Path $configFile)) {
        if (Test-Path $configExample) {
            Write-Host "Creating vault-config.json from example..." -ForegroundColor Cyan
            Copy-Item $configExample $configFile
            Write-Host "✓ Configuration file created: $configFile" -ForegroundColor Green
            Write-Host "  Please edit this file and set your vault path" -ForegroundColor Yellow
        } else {
            Write-Host "⚠ Example config not found, skipping..." -ForegroundColor Yellow
        }
    } else {
        Write-Host "✓ Configuration file already exists" -ForegroundColor Green
    }
} else {
    Write-Host ""
    Write-Host "Step 4: Skipping Obsidian setup (--SkipObsidian flag)" -ForegroundColor Yellow
}

# Step 5: Verify setup
Write-Host ""
Write-Host "Step 5: Verifying setup..." -ForegroundColor Yellow

$checks = @(
    @{ Name = "Gemfile"; Path = "Gemfile" },
    @{ Name = "Gemfile.lock"; Path = "Gemfile.lock" },
    @{ Name = "_config.yml"; Path = "_config.yml" },
    @{ Name = "Scripts folder"; Path = "scripts" }
)

$allGood = $true
foreach ($check in $checks) {
    if (Test-Path $check.Path) {
        Write-Host "  ✓ $($check.Name)" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $($check.Name) not found" -ForegroundColor Red
        $allGood = $false
    }
}

if (-not $allGood) {
    Write-Host ""
    Write-Host "⚠ Some files are missing. Setup may be incomplete." -ForegroundColor Yellow
}

# Step 6: Test Jekyll
Write-Host ""
Write-Host "Step 6: Testing Jekyll installation..." -ForegroundColor Yellow

try {
    $jekyllVersion = bundle exec jekyll -v 2>&1
    Write-Host "✓ Jekyll installed: $jekyllVersion" -ForegroundColor Green
} catch {
    Write-Host "⚠ Could not verify Jekyll installation" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Edit _config.yml with your site information" -ForegroundColor Cyan
Write-Host "  2. (Optional) Configure Obsidian vault path in obsidian/vault-config.json" -ForegroundColor Cyan
Write-Host "  3. Start the development server:" -ForegroundColor Cyan
Write-Host "     .\scripts\start-local-server.ps1" -ForegroundColor White
Write-Host ""
Write-Host "For more information, see:" -ForegroundColor Yellow
Write-Host "  - README.md - Main documentation" -ForegroundColor Cyan
Write-Host "  - docs/setup/QUICKSTART.md - Quick start guide" -ForegroundColor Cyan
Write-Host "  - docs/setup/SETUP_GUIDE.md - Detailed setup guide" -ForegroundColor Cyan
Write-Host "  - docs/OBSIDIAN_SETUP.md - Obsidian integration" -ForegroundColor Cyan
Write-Host "  - docs/reference/SECURITY.md - Security best practices" -ForegroundColor Cyan
Write-Host ""

