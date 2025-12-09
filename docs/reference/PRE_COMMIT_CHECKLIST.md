# Pre-Commit Checklist for Public Repository

Use this checklist before committing to ensure only necessary files are uploaded to your public GitHub repository.

## ✅ Files to Commit

### Required Files
- [ ] `_config.yml` (review for personal info)
- [ ] `_posts/` (your blog posts)
- [ ] `_tabs/` (about, archives, etc.)
- [ ] `_layouts/`, `_includes/`, `_sass/` (theme files)
- [ ] `assets/` (images, CSS, JS - no personal images)
- [ ] `docs/` (documentation)
- [ ] `scripts/` (utility scripts)
- [ ] `obsidian/` (templates and examples, NOT vault-config.json)
- [ ] `README.md`, `STRUCTURE.md`
- [ ] `Gemfile`, `package.json` (dependency files)
- [ ] Configuration files (`.gitignore`, `LICENSE`, etc.)

### Example/Template Files (Safe to Commit)
- [ ] `obsidian/vault-config.json.example`
- [ ] `obsidian/obsidian-publish-template.md`
- [ ] `obsidian/obsidian-shell-command.json` (review paths)

## ❌ Files to NEVER Commit

### Personal/Sensitive Information
- [ ] `obsidian/vault-config.json` (contains your vault path)
- [ ] `.env` or `.env.local` files
- [ ] Any files with API keys, tokens, or passwords
- [ ] Personal notes or drafts
- [ ] System-specific paths in scripts

### Build Artifacts
- [ ] `_site/` (generated site)
- [ ] `.jekyll-cache/`
- [ ] `node_modules/`
- [ ] `vendor/`
- [ ] `*.gem` files

### OS/IDE Files
- [ ] `.DS_Store` (macOS)
- [ ] `Thumbs.db` (Windows)
- [ ] `.idea/` (IntelliJ)
- [ ] `.vscode/` (except allowed settings)

## 🔍 Pre-Commit Review

### 1. Check for Personal Information

Review these files for personal information:

- [ ] `_config.yml`
  - [ ] Email addresses (optional, can be empty)
  - [ ] Personal paths
  - [ ] API keys or tokens (should be empty or use environment variables)

- [ ] `obsidian/obsidian-shell-command.json`
  - [ ] Hardcoded paths (should use placeholders or environment variables)
  - [ ] Personal usernames in paths

- [ ] Scripts in `scripts/`
  - [ ] Hardcoded personal paths
  - [ ] Personal usernames

### 2. Sanitize Configuration Files

Before committing, ensure:

- [ ] `_config.yml`:
  ```yaml
  # Good - empty or placeholder
  email: 
  url: ""
  
  # Bad - personal information
  email: your.email@example.com
  url: "https://your-personal-site.com"
  ```

- [ ] `obsidian/obsidian-shell-command.json`:
  ```json
  // Good - placeholder path
  "shell_command": "powershell.exe -File \"C:\\Users\\YourName\\Documents\\GitHub\\site\\scripts\\sync-from-vault.ps1\""
  
  // Better - use environment variable or relative path
  ```

### 3. Verify .gitignore

- [ ] Run: `git status` to see what will be committed
- [ ] Verify sensitive files are not listed
- [ ] Check that `obsidian/vault-config.json` is ignored
- [ ] Ensure build artifacts are ignored

### 4. Test Before Committing

- [ ] Run: `git status` to preview changes
- [ ] Review: `git diff` for any sensitive data
- [ ] Test: Site builds correctly with `bundle exec jekyll build`

## 🚨 Quick Check Command

Before committing, run this to see what will be committed:

```powershell
# PowerShell
git status
git diff --cached

# Check for common sensitive patterns
git diff --cached | Select-String -Pattern "C:\\Users|/home/|password|secret|key|token" -CaseSensitive
```

```bash
# Bash
git status
git diff --cached

# Check for common sensitive patterns
git diff --cached | grep -i "C:\\Users\|/home/\|password\|secret\|key\|token"
```

## 📝 Recommended Workflow

1. **Before first commit:**
   ```bash
   # Review what will be committed
   git status
   
   # Remove any sensitive files if accidentally added
   git rm --cached obsidian/vault-config.json
   git rm --cached .env
   ```

2. **Before each commit:**
   - Review `git status` output
   - Check for personal paths or information
   - Verify `.gitignore` is working

3. **If you accidentally commit sensitive data:**
   ```bash
   # Remove from git but keep locally
   git rm --cached sensitive-file
   
   # Add to .gitignore
   echo "sensitive-file" >> .gitignore
   
   # Commit the removal
   git commit -m "Remove sensitive file"
   ```

## 🔐 Security Reminders

- **Never commit:**
  - Personal vault paths
  - API keys or tokens
  - Passwords
  - Email addresses (unless you want them public)
  - Personal file paths
  - System-specific configurations

- **Use environment variables for:**
  - Vault paths
  - API keys
  - Sensitive configuration

- **Review before pushing:**
  - Check `git log` for previous commits
  - Use `git show` to review changes
  - Consider using `git secrets` or similar tools

## 📚 Additional Resources

- See [docs/reference/SECURITY.md](docs/reference/SECURITY.md) for security best practices
- GitHub's guide: [Removing sensitive data from a repository](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)

