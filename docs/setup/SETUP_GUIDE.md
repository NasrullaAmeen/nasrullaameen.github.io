# Fresh Install Setup Guide for Windows

This guide will help you set up this Jekyll site from scratch on a fresh Windows installation.

## Prerequisites

Before starting, ensure you have:

- **Windows 10 or later**
- **PowerShell 5.0 or later** (included with Windows 10+)
- **Internet connection** (for downloading dependencies)
- **Administrator privileges** (for installing Ruby)

## Quick Start

### Option 1: Automated Setup (Recommended)

1. **Open PowerShell as Administrator**
   - Right-click Start menu → Windows PowerShell (Admin)
   - Or search "PowerShell" → Right-click → Run as administrator

2. **Navigate to the project directory**
   ```powershell
   cd C:\path\to\nasrullaameen.github.io
   ```

3. **Run the setup script**
   ```powershell
   .\scripts\setup-windows.ps1
   ```

The script will:
- Check for Ruby installation
- Install Bundler if needed
- Install all Jekyll dependencies
- Create Obsidian configuration file
- Verify the setup

### Option 2: Manual Setup

If you prefer to set up manually, follow the steps below.

## Detailed Setup Steps

### Step 1: Install Ruby

Ruby is required to run Jekyll. Choose one of these methods:

#### Method A: RubyInstaller (Recommended)

1. Download Ruby+Devkit from [rubyinstaller.org](https://rubyinstaller.org/downloads/)
   - Choose the latest stable version (Ruby+Devkit 3.x.x)
   - Select the x64 version for 64-bit Windows

2. Run the installer:
   - ✅ Check "Add Ruby executables to your PATH"
   - ✅ Check "Associate .rb and .rbw files with this Ruby installation"
   - Click "Install"

3. When installation completes, a new terminal will open. Run:
   ```
   ridk install
   ```
   - Select option 3 (MSYS2 and MINGW development toolchain)

4. **Close and reopen PowerShell** to refresh environment variables

5. Verify installation:
   ```powershell
   ruby -v
   ```
   You should see the Ruby version number.

#### Method B: Chocolatey

If you have Chocolatey installed:

```powershell
choco install ruby
```

Then restart PowerShell and verify:
```powershell
ruby -v
```

### Step 2: Install Bundler

Bundler manages Ruby gem dependencies:

```powershell
gem install bundler
```

Verify installation:
```powershell
bundle -v
```

### Step 3: Install Project Dependencies

Navigate to the project directory and install dependencies:

```powershell
cd C:\path\to\nasrullaameen.github.io
bundle install
```

This will install Jekyll and all theme dependencies. It may take a few minutes.

### Step 4: Configure Your Site

1. **Edit `_config.yml`** with your information:
   - Site title and description
   - Your GitHub username
   - Timezone
   - Social links
   - Avatar URL

2. **Create Obsidian configuration** (if using Obsidian):
   ```powershell
   Copy-Item obsidian\vault-config.json.example obsidian\vault-config.json
   ```
   Then edit `obsidian\vault-config.json` and set your vault path.

### Step 5: Test the Setup

Start the development server:

```powershell
.\scripts\start-local-server.ps1
```

If everything is set up correctly, you should see:
- "Bundler found"
- "Dependencies are up to date"
- "Your site will be available at: http://127.0.0.1:4000"

Open your browser and navigate to `http://127.0.0.1:4000` to see your site.

## Troubleshooting

### "Ruby is not recognized"

**Problem:** PowerShell can't find Ruby after installation.

**Solution:**
1. Close and reopen PowerShell
2. If still not working, manually add Ruby to PATH:
   - Search "Environment Variables" in Windows
   - Edit "Path" variable
   - Add: `C:\Ruby31-x64\bin` (adjust version number)
   - Restart PowerShell

### "Bundler is not recognized"

**Problem:** Bundler command not found.

**Solution:**
```powershell
gem install bundler
```

If this fails, ensure Ruby is properly installed and in your PATH.

### "bundle install fails"

**Problem:** Errors during dependency installation.

**Solutions:**
1. **SSL Certificate issues:**
   ```powershell
   gem sources --add http://rubygems.org/ --remove https://rubygems.org/
   ```

2. **Permission errors:**
   - Run PowerShell as Administrator
   - Or install gems to user directory:
     ```powershell
     bundle config set --local path 'vendor/bundle'
     bundle install
     ```

3. **Missing DevKit:**
   - Reinstall Ruby with DevKit from rubyinstaller.org
   - Run `ridk install` after installation

### "Script execution is disabled"

**Problem:** PowerShell execution policy prevents running scripts.

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Port 4000 is already in use"

**Problem:** Another application is using port 4000.

**Solution:**
1. Find and close the application using port 4000
2. Or use a different port:
   ```powershell
   bundle exec jekyll serve -l -H 127.0.0.1 -P 4001
   ```

## Post-Setup Checklist

After setup, verify everything works:

- [ ] Ruby is installed and in PATH
- [ ] Bundler is installed
- [ ] All dependencies installed (`bundle install` succeeded)
- [ ] Development server starts (`.\scripts\start-local-server.ps1`)
- [ ] Site loads in browser at `http://127.0.0.1:4000`
- [ ] `_config.yml` is configured with your information
- [ ] (Optional) Obsidian vault path is configured

## Next Steps

1. **Customize your site:**
   - Edit `_config.yml` with your details
   - Add your avatar image to `assets/img/`
   - Customize `_tabs/about.md`

2. **Create your first post:**
   - Create a file in `_posts/` with format: `YYYY-MM-DD-title.md`
   - Or use the Obsidian integration (see `docs/OBSIDIAN_SETUP.md`)

3. **Learn more:**
   - Read `README.md` for full documentation
   - Check `docs/SECURITY.md` for security best practices
   - See `docs/OBSIDIAN_SETUP.md` for Obsidian integration

## Getting Help

If you encounter issues:

1. Check the [Troubleshooting](#troubleshooting) section above
2. Review error messages carefully
3. Check [Jekyll documentation](https://jekyllrb.com/docs/)
4. Check [RubyInstaller documentation](https://github.com/oneclick/rubyinstaller2/wiki)

## Additional Resources

- [RubyInstaller Downloads](https://rubyinstaller.org/downloads/)
- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Chirpy Theme Wiki](https://github.com/cotes2020/jekyll-theme-chirpy/wiki)
- [Bundler Documentation](https://bundler.io/)

