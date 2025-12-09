# Analytics Setup Guide

This guide explains how to configure analytics for your Jekyll site using various providers.

## Available Analytics Options

The Chirpy theme supports multiple analytics providers:
- Google Analytics
- Cloudflare Web Analytics
- GoatCounter
- Umami
- Matomo
- Fathom

## Option 1: Google Analytics

### Setup

1. **Create Google Analytics Account:**
   - Go to: https://analytics.google.com/
   - Create account and property
   - Get your Measurement ID (format: `G-XXXXXXXXXX`)

2. **Configure in _config.yml:**
   ```yaml
   analytics:
     google:
       id: G-XXXXXXXXXX  # Your Measurement ID
   ```

3. **Commit and push:**
   ```bash
   git add _config.yml
   git commit -m "Add Google Analytics"
   git push
   ```

### Features
- Comprehensive analytics
- Real-time data
- Audience insights
- Free tier available

## Option 2: Cloudflare Web Analytics

### Setup

1. **Enable in Cloudflare Dashboard:**
   - Go to your Cloudflare dashboard
   - Navigate to Analytics & Logs → Web Analytics
   - Create a new site
   - Copy the token

2. **Configure in _config.yml:**
   ```yaml
   analytics:
     cloudflare:
       id: your-token-here
   ```

### Features
- Privacy-focused (no cookies)
- Free tier
- Simple setup
- Fast loading

## Option 3: GoatCounter

### Setup

1. **Sign up for GoatCounter:**
   - Go to: https://www.goatcounter.com/
   - Create account
   - Add your site
   - Get your site code

2. **Configure in _config.yml:**
   ```yaml
   analytics:
     goatcounter:
       id: your-site-code
   
   # Optional: Enable page views
   pageviews:
     provider: goatcounter
   ```

### Features
- Privacy-friendly
- Open source
- Free tier available
- Lightweight

## Option 4: Umami

### Setup (Self-Hosted)

1. **Deploy Umami:**
   - Self-host Umami instance
   - Or use Umami Cloud
   - Get your website ID

2. **Configure in _config.yml:**
   ```yaml
   analytics:
     umami:
       id: your-website-id
       domain: https://analytics.yourdomain.com
   ```

### Features
- Self-hosted option
- Privacy-focused
- Open source
- Beautiful dashboard

## Option 5: Matomo

### Setup (Self-Hosted)

1. **Deploy Matomo:**
   - Self-host Matomo instance
   - Create site in Matomo
   - Get site ID

2. **Configure in _config.yml:**
   ```yaml
   analytics:
     matomo:
       id: your-site-id
       domain: https://matomo.yourdomain.com
   ```

### Features
- Full-featured analytics
- Self-hosted
- Privacy-focused
- GDPR compliant

## Option 6: Fathom

### Setup

1. **Sign up for Fathom:**
   - Go to: https://usefathom.com/
   - Create account
   - Add your site
   - Get site ID

2. **Configure in _config.yml:**
   ```yaml
   analytics:
     fathom:
       id: your-site-id
   ```

### Features
- Privacy-focused
- GDPR compliant
- Simple interface
- Paid service

## Recommended Setup

### For Privacy-Conscious Users
- **GoatCounter** or **Cloudflare Web Analytics**
- No cookies required
- Privacy-friendly

### For Comprehensive Analytics
- **Google Analytics**
- Most features
- Industry standard

### For Self-Hosted
- **Umami** or **Matomo**
- Full control
- Privacy-focused

## Configuration Example

Here's a complete example for Google Analytics:

```yaml
# In _config.yml
analytics:
  google:
    id: G-XXXXXXXXXX  # Your Google Analytics ID

# Optional: Enable page views (if using GoatCounter)
pageviews:
  provider: goatcounter
```

## Testing Analytics

1. **Deploy your changes:**
   ```bash
   git add _config.yml
   git commit -m "Configure analytics"
   git push
   ```

2. **Wait for deployment** (usually 1-2 minutes)

3. **Visit your site** and navigate around

4. **Check analytics dashboard:**
   - Should show your visit within a few minutes
   - Real-time data may take longer

## Privacy Considerations

### GDPR Compliance
- Inform users about analytics (privacy policy)
- Consider cookie consent if required
- Use privacy-friendly options when possible

### Privacy-Friendly Options
- GoatCounter (no cookies)
- Cloudflare Web Analytics (no cookies)
- Umami (privacy-focused)
- Fathom (privacy-focused)

## Disabling Analytics

To disable analytics, simply remove or comment out the configuration:

```yaml
# analytics:
#   google:
#     id: 
```

## Resources

- [Google Analytics](https://analytics.google.com/)
- [Cloudflare Web Analytics](https://www.cloudflare.com/web-analytics/)
- [GoatCounter](https://www.goatcounter.com/)
- [Umami](https://umami.is/)
- [Matomo](https://matomo.org/)
- [Fathom](https://usefathom.com/)

---

**Note:** Choose the analytics provider that best fits your privacy requirements and needs.

