# Setup Checklist

Use this checklist when setting up the site on a fresh Windows installation.

## Pre-Setup

- [ ] Windows 10 or later installed
- [ ] PowerShell 5.0 or later available
- [ ] Internet connection available
- [ ] Administrator privileges (for Ruby installation)

## Installation Steps

### Ruby Installation

- [ ] Ruby downloaded from [rubyinstaller.org](https://rubyinstaller.org/downloads/)
- [ ] Ruby+Devkit installer run
- [ ] "Add Ruby executables to your PATH" checked during installation
- [ ] `ridk install` completed (selected option 3)
- [ ] PowerShell restarted after Ruby installation
- [ ] Ruby verified: `ruby -v` shows version number

### Bundler Installation

- [ ] Bundler installed: `gem install bundler`
- [ ] Bundler verified: `bundle -v` shows version number

### Project Setup

- [ ] Repository cloned or extracted
- [ ] Navigated to project directory
- [ ] Setup script run: `.\scripts\setup-windows.ps1`
  - OR manually: `bundle install` completed successfully
- [ ] Dependencies installed (Gemfile.lock exists)

### Configuration

- [ ] `_config.yml` edited with your information:
  - [ ] Site title
  - [ ] Site description
  - [ ] GitHub username
  - [ ] Timezone
  - [ ] Social links
  - [ ] Avatar URL
- [ ] (Optional) Obsidian vault configured:
  - [ ] `obsidian/vault-config.json` created from example
  - [ ] Vault path set in config file
  - [ ] OR environment variable `JEKYLL_VAULT_PATH` set

### Testing

- [ ] Development server starts: `.\scripts\start-local-server.ps1`
- [ ] No errors in console output
- [ ] Site loads in browser at `http://127.0.0.1:4000`
- [ ] Site displays correctly
- [ ] Live reload works (make a change, see it refresh)

### Optional: Obsidian Integration

- [ ] Obsidian installed
- [ ] Shell Commands plugin installed in Obsidian
- [ ] `obsidian/obsidian-shell-command.json` imported
- [ ] Template `obsidian/obsidian-publish-template.md` copied to Obsidian templates folder
- [ ] Test publish works from Obsidian

## Post-Setup

- [ ] Read `README.md` for usage instructions
- [ ] Read `docs/SECURITY.md` for security best practices
- [ ] (If using Obsidian) Read `docs/OBSIDIAN_SETUP.md`
- [ ] Created first test post
- [ ] Verified post appears on site

## Troubleshooting

If any step fails:

- [ ] Checked error messages carefully
- [ ] Reviewed `docs/SETUP_GUIDE.md` troubleshooting section
- [ ] Verified Ruby is in PATH
- [ ] Verified PowerShell execution policy allows scripts
- [ ] Checked firewall/antivirus isn't blocking

## Notes

Use this space to note any issues encountered or custom configurations:

```
Date: ___________
Issues: 
_________________________________________________
_________________________________________________

Custom Configurations:
_________________________________________________
_________________________________________________
```

