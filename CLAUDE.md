# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing macOS configuration files and setup scripts. The repository uses GNU Stow for symlink management and includes configurations for:

- Neovim (Lua-based configuration)
- Zsh shell with Oh My Zsh
- Tmux terminal multiplexer
- WezTerm terminal emulator
- Homebrew package management
- Various CLI tools and applications

## Setup Commands

### Initial Setup
- Install Stow: `brew install stow`
- Create symlinks: `stow .` (run from dotfiles directory)
- Install packages: `brew bundle` (installs everything from Brewfile)
- Setup macOS settings: `chmod +x ~/.macos && ~/.macos`
- Setup tmux sessionizer: `chmod +x ~/tmux-sessionizer`

### Environment Configuration
- Create `.secrets.sh` in the repository root for environment variables (sourced automatically by `.zshrc`)
- Manual tools to install: Oh My Zsh, live-server, nvm
- Use `magic-wormhole` (via Homebrew) for secure secret transfer

## File Structure and Architecture

### Core Configuration Files
- `.zshrc` - Zsh shell configuration with aliases, PATH setup, and Oh My Zsh integration
- `.tmux.conf` - Tmux configuration with custom key bindings and session management
- `.wezterm.lua` - WezTerm terminal emulator configuration
- `Brewfile` - Homebrew dependencies (applications and CLI tools)
- `tmux-sessionizer.sh` - Script for tmux session management with project navigation

### Neovim Configuration Architecture
Located in `.config/nvim/` with a modular Lua structure:
- `init.lua` - Entry point that loads the main configuration
- `lua/acambas/` - Main configuration namespace containing:
  - `init.lua` - Core Neovim settings, autocommands, and custom commands
  - `keymaps.lua` - Global key mappings with leader key patterns
  - `lazy.lua` - Lazy.nvim plugin manager setup with auto-installation
  - `plugins/` - Individual plugin configurations (20+ files, one per plugin)

#### Plugin Management Patterns
- **Modular Design**: Each plugin has its own file in `plugins/` directory
- **Lazy Loading**: Extensive use of `event = "VeryLazy"` and conditional loading
- **VSCode Compatibility**: Many plugins use `cond = vscode_disable` to prevent conflicts
- **Consistent Structure**: All plugin files return tables with standard fields (dependencies, config, keys, etc.)

#### Key Mapping Conventions
- **Leader Key**: Space (`" "`) for both leader and local leader
- **Prefix Patterns**:
  - `<leader>s*` - Search operations (Telescope)
  - `<leader>g*` - Git operations (Lazygit)
  - `<leader>o*` - OpenCode AI operations
  - `<leader>c*` - Code/LSP operations
- **Performance**: Most keymaps use `{ silent = true }` option

#### Core Features
- **LSP**: Full language server support with Mason auto-installation
- **AI Integration**: Multiple AI assistants (Copilot, OpenCode, Avante)
- **File Management**: Oil.nvim for file operations instead of traditional file tree
- **Search**: Telescope with custom "smart grep" functionality
- **Git Workflow**: Lazygit integration with custom key bindings

### Additional Components
- `Library/Application Support/lazygit/config.yml` - Git UI configuration
- `Library/Keyboard Layouts/` - Custom keyboard layout (EurKEY)
- `wallpapers/` - Collection of desktop wallpapers

## Neovim Development Commands

### Custom Commands (available in Neovim)
- `:Finder` - Open current file in macOS Finder
- `:PathCopyRel` - Copy relative file path to clipboard
- `:PathCopyAbs` - Copy absolute file path to clipboard

### Plugin Management
- Lazy.nvim auto-installs on first run
- Plugin updates managed through lazy.nvim interface
- `lazy-lock.json` locks plugin versions for consistency

### Common Development Workflows
- **File Operations**: Use Oil.nvim (`<bs>` to open) instead of traditional file trees
- **Search Strategy**: Telescope smart grep with custom syntax (`search | file-pattern`)
- **AI Assistance**: Multiple tools available:
  - `<leader>oo` - OpenCode AI assistance
  - `<leader>oc` - OpenCode chat
  - GitHub Copilot for real-time completion
- **Git Operations**: 
  - `<leader>gg` - Open Lazygit
  - `<leader>gl` - Lazygit log view
- **LSP Operations**: Mason auto-installs language servers, formatters available via Conform.nvim

## Key Tools and Aliases

### Key Shell Aliases (from .zshrc)
- `reload` - Reload zsh configuration
- `lg` - Launch lazygit
- `vi`/`vim` - Use neovim
- `v.` - Open current directory in neovim
- Configuration editing: `config.zsh`, `config.tmux`, `config.wezterm`, `config.vim`, `config.secrets`, `config.macos`
- Navigation: `..` (cd up), `c` (clear), `hg` (history grep)

### Development Environment
- Editor: Neovim with extensive Lua configuration
- Terminal: WezTerm with custom settings
- Shell: Zsh with Oh My Zsh, fzf integration
- Git UI: Lazygit for version control
- Package Manager: Homebrew for macOS applications and tools

## Notes
- No traditional build/test commands as this is a configuration repository
- Use `stow .` to apply configuration changes
- Use `brew bundle` to install/update applications
- Configuration is designed for macOS environment
- Secrets should be stored in `.secrets.sh` (not tracked in git)