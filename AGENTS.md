# AGENTS.md

## Setup and Management Commands

- **Install Stow:** `brew install stow`
- **Apply dotfiles:** `stow .` (run from dotfiles directory)
- **Install all packages:** `brew bundle` (installs from Brewfile)
- **Setup macOS settings:** `chmod +x ~/.macos && ~/.macos`
- **Setup tmux sessionizer:** `chmod +x ~/tmux-sessionizer`
- **Reload shell config:** `source ~/.zshrc` or `reload` alias

## Configuration File Guidelines

- **Shell Scripts (.sh, .zsh):**
  - Use 2-space indentation
  - Quote variables: `"$variable"` not `$variable`
  - Use `#!/bin/zsh` or `#!/bin/bash` shebangs
- **Lua Files (.lua):**
  - Follow existing Neovim config patterns
  - Use 2-space indentation, no tabs
  - Prefer explicit returns for plugin configs
- **YAML/Config Files:**
  - Maintain existing indentation (usually 2 spaces)
  - Keep comments aligned and descriptive
- **Naming Conventions:**
  - Config files: lowercase with dots (`.zshrc`, `.tmux.conf`)
  - Scripts: kebab-case (`tmux-sessionizer.sh`)
  - Directories: lowercase (`wallpapers/`, `.config/`)
- **File Organization:**
  - Keep related configs in `.config/` subdirectories
  - Use descriptive filenames that match their purpose
  - Maintain the existing directory structure