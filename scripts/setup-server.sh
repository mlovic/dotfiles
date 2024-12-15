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
    pipx \
    python3 \
    python3-pip

# Install fzf from source
log "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

log "Installing aider..."
pipx install aider-chat

# Configure git
setup_git() {
    log "Configuring git..."
    git config --global user.name "Marko Lovic"
    git config --global user.email "mlovicbueno@gmail.com"
    git config --global core.editor vim
    git config --global init.defaultBranch main
}

# Main
setup_git

# Set zsh as default shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    log "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

log "Basic server setup complete!"
log "Next steps:"
log "1. Setup SSH key: ./setup-ssh.sh"
log "2. Install dotfiles: git clone https://github.com/mlovic/dotfiles.git ~/.dotfiles"
log "3. Run dotfiles installer: cd ~/.dotfiles && ./install.sh"
log "4. For security setup, run: ./setup-server-security.sh"
