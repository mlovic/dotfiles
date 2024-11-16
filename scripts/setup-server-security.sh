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

# Install and configure fail2ban
log "Installing and configuring fail2ban..."
sudo apt-get install -y fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local || sudo cp /etc/fail2ban/jail.conf.default /etc/fail2ban/jail.local
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
SSHD_CONFIG="/etc/ssh/sshd_config"

# Backup with timestamp
sudo cp "$SSHD_CONFIG" "${SSHD_CONFIG}.bak.$(date +%Y%m%d_%H%M%S)"

# Function to safely modify SSH config
modify_sshd_config() {
    local param=$1
    local value=$2
    if sudo grep -q "^#*${param}" "$SSHD_CONFIG"; then
        # If parameter exists (commented or not), replace it
        sudo sed -i "s/^#*${param}.*/${param} ${value}/" "$SSHD_CONFIG"
    else
        # If parameter doesn't exist, append it
        echo "${param} ${value}" | sudo tee -a "$SSHD_CONFIG"
    fi
}

# Apply security settings
modify_sshd_config "PermitRootLogin" "no"
modify_sshd_config "PasswordAuthentication" "no"
modify_sshd_config "X11Forwarding" "no"
modify_sshd_config "MaxAuthTries" "3"

# Verify config file syntax
if ! sudo sshd -t; then
    error "SSH configuration is invalid. Please check $SSHD_CONFIG"
    # Optionally restore from backup
    exit 1
fi

# Check if SSH is still accessible (run in background)
(sleep 5; nc -zv localhost 22) &

sudo systemctl restart sshd

log "Server security setup complete!"
log "Next steps:"
log "1. Check UFW status: sudo ufw status"
log "2. Check fail2ban status: sudo fail2ban-client status"
