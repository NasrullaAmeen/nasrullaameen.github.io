# GitHub Publishing Checklist

Use this checklist before publishing your site to a public GitHub repository.

## Pre-Publish Security Review

### 1. Personal Information Check

- [ ] **`_config.yml`** - Review for:
  - [ ] Email address (leave empty or use a public email)
  - [ ] Personal URLs
  - [ ] API keys or tokens (should be empty for public repo)
  - [ ] Personal names (if you want them public)

- [ ] **Configuration files** - Check:
  - [ ] No hardcoded personal paths
  - [ ] No API keys or secrets
  - [ ] No passwords or tokens

### 2. File Review

- [ ] **Run `git status`** to see what will be committed
- [ ] **Verify `.gitignore`** is working:
  ```bash
  git status --ignored
  ```
- [ ] **Check for sensitive files:**
  ```bash
  # Should NOT appear in git status
  - obsidian/vault-config.json
  - .env files
  - Personal notes
  ```

### 3. Sanitize Example Files

- [ ] **`obsidian/obsidian-shell-command.json`**:
  - [ ] Replace personal paths with placeholders
  - [ ] Use `YourName` instead of actual username
  - [ ] Use generic paths in examples

- [ ] **`obsidian/vault-config.json.example`**:
  - [ ] Already uses placeholder paths ✓
  - [ ] No personal information ✓

### 4. Content Review

- [ ] **`_posts/`** - Review posts for:
  - [ ] Personal information you don't want public
  - [ ] Internal URLs or paths
  - [ ] Sensitive data

- [ ] **`_tabs/about.md`** - Review for:
  - [ ] Personal contact information
  - [ ] Private details

## Git Commands Before First Push

```bash
# 1. Check what will be committed
git status

# 2. Review changes
git diff

# 3. If you see sensitive files, remove them
git rm --cached obsidian/vault-config.json
git rm --cached .env

# 4. Verify .gitignore is working
git status --ignored

# 5. Stage only safe files
git add .

# 6. Review staged changes
git diff --cached

# 7. Commit
git commit -m "Initial commit: Jekyll site setup"

# 8. Push (after setting up remote)
git push -u origin master
```

## Safe Files to Commit

✅ **Safe to commit:**
- All Jekyll theme files (`_layouts/`, `_includes/`, `_sass/`)
- Your posts in `_posts/` (reviewed for personal info)
- Documentation in `docs/`
- Scripts in `scripts/` (no hardcoded personal paths)
- Configuration examples (`vault-config.json.example`)
- `README.md`, `STRUCTURE.md`
- `Gemfile`, `package.json`
- `.gitignore`, `.gitattributes`

❌ **Never commit:**
- `obsidian/vault-config.json` (personal vault path)
- `.env` files
- `_site/` (build output)
- `node_modules/`
- `.jekyll-cache/`
- Personal notes or drafts
- OS files (`.DS_Store`, `Thumbs.db`)

## After Publishing

1. **Verify repository:**
   - Check GitHub repository
   - Ensure sensitive files are not visible
   - Review file list

2. **Test site:**
   - Enable GitHub Pages
   - Verify site builds correctly
   - Check all links work

3. **Monitor:**
   - Check for any accidentally committed sensitive data
   - Review commit history

## If You Accidentally Commit Sensitive Data

**Immediate action:**

1. **Remove from repository:**
   ```bash
   git rm --cached sensitive-file
   git commit -m "Remove sensitive file"
   git push
   ```

2. **Add to .gitignore:**
   ```bash
   echo "sensitive-file" >> .gitignore
   git add .gitignore
   git commit -m "Add sensitive file to gitignore"
   git push
   ```

3. **For already pushed sensitive data:**
   - Use GitHub's guide: [Removing sensitive data](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
   - Consider using `git filter-branch` or BFG Repo-Cleaner
   - **Important:** If you pushed secrets, rotate/revoke them immediately

## Quick Verification Script

Create a file `check-before-commit.ps1`:

```powershell
# Check for common sensitive patterns
Write-Host "Checking for sensitive data..." -ForegroundColor Yellow

$sensitivePatterns = @(
    "C:\\Users\\",
    "/home/",
    "password",
    "secret",
    "api[_-]?key",
    "token",
    "darko"  # Your username - add others
)

$files = git diff --cached --name-only
foreach ($file in $files) {
    $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
    if ($content) {
        foreach ($pattern in $sensitivePatterns) {
            if ($content -match $pattern) {
                Write-Host "WARNING: $file contains '$pattern'" -ForegroundColor Red
            }
        }
    }
}

Write-Host "Check complete!" -ForegroundColor Green
```

Run before committing:
```powershell
.\check-before-commit.ps1
```

