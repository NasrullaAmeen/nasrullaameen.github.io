# Avatar Setup Guide

This guide explains how to customize your avatar/profile picture on your Jekyll site.

## Current Configuration

Your avatar is currently set to use your GitHub profile picture:
```yaml
avatar: "https://github.com/nasrullaameen.png"
```

## Option 1: Use GitHub Profile Picture (Current)

This automatically uses your GitHub profile picture. To update:
1. Change your GitHub profile picture
2. The site will automatically reflect the change

**Pros:**
- Automatic updates
- No file management needed
- Always in sync with GitHub

## Option 2: Use Local Image

### Step 1: Add Image File

1. **Create directory (if needed):**
   ```bash
   mkdir -p assets/img
   ```

2. **Add your avatar image:**
   - Place image in `assets/img/avatar.jpg` (or .png, .gif)
   - Recommended size: 512x512 pixels
   - Formats: JPG, PNG, GIF, WebP

### Step 2: Update Configuration

```yaml
# In _config.yml
avatar: "/assets/img/avatar.jpg"
```

### Step 3: Commit and Push

```bash
git add assets/img/avatar.jpg _config.yml
git commit -m "Add custom avatar"
git push
```

## Option 3: Use External Image URL

You can use any image hosted elsewhere:

```yaml
# In _config.yml
avatar: "https://example.com/path/to/your/avatar.jpg"
```

**Requirements:**
- Image must be accessible via HTTPS
- CORS must be enabled (for some hosts)
- Image should be square (recommended)

## Image Recommendations

### Size
- **Recommended:** 512x512 pixels
- **Minimum:** 256x256 pixels
- **Maximum:** 1024x1024 pixels
- **Format:** Square aspect ratio (1:1)

### Formats
- **JPG:** Good for photos, smaller file size
- **PNG:** Good for graphics, supports transparency
- **WebP:** Modern format, best compression
- **GIF:** For animated avatars (if supported)

### Optimization

Before uploading, optimize your image:

```bash
# Using ImageMagick (if installed)
convert avatar.jpg -resize 512x512 -quality 85 avatar-optimized.jpg

# Or use online tools:
# - TinyPNG
# - Squoosh
# - ImageOptim
```

## Testing

1. **Update _config.yml**
2. **Test locally:**
   ```bash
   bundle exec jekyll serve
   ```
3. **Check avatar in sidebar**
4. **Commit and push**

## Troubleshooting

### Avatar Not Showing

**Check:**
- Image path is correct
- Image file exists
- Image is accessible (if external URL)
- CORS is enabled (for external URLs)

### Image Too Large

**Optimize:**
- Resize to 512x512
- Compress image
- Use WebP format

### Wrong Aspect Ratio

**Fix:**
- Crop to square (1:1)
- Use image editing software
- Or use CSS (advanced)

## Examples

### GitHub Profile
```yaml
avatar: "https://github.com/nasrullaameen.png"
```

### Local Image
```yaml
avatar: "/assets/img/avatar.jpg"
```

### External URL
```yaml
avatar: "https://cdn.example.com/avatar.png"
```

### With CDN
```yaml
cdn: "https://cdn.example.com"
avatar: "/images/avatar.jpg"  # Will use CDN automatically
```

## Resources

- [Image Optimization Tools](https://squoosh.app/)
- [Avatar Generators](https://www.avatar-generator.org/)
- [GitHub Profile Picture](https://github.com/settings/profile)

---

**Tip:** Keep your avatar professional and recognizable, as it represents you across your site!

