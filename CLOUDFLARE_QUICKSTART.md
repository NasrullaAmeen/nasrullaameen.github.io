# Cloudflare Pages Quick Start

## 5-Minute Setup Guide

### Step 1: Push to Git
```bash
git add .
git commit -m "Ready for Cloudflare Pages"
git push origin master
```

### Step 2: Connect to Cloudflare

1. Go to: https://dash.cloudflare.com/
2. Click "Workers & Pages" → "Create application" → "Pages"
3. Click "Connect to Git"
4. Authorize and select your repository

### Step 3: Configure Build

**Framework:** Jekyll (auto-detected)

**Build command:**
```
bundle install && bundle exec jekyll build
```

**Output directory:**
```
_site
```

**Environment variables:**
- `JEKYLL_ENV` = `production`

### Step 4: Deploy

1. Enter project name
2. Select production branch (`master`)
3. Click "Save and Deploy"

### Step 5: Done!

Your site will be live at: `https://your-project.pages.dev`

## Custom Domain (Optional)

1. In Pages dashboard → "Custom domains"
2. Add your domain
3. Update DNS as instructed
4. SSL is automatic!

## That's It!

Cloudflare will automatically:
- ✅ Build on every push
- ✅ Create previews for PRs
- ✅ Provide free SSL
- ✅ Serve via global CDN

For detailed information, see [CLOUDFLARE_DEPLOYMENT.md](CLOUDFLARE_DEPLOYMENT.md)

