---
title: "{{title}}"
date: {{date:YYYY-MM-DD}} {{time:HH:mm:ss}} {{timezone}}
categories: []
tags: []
---

# {{title}}

---

## 📤 Publish to Website

> [!tip] Quick Publish
> Use one of the methods below to publish this note to your Jekyll website.

### Method 1: Shell Commands Plugin (Recommended)

1. Install the [Shell Commands](https://github.com/Taitava/obsidian-shellcommands) plugin
2. Import the commands from `obsidian/obsidian-shell-command.json` in your Jekyll site folder
3. Press `Ctrl+P` (or `Cmd+P` on Mac)
4. Type: **"Publish to Jekyll Website"**
5. Press Enter

### Method 2: Buttons Plugin

If you have the [Buttons](https://github.com/shabegom/buttons) plugin installed, add this to your note:

````markdown
```button
name 🚀 Publish to Website
type shell
action powershell.exe -File "C:\Users\darko\Documents\GitHub\nasrullaameen.github.io\scripts\sync-from-vault.ps1"
templater true
```
````

> [!note] Update Path
> Make sure to update the path in the button action to match your Jekyll site location.

### Method 3: Manual Sync

Open PowerShell in your Jekyll site directory and run:

```powershell
.\scripts\sync-from-vault.ps1
```

---

> [!warning] Before Publishing
> - Make sure this file is in your vault's **Publish** folder
> - Check that the front matter (title, date, categories, tags) is correct
> - The file will be copied to `_posts` with format: `YYYY-MM-DD-title-slug.md`

---
