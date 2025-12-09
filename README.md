<!-- markdownlint-disable-next-line -->
<div align="center">

  <!-- markdownlint-disable-next-line -->
  # My IT Journey

  Output Hub - Learning, Notes & Documentation

  My IT journey output hub - documenting my learning path, technical notes, experiments, and knowledge gained along the way.

  Built with [Jekyll](https://jekyllrb.com/) and the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme.

</div>

## Table of Contents

- [First Time Setup (Windows)](#first-time-setup-windows)
- [Before Publishing to GitHub](#before-publishing-to-github)
- [Getting Started](#getting-started)
- [Publishing from Your Vault](#publishing-from-your-vault)
- [Obsidian Integration](#obsidian-integration)
- [Security](#security)
- [Features](#features)
- [Documentation](#documentation)
- [Project Structure](#project-structure)

## First Time Setup (Windows)

If this is your first time setting up the site on Windows, use the automated setup script:

```powershell
# Run as Administrator (recommended) or regular user
.\scripts\setup-windows.ps1
```

The script will:
- ✅ Check for Ruby installation
- ✅ Install Bundler if needed
- ✅ Install all Jekyll dependencies
- ✅ Create Obsidian configuration file
- ✅ Verify the setup

**For detailed setup instructions, see [docs/setup/SETUP_GUIDE.md](docs/setup/SETUP_GUIDE.md)**

### Quick Start

For a faster setup, see **[docs/setup/QUICKSTART.md](docs/setup/QUICKSTART.md)** for a 5-minute guide.

### Manual Setup

If you prefer manual setup:

1. **Install Ruby** from [rubyinstaller.org](https://rubyinstaller.org/downloads/)
2. **Install Bundler**: `gem install bundler`
3. **Install dependencies**: `bundle install`
4. **Start server**: `.\scripts\start-local-server.ps1`

> 💡 **Tip:** Use the [docs/setup/SETUP_CHECKLIST.md](docs/setup/SETUP_CHECKLIST.md) to track your setup progress.

## Getting Started

### Prerequisites

- [Ruby](https://www.ruby-lang.org/en/downloads/) (2.5 or higher)
- [Bundler](https://bundler.io/) (`gem install bundler`)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/nasrullaameen/nasrullaameen.github.io.git
   cd nasrullaameen.github.io
   ```

2. **Start the local development server**

   **Windows (PowerShell):**
   ```powershell
   .\scripts\start-local-server.ps1
   ```

   **Linux/macOS/WSL:**
   ```bash
   chmod +x scripts/start-local-server.sh
   ./scripts/start-local-server.sh
   ```

   The script will automatically:
   - Check if Bundler is installed
   - Verify dependencies are installed (runs `bundle install` if needed)
   - Start Jekyll with live reload enabled

3. **Access your site**
   - Open your browser and navigate to `http://127.0.0.1:4000`
   - The site will automatically reload when you make changes to files

### Manual Setup (Alternative)

If you prefer to run commands manually:

```bash
# Install dependencies
bundle install

# Start the server
bundle exec jekyll serve -l
```

## Publishing from Your Vault

This site supports publishing content directly from your vault's "Publish" folder (e.g., Obsidian vault).

### Setup

1. **Configure your vault path**

   Copy the example config file and edit it:
   
   ```powershell
   # Windows
   Copy-Item obsidian\vault-config.json.example obsidian\vault-config.json
   ```
   
   ```bash
   # Linux/macOS
   cp obsidian/vault-config.json.example obsidian/vault-config.json
   ```
   
   Then edit `obsidian/vault-config.json` and set your vault path.

   **Security Note:** For better security, use environment variables:
   ```powershell
   # PowerShell
   $env:JEKYLL_VAULT_PATH = "C:\Path\To\Your\Vault"
   ```
   
   ```bash
   # Bash
   export JEKYLL_VAULT_PATH="/path/to/your/vault"
   ```

2. **Create a "Publish" folder in your vault**

   Create a folder named `Publish` in your vault root directory.

3. **Add markdown files to the Publish folder**

   Place any markdown files you want to publish in the `Publish` folder. The files should have Jekyll front matter:

   ```markdown
   ---
   title: Your Post Title
   date: 2024-01-20 10:00:00 -0600
   categories: [Category1, Category2]
   tags: [tag1, tag2]
   ---
   
   Your content here...
   ```

### Syncing Files

**Windows (PowerShell):**
```powershell
# One-time sync
.\scripts\sync-from-vault.ps1

# Watch mode (auto-sync on changes)
.\scripts\sync-from-vault.ps1 -Watch

# Specify vault path
.\scripts\sync-from-vault.ps1 -VaultPath "C:\Path\To\Your\Vault"
```

**Linux/macOS/WSL:**
```bash
# Make executable (first time only)
chmod +x scripts/sync-from-vault.sh

# One-time sync
./scripts/sync-from-vault.sh

# Watch mode (auto-sync on changes)
./scripts/sync-from-vault.sh --watch

# Specify vault path
./scripts/sync-from-vault.sh --vault "/path/to/your/vault"
```

### How It Works

- Files from your vault's `Publish` folder are copied to `_posts`
- Filenames are automatically formatted as `YYYY-MM-DD-title-slug.md`
- Date and title are extracted from front matter
- If front matter is missing, basic front matter is added automatically
- Existing files are preserved (unless `overwriteExisting` is set to `true` in config)
- **Security:** All paths are validated, filenames are sanitized, and file operations are safe

### Workflow

1. Write your post in your vault's `Publish` folder
2. Run the sync script (or use watch mode)
3. Start your local server to preview: `.\scripts\start-local-server.ps1`
4. Commit and push to publish

### Obsidian Integration

For seamless publishing from Obsidian, see **[docs/OBSIDIAN_SETUP.md](docs/OBSIDIAN_SETUP.md)** for detailed setup instructions.

**Quick Setup:**
1. Install the [Shell Commands](https://github.com/Taitava/obsidian-shellcommands) plugin in Obsidian
2. Import `obsidian/obsidian-shell-command.json` in the plugin settings
3. Use the template `obsidian/obsidian-publish-template.md` for new posts
4. Press `Ctrl+P` and type "Publish to Jekyll Website" to sync

The template includes a publish button and instructions right in your note!

## Security

This project includes security best practices:
- Path validation and sanitization
- Input validation
- Safe file operations
- Environment variable support for sensitive data

See **[docs/reference/SECURITY.md](docs/reference/SECURITY.md)** for detailed security information.

## Features

This site uses the [Chirpy Jekyll theme](https://github.com/cotes2020/jekyll-theme-chirpy) which includes:

- Dark Theme
- Localized UI language
- Pinned Posts on Home Page
- Hierarchical Categories
- Trending Tags
- Table of Contents
- Last Modified Date
- Syntax Highlighting
- Mathematical Expressions
- Mermaid Diagrams & Flowcharts
- Dark Mode Images
- Embed Media
- Comment Systems
- Built-in Search
- Atom Feeds
- PWA
- Web Analytics
- SEO & Performance Optimization

## Documentation

### Project Documentation

#### Setup Guides
- **[docs/setup/SETUP_GUIDE.md](docs/setup/SETUP_GUIDE.md)** - Complete setup guide for fresh Windows installs
- **[docs/setup/QUICKSTART.md](docs/setup/QUICKSTART.md)** - 5-minute quick start guide
- **[docs/setup/SETUP_CHECKLIST.md](docs/setup/SETUP_CHECKLIST.md)** - Setup checklist
- **[docs/setup/GITHUB_SETUP.md](docs/setup/GITHUB_SETUP.md)** - GitHub Pages deployment
- **[docs/setup/GITHUB_PUBLISH_GUIDE.md](docs/setup/GITHUB_PUBLISH_GUIDE.md)** - Quick guide for publishing to GitHub
- **[docs/setup/GITHUB_PUBLISH_CHECKLIST.md](docs/setup/GITHUB_PUBLISH_CHECKLIST.md)** - Detailed GitHub publishing checklist
- **[docs/setup/ANALYTICS_SETUP.md](docs/setup/ANALYTICS_SETUP.md)** - Analytics configuration
- **[docs/setup/AVATAR_SETUP.md](docs/setup/AVATAR_SETUP.md)** - Avatar configuration
- **[docs/setup/CUSTOM_DOMAIN_SETUP.md](docs/setup/CUSTOM_DOMAIN_SETUP.md)** - Custom domain setup

#### Integration Guides
- **[docs/OBSIDIAN_SETUP.md](docs/OBSIDIAN_SETUP.md)** - Obsidian integration guide

#### Reference Documentation
- **[docs/reference/SECURITY.md](docs/reference/SECURITY.md)** - Security best practices
- **[docs/reference/CONTRIBUTING.md](docs/reference/CONTRIBUTING.md)** - Contributing guidelines
- **[docs/reference/CODE_OF_CONDUCT.md](docs/reference/CODE_OF_CONDUCT.md)** - Code of conduct
- **[docs/reference/CHANGELOG.md](docs/reference/CHANGELOG.md)** - Changelog

#### Project Structure
- **[STRUCTURE.md](STRUCTURE.md)** - Project file organization

### Theme Documentation

For more information about the Chirpy theme, please refer to the [Chirpy Wiki][wiki].

## Project Structure

See **[STRUCTURE.md](STRUCTURE.md)** for a detailed overview of the project organization.

## Before Publishing to GitHub

⚠️ **Important:** This is a public repository. Before committing:

1. **Run security check:**
   ```powershell
   .\scripts\check-before-commit.ps1
   ```

2. **Review checklists:**
   - [docs/setup/GITHUB_PUBLISH_GUIDE.md](docs/setup/GITHUB_PUBLISH_GUIDE.md) - Quick publishing guide
   - [docs/reference/PRE_COMMIT_CHECKLIST.md](docs/reference/PRE_COMMIT_CHECKLIST.md) - Detailed pre-commit checklist
   - [docs/setup/GITHUB_PUBLISH_CHECKLIST.md](docs/setup/GITHUB_PUBLISH_CHECKLIST.md) - GitHub-specific checklist

3. **Verify .gitignore:**
   ```bash
   git status --ignored
   ```

**Never commit:**
- ❌ `obsidian/vault-config.json` (personal vault path)
- ❌ `.env` files
- ❌ Personal paths or usernames in example files
- ❌ API keys or tokens
- ❌ Build artifacts (`_site/`, `node_modules/`)

## Quick Reference

### Common Commands

```powershell
# Start development server
.\scripts\start-local-server.ps1

# Sync from vault
.\scripts\sync-from-vault.ps1

# Sync with watch mode
.\scripts\sync-from-vault.ps1 -Watch

# Check before committing (IMPORTANT for public repo)
.\scripts\check-before-commit.ps1
```

```bash
# Start development server
./scripts/start-local-server.sh

# Sync from vault
./scripts/sync-from-vault.sh

# Sync with watch mode
./scripts/sync-from-vault.sh --watch

# Check before committing (IMPORTANT for public repo)
./scripts/check-before-commit.sh
```

### Environment Variables

```powershell
# Set vault path (PowerShell)
$env:JEKYLL_VAULT_PATH = "C:\Path\To\Your\Vault"
```

```bash
# Set vault path (Bash)
export JEKYLL_VAULT_PATH="/path/to/your/vault"
```

## Credits

This site is built using the [Chirpy Jekyll theme](https://github.com/cotes2020/jekyll-theme-chirpy) by [Cotes Chung](https://github.com/cotes2020).

### Third-Party Assets

This project is built on the [Jekyll][jekyllrb] ecosystem and some [great libraries][lib].

[wiki]: https://github.com/cotes2020/jekyll-theme-chirpy/wiki
[jekyllrb]: https://jekyllrb.com/
[lib]: https://github.com/cotes2020/chirpy-static-assets
