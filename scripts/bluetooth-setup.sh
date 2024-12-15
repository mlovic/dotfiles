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

# Enable and start bluetooth service
log "Enabling bluetooth service..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Ensure PipeWire services are running
log "Ensuring PipeWire services are running..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber

log "Bluetooth setup complete!"
log "You can use 'bluetoothctl' for command-line management or blueberry-tray for GUI"
log "Common bluetoothctl commands:"
log "  power on     - Turn on bluetooth"
log "  scan on      - Start scanning for devices"
log "  devices      - List detected devices"
log "  pair XX:XX   - Pair with a device"
log "  connect XX:XX- Connect to a device"
log "  trust XX:XX  - Trust a device"
