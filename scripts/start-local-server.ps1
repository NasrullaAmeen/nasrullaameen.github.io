# Local Jekyll Server Startup Script
# This script starts the Jekyll development server for local preview
# Security: Includes input validation and safe defaults

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [ValidatePattern('^(\d{1,3}\.){3}\d{1,3}$|^localhost$')]
    [string]$BindHost = "127.0.0.1",
    [Parameter(Mandatory=$false)]
    [switch]$Production = $false
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Get the project root (parent of scripts folder)
$ProjectRoot = Split-Path $PSScriptRoot -Parent

# Security: Validate project root exists
if (-not (Test-Path $ProjectRoot -PathType Container)) {
    Write-Host "ERROR: Project root not found: $ProjectRoot" -ForegroundColor Red
    exit 1
}

# Change to project root
try {
    Set-Location $ProjectRoot -ErrorAction Stop
} catch {
    Write-Host "ERROR: Failed to change to project root: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "Starting Jekyll local server..." -ForegroundColor Cyan
Write-Host ""

# Check if bundle is installed
$bundleCmd = Get-Command bundle -ErrorAction SilentlyContinue
if ($null -eq $bundleCmd) {
    Write-Host "ERROR: Bundler not found. Please install Ruby and Bundler first." -ForegroundColor Red
    Write-Host "  Install Ruby from: https://www.ruby-lang.org/en/downloads/" -ForegroundColor Yellow
    Write-Host "  Then run: gem install bundler" -ForegroundColor Yellow
    exit 1
}

Write-Host "Bundler found" -ForegroundColor Green

# Check if Gemfile exists
if (-not (Test-Path "Gemfile")) {
    Write-Host "ERROR: Gemfile not found in current directory" -ForegroundColor Red
    exit 1
}

# Check if dependencies are installed
Write-Host "Checking dependencies..." -ForegroundColor Cyan
try {
    $null = bundle check 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Dependencies not installed. Installing now..." -ForegroundColor Yellow
        bundle install
        if ($LASTEXITCODE -ne 0) {
            Write-Host "ERROR: Failed to install dependencies" -ForegroundColor Red
            exit 1
        }
        Write-Host "Dependencies installed" -ForegroundColor Green
    } else {
        Write-Host "Dependencies are up to date" -ForegroundColor Green
    }
} catch {
    Write-Host "ERROR: Failed to check dependencies: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Security: Validate host binding (prevent binding to all interfaces in production)
if ($Production -and $BindHost -eq "0.0.0.0") {
    Write-Host "WARNING: Binding to 0.0.0.0 in production mode is not recommended." -ForegroundColor Yellow
    Write-Host "Consider using a specific IP address or reverse proxy." -ForegroundColor Yellow
}

# Build Jekyll command with proper escaping
$jekyllCommand = "bundle exec jekyll serve -l -H `"$BindHost`""

if ($Production) {
    $env:JEKYLL_ENV = "production"
    Write-Host "Running in PRODUCTION mode" -ForegroundColor Yellow
} else {
    # Ensure development mode for local development
    $env:JEKYLL_ENV = "development"
}

Write-Host ""
Write-Host "Your site will be available at: http://${BindHost}:4000" -ForegroundColor Green
Write-Host "Live reload is enabled (changes will auto-refresh)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Start Jekyll server with error handling
try {
    Invoke-Expression $jekyllCommand
} catch {
    Write-Host "ERROR: Failed to start Jekyll server: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
