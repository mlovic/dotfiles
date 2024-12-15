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

# Create backup directory with timestamp
BACKUP_DIR="$HOME/system-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
log "Created backup directory at $BACKUP_DIR"

# Backup user-specific files
log "Backing up user files..."
cp -r "$HOME/.zsh_history" "$BACKUP_DIR/"
cp -r "$HOME/.bash_history" "$BACKUP_DIR/" 2>/dev/null || true
cp -r "$HOME/.viminfo" "$BACKUP_DIR/" 2>/dev/null || true
cp -r "$HOME/.ssh" "$BACKUP_DIR/"
cp -r "$HOME/secrets" "$BACKUP_DIR/" 2>/dev/null || true

# Backup crontab
log "Backing up crontab..."
crontab -l > "$BACKUP_DIR/user-crontab" 2>/dev/null || true
sudo crontab -l > "$BACKUP_DIR/root-crontab" 2>/dev/null || true

# Backup system files (requires sudo)
log "Backing up system files..."
sudo cp /etc/hosts "$BACKUP_DIR/"
sudo cp /etc/fstab "$BACKUP_DIR/"

# Backup installed packages list
log "Backing up package lists..."
dpkg --get-selections > "$BACKUP_DIR/installed-packages"
apt-mark showmanual > "$BACKUP_DIR/manually-installed-packages"
snap list > "$BACKUP_DIR/snap-packages" 2>/dev/null || true

# Backup PPAs
log "Backing up PPAs..."
grep -r "^deb" /etc/apt/sources.list /etc/apt/sources.list.d/ > "$BACKUP_DIR/ppas" 2>/dev/null || true

# Create archive
log "Creating archive..."
cd "$(dirname "$BACKUP_DIR")"
tar czf "$(basename "$BACKUP_DIR").tar.gz" "$(basename "$BACKUP_DIR")"
rm -rf "$BACKUP_DIR"

log "Backup complete! Archive created at ${BACKUP_DIR}.tar.gz"
log "Consider copying this archive to a secure location."
