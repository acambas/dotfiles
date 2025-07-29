# AGENTS.md

## Build/Test/Lint Commands

- **No build system** - This is a dotfiles repository with configuration files only
- **Lua formatting:** `stylua .config/nvim/` (auto-formats on save via Conform.nvim)
- **Shell linting:** Use shellcheck for shell scripts (not automated)
- **Config validation:** `stow .` to test symlink creation without errors
- **Neovim config test:** `nvim --headless -c 'qa'` to validate Lua syntax

## Code Style Guidelines

- **Lua Files (.lua):**
  - 2-space indentation, no tabs
  - Return plugin config tables explicitly: `return { ... }`
  - Use `event = "VeryLazy"` for lazy loading
  - Quote keys in tables: `["key"] = value`
  - Follow existing plugin patterns in `.config/nvim/lua/acambas/plugins/`
- **Shell Scripts (.sh, .zsh):**
  - 2-space indentation
  - Quote all variables: `"$variable"` not `$variable`
  - Use proper shebangs: `#!/bin/zsh` or `#!/bin/bash`
- **Imports/Dependencies:**
  - Lua: Use `require("module")` at function scope when possible
  - Plugin dependencies: List in `dependencies = { ... }` array
- **Naming Conventions:**
  - Config files: lowercase with dots (`.zshrc`, `.tmux.conf`)
  - Plugin files: kebab-case (`multi-cursor.lua`, `better-yank.lua`)
  - Directories: lowercase (`wallpapers/`, `.config/`)
- **Error Handling:**
  - Use conditional sourcing: `[ -f file ] && source file`
  - Lua: Wrap risky operations in pcall when appropriate