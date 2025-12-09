# Quick Start Guide

Get your Jekyll site up and running in 5 minutes on Windows.

## Prerequisites

- Windows 10 or later
- Internet connection
- Administrator privileges (for Ruby installation)

## Step-by-Step

### 1. Install Ruby (2 minutes)

Download and install Ruby+Devkit from:
👉 **https://rubyinstaller.org/downloads/**

- Choose the latest **Ruby+Devkit 3.x.x (x64)** version
- Run the installer
- ✅ Check "Add Ruby executables to your PATH"
- Click Install
- When finished, run `ridk install` and select option 3
- **Close and reopen PowerShell**

### 2. Run Setup Script (2 minutes)

Open PowerShell in the project directory:

```powershell
.\scripts\setup-windows.ps1
```

The script will automatically:
- Install Bundler
- Install all Jekyll dependencies
- Create configuration files

### 3. Start Your Site (1 minute)

```powershell
.\scripts\start-local-server.ps1
```

Open your browser: **http://127.0.0.1:4000**

## That's It! 🎉

Your site is now running locally. 

## Next Steps

1. **Edit `_config.yml`** with your information
2. **Create your first post** in `_posts/` folder
3. **Customize** the site to your liking

## Need Help?

- **Detailed setup:** See [SETUP_GUIDE.md](SETUP_GUIDE.md) (in same folder)
- **Troubleshooting:** Check the troubleshooting section in SETUP_GUIDE.md
- **Full documentation:** See [README.md](../../README.md)

## Common Issues

**"Ruby is not recognized"**
→ Close and reopen PowerShell, or restart your computer

**"Script execution is disabled"**
→ Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

**"Port 4000 is in use"**
→ Close the application using port 4000, or use a different port

