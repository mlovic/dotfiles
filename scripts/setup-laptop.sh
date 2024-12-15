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
    network-manager
    #pavucontrol \
    #pulseaudio \
    #blueman

log "Laptop-specific setup complete!"
log "Next steps:"
log "1. Log out and select i3 as your window manager at the login screen"
log "2. Review and customize ~/.config/i3/config as needed"
