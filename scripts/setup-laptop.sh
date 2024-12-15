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

# Install laptop-specific packages
log "Installing laptop-specific packages..."
sudo apt-get install -y \
    i3 \
    i3status \
    dmenu \
    xclip \
    arandr \
    feh \
    pavucontrol \
    pulseaudio \
    network-manager \
    blueman

# Copy i3 config
log "Setting up i3 config..."
mkdir -p ~/.config/i3
cp other/i3_config ~/.config/i3/config

log "Laptop-specific setup complete!"
log "Next steps:"
log "1. Log out and select i3 as your window manager at the login screen"
log "2. Review and customize ~/.config/i3/config as needed"
