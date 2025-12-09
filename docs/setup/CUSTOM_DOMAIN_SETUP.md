# Custom Domain Setup for GitHub Pages

This guide explains how to add a custom domain to your GitHub Pages site.

## Prerequisites

- A domain name (purchased from any registrar)
- Access to your domain's DNS settings
- Your GitHub Pages site already deployed

## Step 1: Configure Domain in GitHub

1. **Go to your repository:**
   - Navigate to: `https://github.com/nasrullaameen/nasrullaameen.github.io`
   - Click **Settings** → **Pages**

2. **Add Custom Domain:**
   - In the "Custom domain" section, enter your domain
   - Example: `docs.yourdomain.com` or `yourdomain.com`
   - Click **Save**

3. **GitHub will create a CNAME file:**
   - This file will be automatically created in your repository
   - It contains your domain name

## Step 2: Configure DNS

### Option A: Apex Domain (yourdomain.com)

If you want to use the root domain:

**DNS Records to Add:**
```
Type: A
Name: @
Value: 185.199.108.153

Type: A
Name: @
Value: 185.199.109.153

Type: A
Name: @
Value: 185.199.110.153

Type: A
Name: @
Value: 185.199.111.153
```

**Or use ALIAS/CNAME (if supported):**
```
Type: ALIAS (or CNAME)
Name: @
Value: nasrullaameen.github.io
```

### Option B: Subdomain (docs.yourdomain.com)

**DNS Record:**
```
Type: CNAME
Name: docs
Value: nasrullaameen.github.io
```

## Step 3: Update _config.yml

Update your site configuration:

```yaml
url: "https://yourdomain.com"  # or https://docs.yourdomain.com
```

## Step 4: Enable HTTPS

1. **Wait for DNS propagation** (can take up to 48 hours, usually much faster)
2. **GitHub will automatically provision SSL certificate**
3. **Check in Settings → Pages:**
   - "Enforce HTTPS" option will appear
   - Enable it once available

## Step 5: Verify Setup

1. **Check DNS propagation:**
   ```bash
   # For apex domain
   dig yourdomain.com
   
   # For subdomain
   dig docs.yourdomain.com
   ```

2. **Test your site:**
   - Visit `https://yourdomain.com`
   - Should redirect to HTTPS automatically

## Common DNS Providers

### Cloudflare
1. Add site to Cloudflare
2. Update nameservers at your registrar
3. Add DNS records in Cloudflare dashboard
4. Enable "Proxy" for CDN benefits

### Namecheap
1. Go to Advanced DNS
2. Add A records or CNAME
3. Save changes

### GoDaddy
1. Go to DNS Management
2. Add A records or CNAME
3. Save changes

### Google Domains
1. Go to DNS settings
2. Add custom records
3. Save changes

## Troubleshooting

### Domain Not Resolving

**Check DNS:**
```bash
nslookup yourdomain.com
dig yourdomain.com
```

**Wait for propagation:**
- DNS changes can take 24-48 hours
- Usually works within a few hours

### SSL Certificate Not Issuing

- Wait 24 hours after DNS is configured
- Ensure DNS points to GitHub's IPs
- Check GitHub Pages settings for errors

### Mixed Content Warnings

- Update all internal links to use HTTPS
- Check `_config.yml` URL setting
- Update any hardcoded HTTP links

## Best Practices

1. **Use Subdomain:**
   - Easier DNS configuration
   - Can use CNAME record
   - Example: `docs.yourdomain.com`

2. **Enable HTTPS:**
   - Always enforce HTTPS
   - Better security
   - Required for some features

3. **Update All Links:**
   - Update `_config.yml`
   - Check all internal links
   - Update social media profiles

4. **Document Your Setup:**
   - Keep DNS records documented
   - Note any special configurations

## Resources

- [GitHub Pages Custom Domain Docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [DNS Propagation Checker](https://www.whatsmydns.net/)
- [SSL Checker](https://www.sslshopper.com/ssl-checker.html)

---

**Note:** After setting up your custom domain, update the `url` in `_config.yml` and commit the changes.

