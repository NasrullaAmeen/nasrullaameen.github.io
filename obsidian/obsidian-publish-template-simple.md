---
title: "{{title}}"
date: {{date:YYYY-MM-DD}} {{time:HH:mm:ss}} {{timezone}}
categories: []
tags: []
---

# {{title}}

---

## 📤 Publish to Website

### Method 1: Shell Commands Plugin (Recommended)

1. Install the [Shell Commands](https://github.com/Taitava/obsidian-shellcommands) plugin
2. Import the commands from `obsidian-shell-command.json`
3. Press `Ctrl+P` and type "Publish to Jekyll Website"

### Method 2: Quick Command

Press `Ctrl+P` and run:
```
Shell Commands: Execute: publish-to-jekyll
```

### Method 3: Manual Sync

Open PowerShell in the Jekyll site directory and run:
```powershell
.\sync-from-vault.ps1
```

---

**Note:** Make sure this file is in your vault's `Publish` folder before syncing!

