# Project Structure

This document describes the organized file structure of the Jekyll site.

## Directory Structure

```
nasrullaameen.github.io/
├── _config.yml              # Jekyll configuration
├── _data/                   # Site data files (locales, authors, etc.)
├── _includes/               # Jekyll includes (HTML snippets)
├── _javascript/             # JavaScript source files
├── _layouts/                # Jekyll layout templates
├── _plugins/                # Jekyll plugins
├── _posts/                  # Blog posts (markdown files)
├── _sass/                   # SCSS stylesheets
├── _tabs/                   # Tab pages (About, Archives, etc.)
├── assets/                  # Static assets (images, CSS, JS)
├── docs/                    # Documentation files
│   ├── setup/               # Setup and installation guides
│   │   ├── SETUP_GUIDE.md
│   │   ├── QUICKSTART.md
│   │   ├── SETUP_CHECKLIST.md
│   │   ├── GITHUB_SETUP.md
│   │   ├── GITHUB_PUBLISH_GUIDE.md
│   │   ├── GITHUB_PUBLISH_CHECKLIST.md
│   │   ├── ANALYTICS_SETUP.md
│   │   ├── AVATAR_SETUP.md
│   │   └── CUSTOM_DOMAIN_SETUP.md
│   ├── reference/           # Reference documentation
│   │   ├── SECURITY.md
│   │   ├── PRE_COMMIT_CHECKLIST.md
│   │   ├── CONTRIBUTING.md
│   │   ├── CODE_OF_CONDUCT.md
│   │   └── CHANGELOG.md
│   ├── OBSIDIAN_SETUP.md    # Obsidian integration guide
│   └── README.md            # Documentation index
├── obsidian/                # Obsidian integration files
│   ├── obsidian-publish-button.js
│   ├── obsidian-publish-template.md
│   ├── obsidian-publish-template-simple.md
│   ├── obsidian-publish-template-advanced.md
│   ├── obsidian-shell-command.json
│   ├── vault-config.json.example
│   └── vault-config.json    # (gitignored - personal config)
├── scripts/                 # Utility scripts
│   ├── setup-windows.ps1
│   ├── start-local-server.ps1
│   ├── start-local-server.sh
│   ├── sync-from-vault.ps1
│   ├── sync-from-vault.sh
│   ├── check-before-commit.ps1
│   └── check-before-commit.sh
├── tools/                   # Build tools (from theme)
├── start-local-server.ps1   # Convenience wrapper (root)
├── sync-from-vault.ps1     # Convenience wrapper (root)
├── README.md                # Main documentation
├── STRUCTURE.md            # This file
├── Gemfile                  # Ruby dependencies
├── package.json             # Node.js dependencies
└── ...                      # Other config files
```

## Key Directories

### `docs/setup/`
Contains all setup and installation guides:
- **SETUP_GUIDE.md**: Complete Windows setup guide
- **QUICKSTART.md**: 5-minute quick start guide
- **SETUP_CHECKLIST.md**: Setup checklist for tracking progress
- **GITHUB_SETUP.md**: GitHub Pages deployment
- **GITHUB_PUBLISH_GUIDE.md**: Quick guide for publishing to GitHub
- **GITHUB_PUBLISH_CHECKLIST.md**: Detailed GitHub publishing checklist
- **ANALYTICS_SETUP.md**: Analytics configuration
- **AVATAR_SETUP.md**: Avatar configuration
- **CUSTOM_DOMAIN_SETUP.md**: Custom domain setup

### `docs/reference/`
Contains reference documentation:
- **SECURITY.md**: Security best practices
- **PRE_COMMIT_CHECKLIST.md**: Pre-commit checklist for public repos
- **CONTRIBUTING.md**: Contributing guidelines
- **CODE_OF_CONDUCT.md**: Code of conduct
- **CHANGELOG.md**: Project changelog

### `scripts/`
Contains all utility scripts for development:
- **setup-windows.ps1**: Automated Windows setup script
- **start-local-server.ps1/sh**: Starts the Jekyll development server
- **sync-from-vault.ps1/sh**: Syncs files from Obsidian vault to `_posts`
- **check-before-commit.ps1/sh**: Security check before committing

### `obsidian/`
Contains all Obsidian integration files:
- **Templates**: Markdown templates for creating new posts
- **Configuration**: Vault config and shell command definitions
- **Scripts**: JavaScript functions for Templater plugin

## Root Directory Files

### Essential Files (Keep in Root)
- **README.md**: Main project documentation
- **STRUCTURE.md**: This file - project structure documentation
- **Gemfile**, **package.json**: Dependency management
- **.gitignore**, **.gitattributes**: Git configuration
- **LICENSE**: License file
- **_config.yml**: Jekyll configuration

### Convenience Wrappers (Root)
- **start-local-server.ps1**: Wrapper for `scripts/start-local-server.ps1`
- **sync-from-vault.ps1**: Wrapper for `scripts/sync-from-vault.ps1`

These wrappers allow running scripts from the root directory while keeping actual scripts organized in `scripts/`.

## File Organization Principles

1. **Scripts** → `scripts/` folder
2. **Obsidian files** → `obsidian/` folder
3. **Setup documentation** → `docs/setup/` folder
4. **Reference documentation** → `docs/reference/` folder
5. **Integration guides** → `docs/` folder (root level)
6. **Jekyll files** → Standard Jekyll locations (`_posts/`, `_layouts/`, etc.)
7. **Configuration** → Root or appropriate subfolder
8. **Build tools** → `tools/` folder (from theme)

## Clean Root Directory

The root directory contains only:
- Essential configuration files
- Main documentation (README.md, STRUCTURE.md)
- Convenience wrapper scripts
- Dependency files (Gemfile, package.json)

All other files are organized in appropriate subdirectories for better maintainability and clarity.
