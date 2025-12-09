// Obsidian Publish Button Script
// This can be used with Templater plugin or as a custom button

// For Templater plugin - add this as a user function
// File: .obsidian/templater/user_functions/publish.js

async function publishToWebsite() {
    const vaultPath = app.vault.adapter.basePath;
    const sitePath = "C:\\Users\\darko\\Documents\\GitHub\\nasrullaameen.github.io";
    const syncScript = `${sitePath}\\sync-from-vault.ps1`;
    
    // Get current file
    const activeFile = app.workspace.getActiveFile();
    if (!activeFile) {
        new Notice("No active file to publish");
        return;
    }
    
    // Check if file is in Publish folder
    const filePath = activeFile.path;
    if (!filePath.includes("Publish")) {
        new Notice("This file is not in the Publish folder. Move it to Publish folder first.");
        return;
    }
    
    // Execute sync script
    const { exec } = require('child_process');
    exec(`powershell.exe -File "${syncScript}"`, (error, stdout, stderr) => {
        if (error) {
            new Notice(`Error: ${error.message}`);
            return;
        }
        new Notice("✅ Published to website!");
        console.log(stdout);
    });
}

module.exports = publishToWebsite;

