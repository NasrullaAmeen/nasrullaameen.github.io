# File Organization Guide

This document explains the file organization principles and structure of this project.

## Root Directory

The root directory contains only **essential files**:

### Configuration Files
- `_config.yml` - Jekyll site configuration
- `Gemfile`, `Gemfile.lock` - Ruby dependencies
- `package.json` - Node.js dependencies
- `.gitignore`, `.gitattributes` - Git configuration
- `LICENSE` - License file

### Build Configuration
- `eslint.config.js` - ESLint configuration
- `rollup.config.js` - Rollup bundler configuration
- `purgecss.js` - PurgeCSS configuration
- `jekyll-theme-chirpy.gemspec` - Theme gem specification

### Main Documentation
- `README.md` - Main project documentation
- `STRUCTURE.md` - Project structure documentation

### Convenience Wrappers
- `start-local-server.ps1` - Wrapper for `scripts/start-local-server.ps1`
- `sync-from-vault.ps1` - Wrapper for `scripts/sync-from-vault.ps1`

## Organized Directories

### `docs/` - All Documentation
- **`docs/setup/`** - Setup and installation guides
- **`docs/reference/`** - Reference documentation
- **`docs/OBSIDIAN_SETUP.md`** - Integration guide (root level)

### `scripts/` - All Utility Scripts
- Development server scripts
- Vault sync scripts
- Setup scripts
- Security check scripts

### `obsidian/` - Obsidian Integration
- Templates
- Configuration examples
- JavaScript functions

### `tools/` - Build Tools
- Theme build scripts (from Chirpy theme)

## File Organization Rules

1. **Documentation** → `docs/` with subdirectories by purpose
2. **Scripts** → `scripts/` folder
3. **Integration files** → `obsidian/` folder
4. **Jekyll files** → Standard Jekyll locations
5. **Configuration** → Root (essential) or appropriate subfolder

## Benefits

✅ **Clean root directory** - Easy to see what's important
✅ **Logical grouping** - Related files are together
✅ **Easy navigation** - Clear structure for finding files
✅ **Maintainable** - Easy to add new files in right places
✅ **Professional** - Well-organized codebase

## Quick Reference

- **Setup guides:** `docs/setup/`
- **Reference docs:** `docs/reference/`
- **Scripts:** `scripts/`
- **Obsidian files:** `obsidian/`
- **Main docs:** Root (`README.md`, `STRUCTURE.md`)

