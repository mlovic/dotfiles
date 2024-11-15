#!/usr/bin/env bash
set -euo pipefail


# Check for required dependencies
check_dependency() {
    if ! command -v "$1" >/dev/null 2>&1; then
        error "$1 is required but not installed. Please install it first."
    fi
}

check_dependency "git"
check_dependency "curl"
check_dependency "vim"
check_dependency "zsh"

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Get the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/dotfiles.backup.$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() { echo -e "${GREEN}==>${NC} $1"; }
warn() { echo -e "${YELLOW}Warning:${NC} $1"; }
error() { echo -e "${RED}Error:${NC} $1"; exit 1; }

# Create backup directory if needed
backup_if_exists() {
    if [ -e "$1" ]; then
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            log "Created backup directory at $BACKUP_DIR"
        fi
        mv "$1" "$BACKUP_DIR/"
        log "Backed up existing $(basename "$1") to $BACKUP_DIR/"
    fi
}

# Ensure we're in the correct directory
cd "$DOTFILES_DIR"

# Create necessary directories
log "Creating required directories..."
mkdir -p ~/.config/i3
mkdir -p ~/.vim/autoload
mkdir -p ~/.oh-my-zsh-custom/themes

# Install vim-plug if not present
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    log "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Define files to symlink
declare -A files=(
    ["vimrc"]="$HOME/.vimrc"
    ["zshrc"]="$HOME/.zshrc"
    ["functions"]="$HOME/.functions"
    ["aliases"]="$HOME/.aliases"
    ["gitconfig"]="$HOME/.gitconfig"
    ["xprofile"]="$HOME/.xprofile"
    ["other/i3_config"]="$HOME/.config/i3/config"
    ["other/toggle_keyboard_layout.sh"]="$HOME/.config/i3/toggle_keyboard_layout.sh"
)

# Create symlinks
for source in "${!files[@]}"; do
    target="${files[$source]}"
    if [ -e "$DOTFILES_DIR/$source" ]; then
        backup_if_exists "$target"
        ln -sf "$DOTFILES_DIR/$source" "$target"
        log "Created symlink for $source"
    else
        warn "Source file $source does not exist"
    fi
done

# Make scripts executable
chmod +x "$HOME/.config/i3/toggle_keyboard_layout.sh"

log "Installation complete! Please restart your shell."
