#!/usr/bin/env bash
#
# Sync Script: Vault Publish Folder to Jekyll _posts
# This script copies markdown files from your vault's Publish folder to the Jekyll _posts directory
# Security: Includes path validation, input sanitization, and safe file operations

set -euo pipefail  # Exit on error, undefined vars, pipe failures

VAULT_PATH=""
WATCH=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--vault)
            VAULT_PATH="$2"
            shift 2
            ;;
        -w|--watch)
            WATCH=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  -v, --vault PATH    Path to your vault directory"
            echo "  -w, --watch         Watch for changes and auto-sync"
            echo "  -h, --help          Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_FILE="$PROJECT_ROOT/obsidian/vault-config.json"

# Load configuration
if [ -f "$CONFIG_FILE" ]; then
    if command -v jq &> /dev/null; then
        if [ -z "$VAULT_PATH" ]; then
            VAULT_PATH=$(jq -r '.vaultPath' "$CONFIG_FILE")
        fi
        PUBLISH_FOLDER=$(jq -r '.publishFolder' "$CONFIG_FILE")
        POSTS_FOLDER=$(jq -r '.postsFolder' "$CONFIG_FILE")
        AUTO_DATE=$(jq -r '.autoDate' "$CONFIG_FILE")
        OVERWRITE=$(jq -r '.overwriteExisting' "$CONFIG_FILE")
    else
        echo "WARNING: jq not found. Using defaults. Install jq for full config support."
        PUBLISH_FOLDER="Publish"
        POSTS_FOLDER="_posts"
        AUTO_DATE=true
        OVERWRITE=false
    fi
else
    echo "ERROR: vault-config.json not found. Please create it first."
    exit 1
fi

# Check environment variable first (more secure)
if [ -z "$VAULT_PATH" ] && [ -n "${JEKYLL_VAULT_PATH:-}" ]; then
    VAULT_PATH="$JEKYLL_VAULT_PATH"
    echo "Using vault path from environment variable" >&2
fi

if [ -z "$VAULT_PATH" ]; then
    echo "ERROR: Vault path not configured." >&2
    echo "Set 'vaultPath' in vault-config.json or use -v/--vault parameter" >&2
    echo "Or set environment variable: export JEKYLL_VAULT_PATH=/path/to/vault" >&2
    echo "" >&2
    echo "Example: $0 --vault /path/to/your/vault" >&2
    exit 1
fi

# Security: Validate vault path exists and is a directory
if [ ! -d "$VAULT_PATH" ]; then
    echo "ERROR: Vault path does not exist or is not a directory: $VAULT_PATH" >&2
    exit 1
fi

PUBLISH_DIR="$VAULT_PATH/$PUBLISH_FOLDER"
POSTS_DIR="$SCRIPT_DIR/$POSTS_FOLDER"

# Check if vault publish folder exists
if [ ! -d "$PUBLISH_DIR" ]; then
    echo "ERROR: Publish folder not found at: $PUBLISH_DIR"
    echo "Please check your vault path and ensure the 'Publish' folder exists."
    exit 1
fi

# Ensure _posts folder exists
mkdir -p "$POSTS_DIR"

# Security: Validate file is within publish directory
is_safe_path() {
    local file_path="$1"
    local base_path="$2"
    # Resolve paths and check if file is within base
    local resolved_file
    local resolved_base
    if command -v realpath &> /dev/null; then
        resolved_file=$(realpath "$file_path" 2>/dev/null || echo "$file_path")
        resolved_base=$(realpath "$base_path" 2>/dev/null || echo "$base_path")
    else
        # Fallback: use cd to resolve paths
        resolved_file=$(cd "$(dirname "$file_path")" && pwd)/$(basename "$file_path")
        resolved_base=$(cd "$base_path" && pwd)
    fi
    [[ "$resolved_file" == "$resolved_base"/* ]]
}

# Security: Sanitize filename
sanitize_filename() {
    local title="$1"
    # Remove dangerous characters and create safe slug
    echo "$title" | tr '[:upper:]' '[:lower:]' | \
        sed 's/[^a-z0-9]/-/g' | \
        sed 's/--*/-/g' | \
        sed 's/^-\|-$//g' | \
        head -c 200  # Limit length
}

sync_file() {
    local source_file="$1"
    
    # Security: Validate file exists
    if [ ! -f "$source_file" ]; then
        echo "  WARNING: Source file not found: $source_file" >&2
        return 1
    fi
    
    # Security: Validate file extension
    if [[ ! "$source_file" =~ \.(md|markdown)$ ]]; then
        echo "  SKIP: Invalid file type (not .md or .markdown): $source_file" >&2
        return 1
    fi
    
    # Security: Validate file is within publish directory
    if ! is_safe_path "$source_file" "$PUBLISH_DIR"; then
        echo "  SECURITY: Skipping file outside publish folder: $source_file" >&2
        return 1
    fi
    
    local filename=$(basename "$source_file")
    
    # Security: Check file size (10MB limit)
    local file_size=$(stat -f%z "$source_file" 2>/dev/null || stat -c%s "$source_file" 2>/dev/null || echo "0")
    local max_size=$((10 * 1024 * 1024))
    if [ "$file_size" -gt "$max_size" ]; then
        echo "  SKIP: File too large (>10MB): $filename" >&2
        return 1
    fi
    
    local content=$(cat "$source_file")
    
    # Extract date from front matter or use current date
    local date=$(date +"%Y-%m-%d")
    if echo "$content" | grep -q "^date:"; then
        date=$(echo "$content" | grep "^date:" | sed -E 's/.*date:\s*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
    fi
    
    # Extract title from front matter or use filename
    local title=$(echo "$filename" | sed 's/\.md$//' | sed 's/\.markdown$//')
    if echo "$content" | grep -q "^title:"; then
        title=$(echo "$content" | grep "^title:" | sed -E "s/.*title:\s*['\"]?([^'\"]+)['\"]?.*/\1/")
    fi
    
    # Security: Sanitize title for filename
    local title_slug=$(sanitize_filename "$title")
    
    # Ensure not empty
    if [ -z "$title_slug" ]; then
        title_slug="untitled"
    fi
    
    # Create destination filename
    local dest_filename="$date-$title_slug.md"
    local dest_path="$POSTS_DIR/$dest_filename"
    
    # Security: Final path validation
    if ! is_safe_path "$dest_path" "$POSTS_DIR"; then
        echo "  SECURITY: Invalid destination path, skipping: $dest_filename" >&2
        return 1
    fi
    
    # Check if file exists
    if [ -f "$dest_path" ] && [ "$OVERWRITE" != "true" ]; then
        echo "  SKIP: $dest_filename (already exists)"
        return
    fi
    
    # Copy file with error handling
    if cp "$source_file" "$dest_path" 2>/dev/null; then
    echo "  SYNCED: $filename -> $dest_filename"
    else
        echo "  ERROR: Failed to copy file: $filename" >&2
        return 1
    fi
}

sync_all() {
    echo "Syncing files from vault..."
    echo "  Source: $PUBLISH_DIR"
    echo "  Destination: $POSTS_DIR"
    echo ""
    
    local files=("$PUBLISH_DIR"/*.md)
    if [ ! -f "${files[0]}" ]; then
        echo "No markdown files found in Publish folder."
        return
    fi
    
    local synced_count=0
    local error_count=0
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            if sync_file "$file"; then
            ((synced_count++))
            else
                ((error_count++))
            fi
        fi
    done
    
    echo ""
    if [ $error_count -eq 0 ]; then
    echo "Sync complete! Processed $synced_count file(s)."
    else
        echo "Sync complete with errors. Processed $synced_count file(s), $error_count error(s)." >&2
    fi
}

if [ "$WATCH" = true ]; then
    echo "Watching for changes in: $PUBLISH_DIR"
    echo "Press Ctrl+C to stop watching"
    echo ""
    
    # Initial sync
    sync_all
    
    # Watch for changes (requires inotify-tools on Linux)
    if command -v inotifywait &> /dev/null; then
        inotifywait -m -e create,modify,close_write --format '%w%f' "$PUBLISH_DIR" | while read file; do
            if [[ "$file" == *.md ]]; then
                echo "[CHANGED] $file"
                sleep 1
                sync_file "$file"
            fi
        done
    elif command -v fswatch &> /dev/null; then
        # macOS alternative
        fswatch -o "$PUBLISH_DIR" | while read f; do
            for file in "$PUBLISH_DIR"/*.md; do
                if [ -f "$file" ]; then
                    echo "[CHANGED] $file"
                    sync_file "$file"
                fi
            done
        done
    else
        echo "ERROR: No file watcher found. Install inotify-tools (Linux) or fswatch (macOS)"
        echo "Falling back to manual sync mode."
        sync_all
    fi
else
    sync_all
fi

