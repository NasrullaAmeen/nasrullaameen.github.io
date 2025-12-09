#!/usr/bin/env bash
# Pre-Commit Security Check Script
# Run this before committing to check for sensitive data

STAGED_ONLY=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --staged-only)
            STAGED_ONLY=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo ""
echo "========================================"
echo "  Pre-Commit Security Check"
echo "========================================"
echo ""

# Get project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# Get files to check
if [ "$STAGED_ONLY" = true ]; then
    FILES=$(git diff --cached --name-only 2>/dev/null)
    if [ -z "$FILES" ]; then
        echo "No staged files to check."
        exit 0
    fi
    echo "Checking staged files only..."
else
    FILES=$(git diff --cached --name-only 2>/dev/null)
    if [ -z "$FILES" ]; then
        echo "No changes to check. Run 'git add .' first."
        exit 0
    fi
    echo "Checking all staged changes..."
fi

echo ""

ISSUES_FOUND=false
CHECKED_FILES=0

for file in $FILES; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    # Skip binary files
    extension="${file##*.}"
    case "$extension" in
        png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot|gem)
            continue
            ;;
    esac
    
    CHECKED_FILES=$((CHECKED_FILES + 1))
    
    # Check for sensitive patterns
    if grep -qiE "C:\\\\Users\\\\|/home/[^/]+|password\s*[:=]|secret\s*[:=]|api[_-]?key\s*[:=]|token\s*[:=]|\.env" "$file" 2>/dev/null; then
        ISSUES_FOUND=true
        echo "⚠ WARNING: $file"
        echo "   Contains potential sensitive data"
        echo ""
    fi
done

echo "========================================"
if [ "$ISSUES_FOUND" = true ]; then
    echo "⚠ Issues found! Review before committing."
    echo ""
    echo "Common fixes:"
    echo "  - Remove personal paths from example files"
    echo "  - Use placeholders (YourName, YourPath) instead"
    echo "  - Use environment variables for sensitive data"
    echo "  - Check docs/reference/PRE_COMMIT_CHECKLIST.md for details"
    exit 1
else
    echo "✓ Check complete! No obvious sensitive data found."
    echo "  Checked $CHECKED_FILES file(s)"
    echo ""
    echo "Remember to:"
    echo "  - Review git status before committing"
    echo "  - Verify obsidian/vault-config.json is NOT staged"
    echo "  - Check docs/reference/PRE_COMMIT_CHECKLIST.md for full checklist"
    exit 0
fi

