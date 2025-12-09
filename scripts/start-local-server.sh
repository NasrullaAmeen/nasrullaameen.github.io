#!/usr/bin/env bash
#
# Local Jekyll Server Startup Script
# This script starts the Jekyll development server for local preview

HOST="127.0.0.1"
PRODUCTION=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -H|--host)
            HOST="$2"
            shift 2
            ;;
        -p|--production)
            PRODUCTION=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  -H, --host HOST      Host to bind to (default: 127.0.0.1)"
            echo "  -p, --production     Run Jekyll in production mode"
            echo "  -h, --help           Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo "🚀 Starting Jekyll local server..."
echo ""

# Check if bundle is installed
if ! command -v bundle &> /dev/null; then
    echo "✗ Bundler not found. Please install Ruby and Bundler first."
    echo "  Install Ruby from: https://www.ruby-lang.org/en/downloads/"
    echo "  Then run: gem install bundler"
    exit 1
fi

echo "✓ Bundler found"

# Check if Gemfile exists
if [ ! -f "Gemfile" ]; then
    echo "✗ Gemfile not found in current directory"
    exit 1
fi

# Check if dependencies are installed
if [ ! -f "Gemfile.lock" ]; then
    echo "⚠ Dependencies not installed. Installing now..."
    bundle install
    if [ $? -ne 0 ]; then
        echo "✗ Failed to install dependencies"
        exit 1
    fi
    echo "✓ Dependencies installed"
fi

# Build Jekyll command
JEKYLL_CMD="bundle exec jekyll serve -l -H $HOST"

if [ "$PRODUCTION" = true ]; then
    export JEKYLL_ENV=production
    echo "⚠ Running in PRODUCTION mode"
fi

echo ""
echo "Your site will be available at: http://${HOST}:4000"
echo "Live reload is enabled (changes will auto-refresh)"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start Jekyll server
eval "$JEKYLL_CMD"

