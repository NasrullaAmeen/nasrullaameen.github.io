# GitHub Repository Setup

## Option 1: Create New Repository on GitHub

1. **Go to GitHub:**
   - Visit: https://github.com/new
   - Sign in to your account

2. **Create Repository:**
   - Repository name: `nasrullaameen.github.io` (or any name you prefer)
   - Description: "My Jekyll documentation site"
   - Visibility: **Public** (required for free GitHub Pages) or **Private**
   - **DO NOT** initialize with README, .gitignore, or license
   - Click "Create repository"

3. **After creation, GitHub will show you commands. Use these:**

   ```bash
   git remote remove origin
   git remote add origin https://github.com/NasrullaAmeen/nasrullaameen.github.io.git
   git branch -M master
   git push -u origin master
   ```

   (Replace `NasrullaAmeen` with your actual GitHub username if different)

## Option 2: Update Remote URL

If the repository exists but the URL is wrong:

```bash
# Check current remote
git remote -v

# Update remote URL (replace with correct URL)
git remote set-url origin https://github.com/YOUR-USERNAME/YOUR-REPO.git

# Verify
git remote -v
```

## Option 3: Use Different Repository Name

If you want to use a different repository name:

```bash
# Remove current remote
git remote remove origin

# Add new remote (replace with your repo URL)
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git

# Push
git push -u origin master
```

## Authentication

If you get authentication errors:

1. **Use Personal Access Token:**
   - Go to: https://github.com/settings/tokens
   - Generate new token (classic)
   - Select scopes: `repo`
   - Copy the token
   - Use it as password when pushing

2. **Or use SSH:**
   ```bash
   git remote set-url origin git@github.com:YOUR-USERNAME/YOUR-REPO.git
   ```

## After Repository is Set Up

Once your repository is created and connected:

1. **Push your code:**
   ```bash
   git push -u origin master
   ```

2. **Then proceed with Cloudflare Pages:**
   - Go to Cloudflare Dashboard
   - Connect to your GitHub repository
   - Deploy!

