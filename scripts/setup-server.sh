#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() { echo -e "${GREEN}==>${NC} $1"; }
warn() { echo -e "${YELLOW}Warning:${NC} $1"; }
error() { echo -e "${RED}Error:${NC} $1"; exit 1; }

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    error "Please run without sudo"
fi

# Update system packages
log "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y

# Install essential packages
log "Installing essential packages..."
sudo apt-get install -y \
    curl \
    git \
    vim \
    zsh \
    tmux \
    htop \
    tree \
    unzip \
    python3 \
    python3-pip

# Install fzf from source
log "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Setup SSH key
setup_ssh() {
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
        log "Setting up SSH key..."
        ssh-keygen -t ed25519 -C "mlovicbueno@gmail.com" -N "" -f "$HOME/.ssh/id_ed25519"
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_ed25519"
        
        echo
        log "Your public SSH key is:"
        cat "$HOME/.ssh/id_ed25519.pub"
        echo
        log "Please add this key to your GitHub account at https://github.com/settings/keys"
    else
        warn "SSH key already exists at ~/.ssh/id_ed25519"
    fi
}

# Configure git
setup_git() {
    log "Configuring git..."
    git config --global user.name "Marko Lovic"
    git config --global user.email "mlovicbueno@gmail.com"
    git config --global core.editor vim
    git config --global init.defaultBranch main
}

# Main
setup_ssh
setup_git

# Set zsh as default shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    log "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

log "Basic server setup complete!"
log "Next steps:"
log "1. Install dotfiles: git clone https://github.com/mlovic/dotfiles.git ~/.dotfiles"
log "2. Run dotfiles installer: cd ~/.dotfiles && ./install.sh"
log "3. For security setup, run: ./setup-server-security.sh"
