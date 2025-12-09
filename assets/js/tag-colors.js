/**
 * Tag Color Assignment Script
 * Locks colors to tags - once a tag gets a color, it keeps that color forever
 * Uses localStorage to persist color assignments across page loads
 */

(function() {
  'use strict';

  // Color palette from _data/tags.yml
  const palette = [
    "#f44336", "#e91e63", "#9c27b0", "#673ab7", "#3f51b5", "#2196f3", "#03a9f4",
    "#00bcd4", "#009688", "#4caf50", "#8bc34a", "#cddc39", "#ffeb3b", "#ffc107",
    "#ff9800", "#ff5722", "#1abc9c", "#16a085", "#2ecc71", "#27ae60", "#3498db",
    "#2980b9", "#9b59b6", "#8e44ad", "#34495e", "#2c3e50", "#f1c40f", "#f39c12",
    "#e67e22", "#d35400", "#e74c3c", "#c0392b", "#ff6347", "#ff4500", "#ff8c00",
    "#ffd700", "#32cd32", "#00fa9a", "#00ced1", "#1e90ff", "#4169e1", "#9370db",
    "#ff1493", "#ff69b4", "#dc143c", "#1877f2", "#0088cc", "#1da1f2", "#0077b5",
    "#00aff0", "#0061ff", "#21759b", "#1ab7ea", "#4680c2", "#35465c", "#7c3aed",
    "#bd081c", "#ff0000", "#ff4500", "#b92b27", "#d32323", "#e6162d", "#da552f",
    "#ff6600", "#ff8800", "#fc4f08", "#fffc00", "#25d366", "#09b83e", "#00c300",
    "#00ab6c", "#00b488", "#4a154b", "#e4405f", "#ea4c89", "#0063dc", "#f94877",
    "#000000", "#1769ff", "#a4c400", "#60a917", "#008a00", "#00aba9", "#1ba1e2",
    "#0050ef", "#6a00ff", "#aa00ff", "#f472d0", "#d80073", "#a20025", "#e51400",
    "#fa6800", "#f0a30a", "#e3c800", "#825a2c", "#6d8764", "#647687", "#76608a",
    "#a0522d", "#ffb900", "#e74856", "#0078d7", "#0099bc", "#7a7574", "#767676",
    "#ff8c00", "#e81123", "#0063b1", "#2d7d9a", "#5d5a58", "#4c4a48", "#f7630c",
    "#ea005e", "#8e8cd8", "#00b7c3", "#68768a", "#69797e", "#ca5010", "#c30052",
    "#6b69d6", "#38387a", "#515c6b", "#4a5459", "#da3b01", "#e3008c", "#8764b8",
    "#00b294", "#567c73", "#647c64", "#ef6950", "#bf0077", "#744da9", "#185746",
    "#486860", "#525e54", "#d13438", "#c239b3", "#b146c2", "#00cc6a", "#498205",
    "#847545", "#ff4343", "#9a0089", "#881798", "#10893e", "#107c10", "#7e735f",
    "#ef4444", "#f97316", "#f59e0b", "#eab308", "#84cc16", "#22c55e", "#10b981",
    "#14b8a6", "#06b6d4", "#0ea5e9", "#3b82f6", "#6366f1", "#8b5cf6", "#a855f7",
    "#d946ef", "#ec4899", "#f43f5e"
  ];

  const STORAGE_KEY = 'jekyll_tag_colors';
  const STORAGE_VERSION = '1.0';

  /**
   * Generate a hash from a string (deterministic)
   * @param {string} str - The string to hash
   * @returns {number} - The hash value
   */
  function hashString(str) {
    let hash = 0;
    for (let i = 0; i < str.length; i++) {
      const char = str.charCodeAt(i);
      hash = ((hash << 5) - hash) + char;
      hash = hash & hash; // Convert to 32-bit integer
    }
    return Math.abs(hash);
  }

  /**
   * Normalize tag name for consistent matching
   */
  function normalizeTagName(str) {
    if (!str) return '';
    return str.trim().toLowerCase()
      .replace(/\s+/g, '-')
      .replace(/[^a-z0-9-]/g, '');
  }

  /**
   * Extract tag name from element
   */
  function getTagName(element) {
    // Try data-tag attribute first
    let tagName = element.getAttribute('data-tag');
    if (tagName) {
      return normalizeTagName(tagName);
    }

    // Try href attribute (e.g., /tags/kubernetes/)
    const href = element.getAttribute('href');
    if (href) {
      const match = href.match(/\/tags\/([^\/]+)\//);
      if (match && match[1]) {
        return normalizeTagName(decodeURIComponent(match[1]));
      }
    }

    // Fallback to text content
    const text = element.textContent || element.innerText;
    if (text) {
      // Remove count if present (e.g., "kubernetes 4" -> "kubernetes")
      const cleaned = text.replace(/\s+\d+$/, '').trim();
      return normalizeTagName(cleaned);
    }

    return '';
  }

  /**
   * Load locked color assignments from localStorage
   */
  function loadLockedColors() {
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      if (stored) {
        const data = JSON.parse(stored);
        if (data.version === STORAGE_VERSION && data.colors) {
          return new Map(data.colors);
        }
      }
    } catch (e) {
      console.warn('Tag Colors: Could not load locked colors from localStorage', e);
    }
    return new Map();
  }

  /**
   * Save locked color assignments to localStorage
   */
  function saveLockedColors(colorMap) {
    try {
      const data = {
        version: STORAGE_VERSION,
        colors: Array.from(colorMap.entries())
      };
      localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
    } catch (e) {
      console.warn('Tag Colors: Could not save locked colors to localStorage', e);
    }
  }

  /**
   * Get or assign a locked color for a tag
   * Once a tag gets a color, it's locked to that tag forever
   */
  function getOrAssignLockedColor(tagName, usedColors) {
    // Load existing locked colors
    const lockedColors = loadLockedColors();
    
    // If this tag already has a locked color, use it
    if (lockedColors.has(tagName)) {
      const lockedColor = lockedColors.get(tagName);
      // Verify the color is still in our palette
      if (palette.includes(lockedColor)) {
        return lockedColor;
      } else {
        // Color no longer in palette, remove it and assign new one
        lockedColors.delete(tagName);
      }
    }

    // Tag doesn't have a locked color yet - assign one
    // Use deterministic hash to get a starting point
    let colorIndex = hashString(tagName) % palette.length;
    let attempts = 0;
    let color = null;

    // Find an unused color (not used by other tags on this page AND not locked to other tags)
    const allUsedColors = new Set([...usedColors, ...Array.from(lockedColors.values())]);
    
    while (attempts < palette.length) {
      const candidateColor = palette[colorIndex];
      if (!allUsedColors.has(candidateColor)) {
        color = candidateColor;
        break;
      }
      colorIndex = (colorIndex + 1) % palette.length;
      attempts++;
    }

    // If all colors are used, use hash-based assignment (deterministic)
    if (!color) {
      colorIndex = hashString(tagName) % palette.length;
      color = palette[colorIndex];
    }

    // Lock this color to this tag permanently
    lockedColors.set(tagName, color);
    saveLockedColors(lockedColors);

    return color;
  }

  /**
   * Assign colors to all tags on the page
   * Uses locked colors - once a tag gets a color, it keeps it forever
   */
  function assignTagColors() {
    // Find all tag elements from the ENTIRE page
    // Include more specific selectors for the tags and categories pages
    // EXCLUDE navigation menu items
    const tagSelectors = [
      'a.post-tag',
      'a.tag[data-tag]',
      '#tags a.tag',  // Specific selector for tags page
      '#tags a[href*="/tags/"]',  // Alternative for tags page
      '#page-category a',  // Category archive page
      '#page-tag a'  // Tag archive page
    ];
    
    // Exclude navigation menu items
    const excludeSelectors = [
      '#sidebar a',  // Sidebar navigation
      'nav a',  // Any nav elements
      '.sidebar a',  // Sidebar class
      '#main-wrapper nav a',  // Main nav
      '[role="navigation"] a'  // Navigation role
    ];
    
    let tagElements = [];
    tagSelectors.forEach(selector => {
      try {
        const elements = document.querySelectorAll(selector);
        tagElements.push(...Array.from(elements));
      } catch (e) {
        console.warn('Tag Colors: Invalid selector:', selector, e);
      }
    });

    // Remove navigation menu items
    const excludedElements = new Set();
    excludeSelectors.forEach(selector => {
      try {
        const elements = document.querySelectorAll(selector);
        elements.forEach(el => excludedElements.add(el));
      } catch (e) {
        // Ignore invalid selectors
      }
    });

    // Filter out excluded elements
    tagElements = tagElements.filter(el => !excludedElements.has(el));

    // Remove duplicates
    tagElements = Array.from(new Set(tagElements));

    if (tagElements.length === 0) {
      console.warn('Tag Colors: No tag elements found on page');
      return;
    }

    console.log(`Tag Colors: Found ${tagElements.length} tag elements`);

    // Collect all unique tag names from the ENTIRE page
    const tagNames = new Set();
    tagElements.forEach(element => {
      const tagName = getTagName(element);
      if (tagName) {
        tagNames.add(tagName);
      }
    });

    // Load locked colors
    const lockedColors = loadLockedColors();
    const tagColorMap = new Map();
    const usedColors = new Set();

    // First, assign colors to tags that already have locked colors
    tagNames.forEach(tagName => {
      if (lockedColors.has(tagName)) {
        const color = lockedColors.get(tagName);
        if (palette.includes(color)) {
          tagColorMap.set(tagName, color);
          usedColors.add(color);
        }
      }
    });

    // Then, assign colors to new tags (tags without locked colors)
    const sortedNewTags = Array.from(tagNames)
      .filter(tagName => !tagColorMap.has(tagName))
      .sort();

    sortedNewTags.forEach(tagName => {
      const color = getOrAssignLockedColor(tagName, usedColors);
      tagColorMap.set(tagName, color);
      usedColors.add(color);
    });

    // Apply colors to all tag elements
    // Skip navigation menu items
    let appliedCount = 0;
    tagElements.forEach(element => {
      // Skip if element is in navigation menu
      if (element.closest('#sidebar') || 
          element.closest('nav') || 
          element.closest('[role="navigation"]') ||
          element.closest('.sidebar')) {
        return; // Skip navigation items
      }
      
      const tagName = getTagName(element);
      if (tagName && tagColorMap.has(tagName)) {
        const color = tagColorMap.get(tagName);
        
        // Check if this is a trending tag (in #panel-wrapper)
        const isTrendingTag = element.closest('#panel-wrapper') !== null;
        
        if (isTrendingTag) {
          // For trending tags: store color in CSS custom property for hover
          element.style.setProperty('--tag-hover-color', color);
          // Keep default grey color, color will show on hover via CSS
        } else {
          // For regular tags: apply color directly
          element.style.setProperty('color', color, 'important');
          element.style.color = color;
          // Remove any CSS classes that might set color
          element.classList.remove('text-muted', 'text-primary', 'link-primary');
          // Set attribute as well for extra specificity
          element.setAttribute('style', `color: ${color} !important;`);
        }
        appliedCount++;
      } else if (tagName) {
        console.warn('Tag Colors: No color found for tag:', tagName);
      }
    });

    console.log(`Tag Colors: Applied ${appliedCount} colors to ${tagElements.length} elements (${tagColorMap.size} unique tags, ${lockedColors.size} locked)`);
  }

  // Run when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
      assignTagColors();
      // Multiple delays to catch different rendering phases
      setTimeout(assignTagColors, 50);
      setTimeout(assignTagColors, 150);
      setTimeout(assignTagColors, 300);
      setTimeout(assignTagColors, 500);
    });
  } else {
    assignTagColors();
    setTimeout(assignTagColors, 50);
    setTimeout(assignTagColors, 150);
    setTimeout(assignTagColors, 300);
    setTimeout(assignTagColors, 500);
  }

  // Also run after page fully loads
  window.addEventListener('load', function() {
    assignTagColors();
    setTimeout(assignTagColors, 100);
    setTimeout(assignTagColors, 300);
  });

  // Use MutationObserver to catch dynamically added tags
  if (typeof MutationObserver !== 'undefined') {
    const observer = new MutationObserver(function(mutations) {
      let shouldUpdate = false;
      mutations.forEach(function(mutation) {
        if (mutation.addedNodes.length > 0) {
          mutation.addedNodes.forEach(function(node) {
            if (node.nodeType === 1) { // Element node
              if (node.matches && (
                node.matches('a.post-tag') || 
                node.matches('a.tag') ||
                node.matches('a[href*="/tags/"]') ||
                node.querySelector('a.post-tag, a.tag, a[href*="/tags/"]')
              )) {
                shouldUpdate = true;
              }
            }
          });
        }
      });
      if (shouldUpdate) {
        setTimeout(assignTagColors, 50);
      }
    });

    // Start observing
    observer.observe(document.body, {
      childList: true,
      subtree: true
    });
  }
})();
