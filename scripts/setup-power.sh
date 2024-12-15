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

# Enable and start TLP
log "Configuring TLP..."
sudo systemctl enable tlp
sudo systemctl start tlp

# Configure TLP with better defaults
log "Setting up TLP configuration..."
sudo tee /etc/tlp.conf > /dev/null <<EOL
# CPU frequency scaling governor
CPU_SCALING_GOVERNOR_ON_AC=performance
CPU_SCALING_GOVERNOR_ON_BAT=powersave

# CPU energy/performance policies
CPU_ENERGY_PERF_POLICY_ON_AC=performance
CPU_ENERGY_PERF_POLICY_ON_BAT=power

# Disk devices power management
DISK_DEVICES="sda sdb"
DISK_APM_LEVEL_ON_AC="254 254"
DISK_APM_LEVEL_ON_BAT="128 128"

# WiFi power saving mode
WIFI_PWR_ON_AC=off
WIFI_PWR_ON_BAT=on

# PCI Express Active State Power Management
PCIE_ASPM_ON_AC=default
PCIE_ASPM_ON_BAT=powersave
EOL

# Run powertop auto-tune
log "Running powertop auto-tune..."
sudo powertop --auto-tune

log "Power management setup complete!"
log "You may need to reboot for all changes to take effect."
