# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.1] - 2025-12-09

### Added
- Created project-specific CHANGELOG.md in root directory
- Added `.cursorrules` file for Cursor AI project context
- Added documentation maintenance requirements to `.cursorrules`
- Added changelog reference to README.md

### Changed
- Updated `.gitignore` to exclude `.cursorrules` from version control
- Enhanced `.cursorrules` with documentation maintenance requirements
- Updated README.md to reference project changelog and distinguish from theme changelog

## [1.0.0] - 2024-12-08

### Added
- Comprehensive project reorganization with structured file organization
- Local development server scripts (`scripts/start-local-server.ps1` and `.sh`) with dependency checks and live reload
- Obsidian vault integration system for publishing content
  - Vault sync scripts (`scripts/sync-from-vault.ps1` and `.sh`) with watch mode
  - Obsidian templates and configuration files
  - Shell command integration for one-click publishing
- Comprehensive documentation structure
  - Setup guides in `docs/setup/` (Windows setup, GitHub publishing, analytics, etc.)
  - Reference documentation in `docs/reference/` (security, pre-commit checklists, etc.)
  - Integration guides for Obsidian
- Security scripts (`scripts/check-before-commit.ps1` and `.sh`) for pre-commit validation
- Windows setup automation script (`scripts/setup-windows.ps1`)
- Project structure documentation (`STRUCTURE.md`, `FILE_ORGANIZATION.md`)
- `.cursorrules` file for Cursor AI project context
- Enhanced `.gitignore` with comprehensive exclusions for sensitive files

### Changed
- Reorganized all scripts into `scripts/` directory
- Moved all documentation into organized `docs/` structure
- Moved Obsidian integration files to `obsidian/` directory
- Updated README.md with comprehensive project documentation
- Enhanced security practices with path validation and input sanitization

### Security
- Added comprehensive `.gitignore` rules to prevent committing sensitive files
- Implemented pre-commit security checks
- Added path validation and sanitization in all scripts
- Excluded personal configuration files from version control

---

## Notes

- **Always update this changelog** when making significant changes
- **Always update README.md** when adding features or changing workflows
- Use semantic versioning for releases
- Document breaking changes clearly
- Include migration guides for major changes

