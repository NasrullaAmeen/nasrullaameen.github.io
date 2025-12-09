# Obsidian Integration Setup

This guide explains how to set up Obsidian to publish notes directly to your Jekyll website.

## Prerequisites

1. **Obsidian** installed and your vault set up
2. A **Publish** folder in your vault root
3. Your Jekyll site configured with `obsidian/vault-config.json`

## Setup Methods

### Method 1: Shell Commands Plugin (Recommended)

The Shell Commands plugin allows you to run scripts directly from Obsidian.

#### Installation

1. Open Obsidian Settings (`Ctrl+,` or `Cmd+,`)
2. Go to **Community plugins**
3. Search for **"Shell Commands"** by Taitava
4. Install and enable it

#### Configuration

1. In Obsidian Settings, go to **Shell Commands**
2. Click **"Open settings"**
3. Click **"Import from JSON file"**
4. Select the `obsidian/obsidian-shell-command.json` file from your Jekyll site folder
5. Update the paths in the imported commands to match your setup

#### Usage

1. Press `Ctrl+P` (or `Cmd+P` on Mac) to open Command Palette
2. Type **"Publish to Jekyll Website"**
3. Press Enter
4. The sync script will run and copy files from your Publish folder to `_posts`

### Method 2: Buttons Plugin

The Buttons plugin allows you to create clickable buttons in your notes.

#### Installation

1. Open Obsidian Settings
2. Go to **Community plugins**
3. Search for **"Buttons"** by shabegom
4. Install and enable it

#### Usage

Add a button to your template using this syntax:

````markdown
```button
name Publish to Website
type shell
action powershell.exe -File "C:\Users\darko\Documents\GitHub\nasrullaameen.github.io\scripts\sync-from-vault.ps1"
templater true
```
````

### Method 3: Templater Plugin (Advanced)

If you use the Templater plugin, you can add custom functions.

1. Install **Templater** plugin
2. Copy `obsidian/obsidian-publish-button.js` to `.obsidian/templater/user_functions/`
3. Use `obsidian/obsidian-publish-template-advanced.md` as your template

## Template Setup

### Using the Publish Template

1. Copy `obsidian/obsidian-publish-template.md` to your Obsidian templates folder
2. In Obsidian Settings → **Templates**, set your templates folder
3. When creating a new note in the Publish folder:
   - Press `Ctrl+P`
   - Type **"Templates: Insert template"**
   - Select **"obsidian-publish-template"**

### Template Features

The template includes:
- ✅ Proper Jekyll front matter format
- ✅ Date and time auto-population
- ✅ Publish instructions
- ✅ Quick access buttons (if using Buttons plugin)

## Workflow

1. **Create a new note** in your vault's `Publish` folder
2. **Use the template** to get the proper front matter
3. **Write your content**
4. **Fill in categories and tags** in the front matter
5. **Publish** using one of the methods above:
   - Shell Commands: `Ctrl+P` → "Publish to Jekyll Website"
   - Button: Click the "Publish to Website" button
   - Manual: Run `.\scripts\sync-from-vault.ps1` in PowerShell
6. **Preview** your site: `.\scripts\start-local-server.ps1`
7. **Commit and push** to GitHub to publish

## Troubleshooting

### "File not found" error
- Check that `obsidian/vault-config.json` has the correct vault path
- Ensure the Publish folder exists in your vault

### "Permission denied" error
- Make sure PowerShell execution policy allows scripts:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

### Button doesn't work
- Make sure the Buttons plugin is installed and enabled
- Check that the path in the button action is correct
- Try using Shell Commands plugin instead

### Files not syncing
- Verify the file is in the `Publish` folder
- Check that the file has proper front matter
- Run the sync script manually to see error messages

## Customization

### Update Paths

Edit `obsidian/obsidian-shell-command.json` and update the paths:

```json
{
  "shell_commands": [
    {
      "shell_command": "powershell.exe -File \"YOUR_PATH_HERE\\scripts\\sync-from-vault.ps1\""
    }
  ]
}
```

### Custom Template

You can customize `obsidian-publish-template.md` to match your workflow:
- Add default categories/tags
- Include your own sections
- Modify the front matter format

## Tips

- **Use watch mode** for automatic syncing: `.\scripts\sync-from-vault.ps1 -Watch`
- **Keep front matter consistent** - use the template every time
- **Test locally first** - run `.\start-local-server.ps1` to preview before pushing
- **Use categories and tags** - they help organize your site

