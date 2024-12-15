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

# Add Google Chrome repository
log "Adding Google Chrome repository..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update

# Install laptop-specific packages
log "Installing laptop-specific packages..."
sudo apt-get install -y \
    i3 \
    i3status \
    dmenu \
    xclip \
    arandr \
    feh \
    network-manager \
    google-chrome-stable \
    powertop \
    tlp \
    vlc \
    shutter

    pavucontrol \
    pulseaudio \
    bluetooth \
    blueberry

# Install Solarized for GNOME Terminal
log "Installing Solarized for terminal..."
git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git /tmp/gnome-terminal-colors-solarized
/tmp/gnome-terminal-colors-solarized/install.sh --skip-dircolors
rm -rf /tmp/gnome-terminal-colors-solarized

# Configure Caps Lock as Control
log "Setting Caps Lock as Control..."
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

log "Laptop-specific setup complete!"
log "Next steps:"
log "1. Log out and select i3 as your window manager at the login screen"
log "2. Review and customize ~/.config/i3/config as needed"
