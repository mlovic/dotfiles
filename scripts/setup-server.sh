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
    python3-pip \
    ufw \
    fail2ban \
    unattended-upgrades

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

# Configure UFW
log "Configuring firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable

# Configure fail2ban
log "Configuring fail2ban..."
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo tee /etc/fail2ban/jail.d/custom.conf > /dev/null <<EOL
[sshd]
enabled = true
bantime = 3600
findtime = 600
maxretry = 3
EOL
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Configure automatic security updates
log "Setting up unattended-upgrades..."
sudo tee /etc/apt/apt.conf.d/20auto-upgrades > /dev/null <<EOL
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOL

# Harden SSH configuration
log "Hardening SSH configuration..."
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo tee -a /etc/ssh/sshd_config > /dev/null <<EOL

# Security hardening
PermitRootLogin no
PasswordAuthentication no
X11Forwarding no
MaxAuthTries 3
EOL
sudo systemctl restart sshd

log "Server setup complete!"
log "Next steps:"
log "1. Install dotfiles: git clone https://github.com/mlovic/dotfiles.git ~/.dotfiles"
log "2. Run dotfiles installer: cd ~/.dotfiles && ./install.sh"
log "3. Check UFW status: sudo ufw status"
log "4. Check fail2ban status: sudo fail2ban-client status"
