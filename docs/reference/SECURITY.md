# Security Best Practices

This document outlines security best practices for this Jekyll site and its associated scripts.

## Script Security

### Path Validation
- All file paths are validated to prevent directory traversal attacks
- Paths are resolved to absolute paths and checked against base directories
- Only files within the designated publish folder are processed

### Input Sanitization
- Filenames are sanitized to remove dangerous characters (`<>:"/\|?*`)
- Title extraction from front matter is validated and sanitized
- File extensions are validated (only `.md` and `.markdown` allowed)

### File Operations
- File size limits (10MB max) to prevent memory exhaustion
- Safe file copying with error handling
- Validation that source files are within expected directories

### Error Handling
- Comprehensive try-catch blocks prevent script crashes
- Error messages don't expose sensitive information
- Failed operations are logged without stopping the entire process

## Configuration Security

### Sensitive Data
- **Never commit sensitive data** to version control
- Use environment variables for sensitive paths:
  ```powershell
  $env:JEKYLL_VAULT_PATH = "C:\Path\To\Vault"
  ```
- `obsidian/vault-config.json` is gitignored (contains personal paths)

### Configuration Files
- `vault-config.json.example` is a template (safe to commit)
- Actual `vault-config.json` contains user-specific paths (gitignored)
- Validate JSON structure before processing

## Jekyll Security

### Content Security
- Jekyll automatically escapes content in templates
- Front matter is validated before processing
- No user-generated content is executed as code

### Dependencies
- Keep dependencies up to date:
  ```bash
  bundle update
  npm update
  ```
- Review dependency security advisories regularly
- Use `bundle audit` to check for vulnerabilities

### Analytics & Tracking
- Analytics IDs are stored in `_config.yml` (public)
- No sensitive tracking tokens should be committed
- Consider using environment variables for production analytics

## Best Practices

### File Permissions
- Scripts should have appropriate execute permissions
- Configuration files should not be world-readable
- Use principle of least privilege

### Development vs Production
- Use `JEKYLL_ENV=development` for local development
- Production builds should use `JEKYLL_ENV=production`
- Never commit production secrets to repository

### Git Security
- Review `.gitignore` regularly
- Never commit:
  - Personal vault paths
  - API keys or tokens
  - Passwords or secrets
  - System-specific configurations

### Script Execution
- Review scripts before execution
- Use PowerShell execution policy appropriately:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```
- Prefer running scripts from trusted locations

## Environment Variables

Recommended environment variables for sensitive data:

```powershell
# PowerShell
$env:JEKYLL_VAULT_PATH = "C:\Path\To\Vault"
$env:JEKYLL_ANALYTICS_GOOGLE = "your-google-analytics-id"
```

```bash
# Bash/Linux
export JEKYLL_VAULT_PATH="/path/to/vault"
export JEKYLL_ANALYTICS_GOOGLE="your-google-analytics-id"
```

## Security Checklist

Before committing changes:
- [ ] No sensitive data in committed files
- [ ] `.gitignore` is up to date
- [ ] Scripts have proper error handling
- [ ] Paths are validated and sanitized
- [ ] Dependencies are up to date
- [ ] No hardcoded secrets or passwords
- [ ] Configuration examples don't contain real data

## Reporting Security Issues

If you discover a security vulnerability, please:
1. **Do not** open a public issue
2. Contact the repository maintainer privately
3. Provide details about the vulnerability
4. Allow time for a fix before public disclosure

## Additional Resources

- [Jekyll Security](https://jekyllrb.com/docs/security/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Git Security Best Practices](https://git-scm.com/docs/git-config#_security)
