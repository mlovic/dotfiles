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

log "Server security setup complete!"
log "Next steps:"
log "1. Check UFW status: sudo ufw status"
log "2. Check fail2ban status: sudo fail2ban-client status"
