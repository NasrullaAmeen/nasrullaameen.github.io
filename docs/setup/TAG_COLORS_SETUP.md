# Tag Colors Setup Guide

This guide explains how to add custom colors to tags in your Jekyll site.

## Overview

Tags can now have custom colors! The system uses a data file to define tag colors and automatically applies them throughout the site.

## Configuration

### 1. Edit Tag Colors File

Edit `_data/tags.yml` to add your tag colors:

```yaml
# Tag Colors Configuration
default:
  light: "#6c757d"  # Default gray color for tags without specific colors
  dark: "#adb5bd"    # Light gray for dark mode

# Add your tag colors here
docker: "#0db7ed"
kubernetes: "#326ce5"
python: "#3776ab"
javascript: "#f7df1e"
linux: "#fcc624"
networking: "#00a8e8"
security: "#ff6b6b"
cloud: "#4285f4"
devops: "#00d4aa"
```

### 2. Format

- **Tag name**: Use the exact tag name as it appears in your posts (case-sensitive)
- **Color value**: Use hex color codes (e.g., `#ff6b6b`)
- **Default**: Tags without specific colors will use the default gray

### 3. Finding Tag Names

To see all your tags, check:
- Your posts' front matter: `tags: [tag1, tag2]`
- The tags page: `/tags/`
- Or run: `grep -r "tags:" _posts/`

## Examples

### Popular Technology Tags

```yaml
docker: "#0db7ed"
kubernetes: "#326ce5"
python: "#3776ab"
javascript: "#f7df1e"
typescript: "#3178c6"
react: "#61dafb"
nodejs: "#339933"
go: "#00add8"
rust: "#000000"
java: "#ed8b00"
```

### Category-Based Colors

```yaml
tutorial: "#4ecdc4"
guide: "#45b7d1"
tips: "#f9ca24"
news: "#6c5ce7"
review: "#a29bfe"
```

### Topic-Based Colors

```yaml
security: "#ff6b6b"
networking: "#00a8e8"
cloud: "#4285f4"
devops: "#00d4aa"
database: "#f39c12"
```

## Color Selection Tips

1. **Use brand colors**: Match technology logos/branding
2. **Ensure contrast**: Tags use white text, so use darker colors
3. **Be consistent**: Similar topics can share color families
4. **Test readability**: Make sure white text is readable on your colors

## Where Colors Appear

Tag colors are automatically applied to:
- ✅ Post tags (below post content)
- ✅ Tags page (all tags listing)
- ✅ Trending tags (sidebar)
- ✅ Tag archive pages

## Testing

1. Add colors to `_data/tags.yml`
2. Start your local server: `.\scripts\start-local-server.ps1`
3. View a post with the tagged content
4. Check the tags page: `/tags/`
5. Verify colors appear correctly

## Troubleshooting

### Tags not showing colors?
- Check tag name spelling (must match exactly, case-sensitive)
- Verify YAML syntax is correct
- Clear Jekyll cache: Delete `.jekyll-cache/` folder

### Colors too light?
- Use darker hex colors for better contrast with white text
- Test with: `#000000` (black) to see maximum contrast

### Want to remove a color?
- Simply remove the tag entry from `_data/tags.yml`
- It will fall back to the default gray color

## Advanced: Dynamic Colors

For more advanced color schemes, you can:
- Use CSS variables in the color values
- Create color palettes based on tag categories
- Implement dark/light mode specific colors

## Resources

- [Color Picker Tools](https://htmlcolorcodes.com/color-picker/)
- [Brand Colors](https://brandcolors.net/)
- [Material Design Colors](https://material.io/design/color/the-color-system.html)

