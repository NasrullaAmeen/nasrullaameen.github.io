# GitHub Publishing Guide

Quick guide for safely publishing this site to a public GitHub repository.

## ⚠️ Before You Commit

### Quick Check (30 seconds)

```powershell
# 1. Run the security check
.\scripts\check-before-commit.ps1

# 2. Verify sensitive files are ignored
git status --ignored | Select-String "vault-config.json|\.env"

# 3. Review what will be committed
git status
```

### Critical Files to NEVER Commit

- ❌ `obsidian/vault-config.json` (contains your personal vault path)
- ❌ `.env` or `.env.local` files
- ❌ Any files with API keys, tokens, or passwords
- ❌ `_site/` (build output)
- ❌ `node_modules/` (dependencies)

## ✅ Safe Files to Commit

- ✅ All Jekyll theme files
- ✅ Your posts in `_posts/`
- ✅ Documentation in `docs/`
- ✅ Scripts in `scripts/`
- ✅ `obsidian/vault-config.json.example` (template)
- ✅ `README.md`, `STRUCTURE.md`
- ✅ Configuration files (`.gitignore`, `.gitattributes`)

## 📋 Pre-Publish Checklist

1. **Run security check:**
   ```powershell
   .\scripts\check-before-commit.ps1
   ```

2. **Review configuration:**
   - [ ] `_config.yml` - No personal email (or use public one)
   - [ ] `obsidian/obsidian-shell-command.json` - Uses placeholder paths
   - [ ] No hardcoded personal paths in scripts

3. **Verify .gitignore:**
   ```bash
   git status --ignored
   ```
   Should show `obsidian/vault-config.json` as ignored

4. **Check staged files:**
   ```bash
   git status
   ```
   Should NOT include:
   - `obsidian/vault-config.json`
   - `.env` files
   - `_site/`
   - `node_modules/`

## 🚀 Publishing Steps

### First Time Setup

```bash
# 1. Initialize git (if not already done)
git init

# 2. Add remote repository
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git

# 3. Stage files
git add .

# 4. Verify what will be committed
git status

# 5. Run security check
.\scripts\check-before-commit.ps1

# 6. Commit
git commit -m "Initial commit: Jekyll site setup"

# 7. Push
git push -u origin master
```

### Regular Updates

```bash
# 1. Check changes
git status

# 2. Run security check
.\scripts\check-before-commit.ps1

# 3. Stage changes
git add .

# 4. Review staged changes
git diff --cached

# 5. Commit
git commit -m "Update: description of changes"

# 6. Push
git push
```

## 🔍 What Gets Committed?

### Automatically Excluded (via .gitignore)

- Build artifacts (`_site/`, `.jekyll-cache/`)
- Dependencies (`node_modules/`, `vendor/`)
- Personal config (`obsidian/vault-config.json`)
- Environment files (`.env*`)
- OS files (`.DS_Store`, `Thumbs.db`)
- IDE files (`.idea/`, most `.vscode/`)

### Always Committed

- Source code and templates
- Your blog posts
- Documentation
- Scripts (with placeholder paths)
- Configuration examples

## 🛡️ Security Best Practices

1. **Use environment variables** for sensitive data:
   ```powershell
   $env:JEKYLL_VAULT_PATH = "C:\Path\To\Vault"
   ```

2. **Use placeholders** in example files:
   - `YourName` instead of actual username
   - `C:\Users\YourName\` instead of actual path

3. **Review before committing:**
   - Always run `git status` first
   - Use the check script before each commit
   - Review `git diff` for sensitive data

4. **If you accidentally commit sensitive data:**
   - See [docs/setup/GITHUB_PUBLISH_CHECKLIST.md](docs/setup/GITHUB_PUBLISH_CHECKLIST.md)
   - Remove immediately and rotate any exposed secrets

## 📚 Additional Resources

- **Detailed checklist:** [../reference/PRE_COMMIT_CHECKLIST.md](../reference/PRE_COMMIT_CHECKLIST.md)
- **GitHub-specific guide:** [docs/setup/GITHUB_PUBLISH_CHECKLIST.md](docs/setup/GITHUB_PUBLISH_CHECKLIST.md)
- **Security guide:** [docs/reference/SECURITY.md](docs/reference/SECURITY.md)

## ⚡ Quick Commands

```powershell
# Check before committing
.\scripts\check-before-commit.ps1

# See what will be committed
git status

# See ignored files
git status --ignored

# Review changes
git diff --cached
```

