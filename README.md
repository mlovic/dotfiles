# Dotfiles

Personal dotfiles configuration for Linux/Unix systems.

## Prerequisites

- git
- zsh
- vim (8.0+)
- curl
- python3
- i3 (optional, for window management)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/mlovic/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the installer:
```bash
./install.sh
```

## What's Included

- Vim configuration with plugins
- Zsh configuration with oh-my-zsh
- Git configuration
- i3 window manager config
- Custom aliases and functions
- XProfile settings

## Post-Installation

1. Start vim and run `:PlugInstall`
2. Restart your shell
3. For i3 users, reload i3 config

## Customization

Local customizations can be added to:
- `~/.local_aliases`
- Custom dotfiles in `~/dotfiles/custom/`

## License

MIT
