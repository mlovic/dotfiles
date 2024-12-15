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

if [ $# -ne 1 ]; then
    error "Usage: $0 <backup-archive.tar.gz>"
fi

BACKUP_ARCHIVE="$1"
if [ ! -f "$BACKUP_ARCHIVE" ]; then
    error "Backup archive not found: $BACKUP_ARCHIVE"
fi

# Extract archive
TEMP_DIR="/tmp/system-restore-$(date +%s)"
mkdir -p "$TEMP_DIR"
tar xzf "$BACKUP_ARCHIVE" -C "$TEMP_DIR"
BACKUP_DIR="$TEMP_DIR/$(ls "$TEMP_DIR")"

# Restore user files
log "Restoring user files..."
cp -r "$BACKUP_DIR/.zsh_history" "$HOME/" 2>/dev/null || true
cp -r "$BACKUP_DIR/.bash_history" "$HOME/" 2>/dev/null || true
cp -r "$BACKUP_DIR/.viminfo" "$HOME/" 2>/dev/null || true
cp -r "$BACKUP_DIR/.ssh" "$HOME/"

# Restore crontab
log "Restoring crontab..."
[ -f "$BACKUP_DIR/user-crontab" ] && crontab "$BACKUP_DIR/user-crontab"
[ -f "$BACKUP_DIR/root-crontab" ] && sudo crontab "$BACKUP_DIR/root-crontab"

# Restore system files (requires sudo)
log "Restoring system files..."
sudo cp "$BACKUP_DIR/hosts" /etc/hosts

# Clean up
rm -rf "$TEMP_DIR"

log "System restore complete!"
log "You may need to restart for some changes to take effect."
