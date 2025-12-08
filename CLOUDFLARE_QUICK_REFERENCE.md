# Cloudflare Pages - Quick Reference

## ✅ Step 1: Gemfile Ready (DONE)

Your Gemfile has been updated and Gemfile.lock has been refreshed.

## 📝 Step 2: Commit and Push

```powershell
git add Gemfile Gemfile.lock
git commit -m "Update Gemfile for Cloudflare Pages"
git push origin master
```

**Note:** Make sure your GitHub repository exists first. If not:
1. Go to https://github.com/new
2. Create repository (don't initialize with README)
3. Update remote: `git remote set-url origin https://github.com/YOUR-USERNAME/YOUR-REPO.git`

## 🚀 Step 3: Cloudflare Pages Configuration

When connecting your repo to Cloudflare Pages, use these **exact** settings:

| Dashboard Field | Value |
|----------------|-------|
| **Framework preset** | `Jekyll` (select from dropdown) |
| **Build command** | `jekyll build` |
| **Build output directory** | `_site` |
| **Environment variables** | `BUNDLE_WITHOUT = ""` (empty string) |

**Optional:** Add `RUBY_VERSION = 3.1` if you want to pin Ruby version.

## 🎯 Step 4: Deploy

1. Click **"Save and Deploy"**
2. Wait ~30 seconds
3. Get your URL: `https://your-project.pages.dev`

## ✨ That's It!

Every `git push` will automatically:
- Build your site
- Deploy to production
- Create preview URLs for PRs
- Provide instant rollback

## 🔧 Current Setup

- ✅ Gemfile updated with Jekyll and Chirpy theme
- ✅ Gemfile.lock updated
- ✅ Theme configured in `_config.yml`
- ✅ Ready for Cloudflare Pages

## 📋 Next Steps

1. **Push to GitHub** (if repository exists)
2. **Connect to Cloudflare Pages**
3. **Use the settings above**
4. **Deploy!**

For detailed instructions, see [CLOUDFLARE_SETUP.md](CLOUDFLARE_SETUP.md)

