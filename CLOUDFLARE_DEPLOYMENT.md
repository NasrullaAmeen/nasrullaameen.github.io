# Cloudflare Pages Deployment Guide

This guide explains how to deploy your Jekyll site to Cloudflare Pages.

## Why Cloudflare Pages?

- **Free**: Generous free tier with unlimited bandwidth
- **Fast**: Global CDN with edge locations worldwide
- **Automatic HTTPS**: SSL certificates included
- **Custom Domains**: Free custom domain support
- **Preview Deployments**: Automatic previews for pull requests
- **Build Integration**: Automatic builds on git push

## Prerequisites

- A Cloudflare account (free)
- Your Jekyll site in a Git repository (GitHub, GitLab, or Bitbucket)
- Ruby and Bundler installed locally (for testing)

## Step 1: Prepare Your Repository

Make sure your site is pushed to a Git repository:

```bash
git add .
git commit -m "Prepare for Cloudflare Pages deployment"
git push origin master
```

## Step 2: Connect to Cloudflare Pages

1. **Go to Cloudflare Dashboard:**
   - Visit: https://dash.cloudflare.com/
   - Sign in or create a free account

2. **Navigate to Pages:**
   - Click "Workers & Pages" in the sidebar
   - Click "Create application"
   - Select "Pages" → "Connect to Git"

3. **Connect Your Repository:**
   - Authorize Cloudflare to access your Git provider
   - Select your repository (`nasrullaameen.github.io`)
   - Click "Begin setup"

## Step 3: Configure Build Settings

Cloudflare Pages can auto-detect Jekyll, but you can customize:

**Framework preset:** Jekyll (auto-detected)

**Build command:**
```bash
bundle install && bundle exec jekyll build
```

**Build output directory:**
```
_site
```

**Environment variables:**
- `JEKYLL_ENV` = `production`
- `RUBY_VERSION` = `3.1` (or your preferred version)

## Step 4: Deploy

1. **Project name:** Enter a name (e.g., `nasrulla-docs`)
2. **Production branch:** `master` or `main`
3. **Click "Save and Deploy"**

Cloudflare will:
- Install dependencies
- Build your Jekyll site
- Deploy to a `*.pages.dev` URL

## Step 5: Access Your Site

After deployment, you'll get a URL like:
- `https://your-project-name.pages.dev`

You can find this in the Cloudflare Pages dashboard.

## Custom Domain Setup

1. **In Cloudflare Pages:**
   - Go to your project
   - Click "Custom domains"
   - Click "Set up a custom domain"

2. **Add Your Domain:**
   - Enter your domain name
   - Follow DNS configuration instructions
   - Cloudflare will automatically provision SSL

## Automatic Deployments

Cloudflare Pages automatically:
- **Deploys on push** to your production branch
- **Creates preview deployments** for pull requests
- **Runs builds** on every commit

## Build Configuration

The `cloudflare-pages.toml` file in your repository contains build settings. Cloudflare will use these automatically.

### Custom Build Command

If you need a custom build command, update `cloudflare-pages.toml`:

```toml
[build]
command = "bundle install && bundle exec jekyll build"
output_directory = "_site"
```

### Environment Variables

Add environment variables in Cloudflare Pages dashboard:
- Go to your project → Settings → Environment variables
- Add variables like:
  - `JEKYLL_ENV` = `production`
  - `RUBY_VERSION` = `3.1`

## Troubleshooting

### Build Fails

**Issue:** Build command fails
- **Solution:** Check build logs in Cloudflare dashboard
- Ensure `Gemfile` and `Gemfile.lock` are committed
- Verify Ruby version compatibility

**Issue:** Dependencies not found
- **Solution:** Make sure `Gemfile.lock` is committed
- Check that all gems are specified in `Gemfile`

**Issue:** Site not updating
- **Solution:** Check build logs for errors
- Verify `_config.yml` URL settings
- Clear Cloudflare cache if needed

### Site Not Loading

**Issue:** 404 errors
- **Solution:** Verify `output_directory` is `_site`
- Check that Jekyll build completed successfully
- Review build logs

**Issue:** Assets not loading
- **Solution:** Check `baseurl` in `_config.yml`
- Verify asset paths are correct
- Check Cloudflare cache settings

## Advanced Configuration

### Custom Build Script

Create a `build.sh` script:

```bash
#!/bin/bash
set -e
bundle install
bundle exec jekyll build
```

Then update `cloudflare-pages.toml`:

```toml
[build]
command = "bash build.sh"
output_directory = "_site"
```

### Preview Deployments

Cloudflare automatically creates preview deployments for:
- Pull requests
- Feature branches

Access previews in:
- Pull request comments (if GitHub integration enabled)
- Cloudflare Pages dashboard

### Cache Configuration

Optimize caching in `_headers` file (in `_site` after build):

```
/*
  Cache-Control: public, max-age=3600
```

Or configure in Cloudflare dashboard → Rules → Page Rules.

## Performance Tips

1. **Enable Auto Minify:**
   - Cloudflare Dashboard → Speed → Optimization
   - Enable: JavaScript, CSS, HTML

2. **Enable Brotli:**
   - Cloudflare Dashboard → Speed → Optimization
   - Enable Brotli compression

3. **Image Optimization:**
   - Use Cloudflare Images (if available)
   - Optimize images before uploading

## Monitoring

- **Analytics:** Available in Cloudflare Pages dashboard
- **Build Logs:** View in project → Deployments
- **Web Analytics:** Enable in Cloudflare dashboard

## Resources

- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Cloudflare Community](https://community.cloudflare.com/)

## Quick Reference

**Deploy Command:** Automatic on git push

**Build Time:** ~2-5 minutes (first build may take longer)

**Deployment URL:** `https://your-project.pages.dev`

**Custom Domain:** Free SSL included

---

**Note:** Make sure your `_config.yml` has the correct `url` set for production:

```yaml
url: "https://your-project.pages.dev"
# or your custom domain
url: "https://yourdomain.com"
```

