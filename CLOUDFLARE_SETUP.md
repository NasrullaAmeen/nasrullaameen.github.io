# Cloudflare Pages Setup - Quick Guide

Follow these steps to deploy your Jekyll site to Cloudflare Pages.

## Step 1: Update Gemfile (Already Done ✅)

The Gemfile has been updated to explicitly include Jekyll and the Chirpy theme.

## Step 2: Update Gemfile.lock

Run this command to update your Gemfile.lock:

```powershell
bundle lock --update
```

Then commit:

```powershell
git add Gemfile Gemfile.lock
git commit -m "Update Gemfile for Cloudflare Pages"
```

## Step 3: Push to GitHub

**First, make sure your repository exists on GitHub:**

1. Go to: https://github.com/new
2. Create repository: `nasrullaameen.github.io` (or any name)
3. **Don't** initialize with README
4. Copy the repository URL

Then update your remote and push:

```powershell
# If repository doesn't exist, create it first on GitHub
# Then update remote (replace with your actual repo URL):
git remote set-url origin https://github.com/YOUR-USERNAME/YOUR-REPO.git

# Push your code
git push -u origin master
```

## Step 4: Connect to Cloudflare Pages

1. **Go to Cloudflare Dashboard:**
   - Visit: https://dash.cloudflare.com/
   - Sign in or create account

2. **Navigate to Pages:**
   - Click "Workers & Pages" in sidebar
   - Click "Create application"
   - Select "Pages" → "Connect to Git"

3. **Authorize and Select Repository:**
   - Authorize Cloudflare to access GitHub
   - Select your repository

## Step 5: Configure Build Settings

**Important:** Use these exact settings:

| Field | Value |
|-------|-------|
| **Framework preset** | `Jekyll` (select from dropdown) |
| **Build command** | `jekyll build` |
| **Build output directory** | `_site` |
| **Environment variables** | `BUNDLE_WITHOUT = ""` (empty string) |

**Optional - Pin Ruby version:**
- Add: `RUBY_VERSION = 3.1` (or your preferred version)

## Step 6: Deploy

1. Enter project name (e.g., `nasrulla-docs`)
2. Select production branch: `master`
3. Click **"Save and Deploy"**

## Step 7: Wait for Build

- Build takes ~30 seconds to 2 minutes
- You'll get a URL: `https://your-project.pages.dev`
- Your site is now live! 🎉

## Step 8: (Optional) Custom Domain

1. In Cloudflare Pages → Your project
2. Click "Custom domains"
3. Click "Set up a custom domain"
4. Enter your domain
5. Follow DNS instructions (Cloudflare handles it automatically)

## Automatic Deployments

Every `git push` to your branch will:
- ✅ Trigger automatic build
- ✅ Deploy to production
- ✅ Create preview URLs for pull requests
- ✅ Provide instant rollback capability

## Troubleshooting

**Build fails?**
- Check build logs in Cloudflare dashboard
- Verify `Gemfile.lock` is committed
- Ensure `BUNDLE_WITHOUT = ""` is set

**Theme not loading?**
- Verify `jekyll-theme-chirpy` is in Gemfile
- Check `_config.yml` has `theme: jekyll-theme-chirpy`

**Assets not loading?**
- Update `url` in `_config.yml` to your Cloudflare Pages URL
- Commit and push changes

## That's It!

Your Jekyll site is now deployed on Cloudflare Pages with:
- 🌍 Global CDN
- 🔒 Free SSL
- ⚡ Fast performance
- 🔄 Automatic deployments

Happy deploying!

