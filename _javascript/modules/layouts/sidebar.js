const ATTR_DISPLAY = 'sidebar-display';
const STORAGE_KEY = 'sidebar-collapsed';
let $sidebar, $trigger, $toggle, $mask;

class SidebarUtil {
  static #isExpanded = false;
  static #isCollapsed = false;

  static toggle() {
    this.#isExpanded = !this.#isExpanded;
    document.body.toggleAttribute(ATTR_DISPLAY, this.#isExpanded);
    $sidebar.classList.toggle('z-2', this.#isExpanded);
    $mask.classList.toggle('d-none', !this.#isExpanded);
  }

  static toggleCollapse() {
    this.#isCollapsed = !this.#isCollapsed;
    $sidebar.classList.toggle('collapsed', this.#isCollapsed);
    document.body.classList.toggle('sidebar-collapsed', this.#isCollapsed);
    // Save state to localStorage
    if (this.#isCollapsed) {
      localStorage.setItem(STORAGE_KEY, 'true');
    } else {
      localStorage.removeItem(STORAGE_KEY);
    }
  }

  static initCollapsedState() {
    // Check localStorage for saved state
    const savedState = localStorage.getItem(STORAGE_KEY);
    if (savedState === 'true') {
      this.#isCollapsed = true;
      $sidebar.classList.add('collapsed');
      document.body.classList.add('sidebar-collapsed');
    }
  }
}

export function initSidebar() {
  // Wait for DOM to be ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      initSidebarHandlers();
    });
  } else {
    initSidebarHandlers();
  }
}

function initSidebarHandlers() {
  // Get elements
  $sidebar = document.getElementById('sidebar');
  $trigger = document.getElementById('sidebar-trigger');
  $toggle = document.getElementById('sidebar-toggle');
  $mask = document.getElementById('mask');
  
  // Debug: Check if elements are found
  if (!$toggle) {
    console.warn('Sidebar toggle button not found!');
    return;
  }
  
  // Mobile toggle (existing functionality)
  if ($trigger && $mask) {
    $trigger.onclick = $mask.onclick = () => SidebarUtil.toggle();
  }
  
  // Desktop collapse toggle - use onclick for better compatibility
  $toggle.onclick = function(e) {
    e.preventDefault();
    e.stopPropagation();
    console.log('Toggle button clicked!'); // Debug
    SidebarUtil.toggleCollapse();
  };
  
  // Initialize collapsed state from localStorage
  SidebarUtil.initCollapsedState();
}
