---
title: Setting Up a Jekyll Documentation Site
description: >
  A guide on how to set up and deploy a Jekyll site with the Chirpy theme for documentation purposes.
author: Nasrulla Ameen
date: 2025-12-08 14:30:00 -0600
categories: [Tutorial, Documentation]
tags: [jekyll, chirpy, setup, deployment]
---

# Setting Up a Jekyll Documentation Site

This guide walks through setting up a Jekyll site with the Chirpy theme for documentation.

## Prerequisites

Before you begin, ensure you have:

- Ruby 3.1 or higher
- Bundler gem installed
- Git installed
- A GitHub account (for deployment)

## Installation Steps

### 1. Install Dependencies

First, install the required Ruby gems:

```bash
bundle install
```

This will install Jekyll and all theme dependencies.

### 2. Configure Your Site

Edit the `_config.yml` file to customize:

- Site title and description
- Your GitHub username
- Timezone
- URL (for GitHub Pages)
- Social media links
- Avatar image

### 3. Run Locally

Start the Jekyll development server:

```bash
bundle exec jekyll serve
```

Your site will be available at `http://localhost:4000`.

## Creating Content

### Creating a New Post

Create a new file in the `_posts/` directory with the format:

```
YYYY-MM-DD-title.md
```

### Post Front Matter

Each post needs front matter at the top:

```yaml
---
title: Your Post Title
description: A brief description
author: Your Name
date: 2024-01-16 10:00:00 -0600
categories: [Category1, Category2]
tags: [tag1, tag2, tag3]
---
```

### Markdown Syntax

Use standard Markdown syntax:

- **Headers**: `# H1`, `## H2`, `### H3`
- **Bold**: `**bold text**`
- **Italic**: `*italic text*`
- **Code blocks**: Use triple backticks with language

```bash
# Example bash command
sudo apt update
sudo apt upgrade
```

```yaml
# Example YAML
version: '3.8'
services:
  web:
    image: nginx:latest
```

## Deployment

### GitHub Pages

1. Push your code to GitHub
2. Go to Settings → Pages
3. Select "GitHub Actions" as the source
4. The site will deploy automatically on push

### Self-Hosting

Build the site for production:

```bash
JEKYLL_ENV=production bundle exec jekyll build
```

The generated site will be in the `_site/` directory. Upload this to your web server.

## Tips

- Use categories to organize major topics
- Use tags for specific topics
- Pin important posts with `pin: true` in front matter
- Keep descriptions concise but informative
- Use code blocks for commands and configurations

Happy documenting!

