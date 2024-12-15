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

# Install additional power management tools
log "Installing power management tools..."
sudo apt-get install -y \
    acpi \
    acpi-call-dkms \
    laptop-mode-tools

# Install and configure TLP
log "Configuring TLP..."
sudo apt-get install -y tlp tlp-rdw
sudo systemctl enable tlp.service
sudo systemctl start tlp.service

# Run powertop auto-tune
log "Running powertop auto-tune..."
sudo powertop --auto-tune

log "Power management setup complete!"
log "You may need to reboot for all changes to take effect."
