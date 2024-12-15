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
