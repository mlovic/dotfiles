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

## Prerequisites

- git
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
./scripts/setup-server.sh
./scripts/setup-server-security.sh
./install_dotfiles.sh
```

## Post-Installation

1. Start vim and run `:PlugInstall`
2. Restart your shell
3. For desktop setup, log out and select i3 as your window manager

## Customization

Local customizations can be added to:
- `~/.local_aliases`
- `~/.zshrc.local`
- Custom dotfiles in `~/dotfiles/custom/`

## License

MIT
