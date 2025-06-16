# System Setup and Dotfiles

A comprehensive setup system for both desktop/laptop and server environments, including dotfiles configuration.

## Features

### System Setup
- **Desktop/Laptop Setup**: Complete i3-based desktop environment setup
  - Window management (i3)
  - Terminal configuration
  - Development tools
  - Common applications (Chrome, VLC, etc.)
  - Power management (TLP, powertop)

- **Server Setup**: Secure server environment configuration
  - Basic server tools
  - Security hardening
  - SSH configuration
  - Firewall setup (UFW)
  - Fail2ban installation

### Dotfiles
- Vim configuration with curated plugins
- Zsh setup with oh-my-zsh
- Git configuration
- Custom aliases and functions
- XProfile settings
- i3 window manager config

## Getting Started

Before using this repository, you'll need to:

1. Install Git:
```bash
sudo apt update
sudo apt install git
```

2. Set up SSH access:
   - If you have existing SSH keys:
     ```bash
     # Create .ssh directory with correct permissions
     mkdir -p ~/.ssh
     chmod 700 ~/.ssh
     
     # Copy your existing keys
     cp /path/to/id_ed25519 ~/.ssh/
     cp /path/to/id_ed25519.pub ~/.ssh/
     
     # Set correct permissions
     chmod 600 ~/.ssh/id_ed25519
     chmod 644 ~/.ssh/id_ed25519.pub
     ```
   - Or generate new SSH keys:
     ```bash
     ssh-keygen -t ed25519 -C "your.email@example.com"
     ```

3. Add your SSH key to GitHub:
   - Copy your public key:
     ```bash
     cat ~/.ssh/id_ed25519.pub
     ```
   - Add it to GitHub at https://github.com/settings/keys

4. Configure Git:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

5. Clone this repository:
```bash
git clone git@github.com:mlovic/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## Prerequisites

- sudo access
- Basic command line knowledge

## Installation

### For Desktop/Laptop Setup:

1. Clone the repository:
```bash
git clone https://github.com/mlovic/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Make scripts executable:
```bash
chmod +x install_dotfiles.sh scripts/*.sh
```

3. Run the laptop setup:
```bash
./scripts/setup-common.sh
./scripts/setup-laptop.sh
./install_dotfiles.sh
```

### For Server Setup:

1. Clone and prepare:
```bash
git clone https://github.com/mlovic/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x scripts/*.sh
```

2. Run the server setup:
```bash
./scripts/setup-common.sh
./scripts/setup-server-security.sh
./install_dotfiles.sh
```

## Post-Installation

1. Start vim and run `:PlugInstall`
2. Restart your shell
3. For desktop setup, log out and select i3 as your window manager

Go to `/etc/UPower/UPower.conf` and set:

```
PercentageLow=20        # You're already below this
PercentageCritical=10   # Still 5% to go
PercentageAction=5      # This is when it acts
CriticalPowerAction=Suspend
```

## Backup and Restore

To backup your system configuration and important files:
```bash
./scripts/backup-key-files.sh
```

This will create a timestamped archive containing:
- Shell history
- SSH and GPG keys
- Crontab entries
- System configuration files
- Package lists
- And more

To restore from a backup:
```bash
./scripts/restore-key-files.sh path/to/backup.tar.gz
```

## Customization

Local customizations can be added to:
- `~/.local_aliases`
- `~/.zshrc.local`
- Custom dotfiles in `~/dotfiles/custom/`

## License

MIT
