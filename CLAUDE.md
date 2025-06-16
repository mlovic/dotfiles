# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository with system setup scripts for both desktop/laptop and server environments. It manages configuration files through symlinks and provides automated setup for development environments.

## Common Commands

### Installation and Setup
```bash
# Make scripts executable
chmod +x install_dotfiles.sh scripts/*.sh

# For laptop/desktop setup
./scripts/setup-common.sh
./scripts/setup-laptop.sh
./install_dotfiles.sh

# For server setup
./scripts/setup-common.sh
./scripts/setup-server-security.sh
./install_dotfiles.sh

# Install Python dependencies (if needed for scripts)
pip install -r requirements.txt
```

### Backup and Restore
```bash
# Create system backup
./scripts/backup-key-files.sh

# Restore from backup
./scripts/restore-key-files.sh path/to/backup.tar.gz
```

### Post-Installation
```bash
# After dotfiles installation, install vim plugins
vim +PlugInstall +qall
```

## Architecture and Structure

### Directory Layout
- `/dotfiles/` - All configuration files to be symlinked to home directory
- `/scripts/` - System setup and utility scripts
  - `setup-common.sh` - Installs packages for both server and desktop
  - `setup-laptop.sh` - Desktop-specific packages and configurations
  - `setup-server-security.sh` - Server hardening configurations
  - `backup-key-files.sh` / `restore-key-files.sh` - System backup utilities
- `/other/` - Additional configurations (i3 config, helper scripts)
- `/oh-my-zsh-custom/` - Custom oh-my-zsh themes

### Key Configuration Files
- **Shell**: `zshrc` (with oh-my-zsh), `aliases`, `functions`
- **Editor**: `vimrc` (uses vim-plug for plugin management)
- **Git**: `gitconfig` with custom aliases
- **Window Manager**: `i3_config` (in /other/), `i3status.conf`
- **Terminal**: `tmux.conf`, `alacritty.yml`

### Symlink Management
The `install_dotfiles.sh` script:
1. Backs up existing files to `~/dotfiles.backup.YYYYMMDD_HHMMSS/`
2. Creates symlinks from `/dotfiles/*` to `~/.*`
3. Handles special cases like `.config/` subdirectories
4. Creates necessary parent directories

### Customization Points
- `~/.local_aliases` - Local aliases (not version controlled)
- `~/.zshrc.local` - Local zsh configuration
- `~/dotfiles/custom/` - Directory for custom dotfiles

## Important Notes

- All scripts use `set -euo pipefail` for error handling
- The repository uses symlinks, so edits to config files in home directory will affect the repository
- The i3 window manager configuration uses vim-style navigation (hjkl)
- Terminal opens with working directory from `/tmp/whereami` if available
- Keyboard layout toggle is bound to `$mod+space` in i3