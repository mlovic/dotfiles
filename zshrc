# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="pygmalion"

export TERM="screen-256color"



# Fixes curl error (77)
#export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

stty stop undef # unmap <C-s>
stty erase '^?'

# Oh My ZSH
DISABLE_AUTO_UPDATE=true
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="false"
# Prevents command name from being repeated in output https://stackoverflow.com/questions/30940299/zsh-repeats-command-in-output
DISABLE_AUTO_TITLE="true"
ZSH_DISABLE_COMPFIX="true"

#plugins=(git tmux rails)
#
#zstyle ':omz:plugins:nvm' lazy yes
plugins=(
  git
  #nvm
)
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

source $ZSH/oh-my-zsh.sh

# Needs to be set after oh-my-zsh
HISTSIZE=2000000
HISTFILE=~/.zsh_history
SAVEHIST=2000000

if command -v rbenv &> /dev/null
then
  # Giving problems?
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
  export PATH="$HOME/.rbenv/shims:$PATH"
  export PATH="$HOME/.rbenv/bin:$PATH"
fi


# Set PATH
path=(
    $HOME/bin
    $HOME/.local/bin
    $HOME/.cargo/bin
    /usr/local/go/bin
    /usr/local/{bin,sbin}
    /usr/{bin,sbin}
    /{bin,sbin}
    $path
)
export PATH


export CDPATH=".:$HOME"

export EDITOR='vim'

# Needed on OS X
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# overriding git plugin alias...
alias gc="git commit -v -m"

source ~/.aliases
if [ -f ~/.local_aliases ]; then
    source ~/.local_aliases
fi
source ~/.functions

## TODO in not set already?
#CUSTOM_DOTFILES_PATH="$HOME/dotfiles/custom"
#echo "CUSTOM_DOTFILES_PATH is $CUSTOM_DOTFILES_PATH"
#ls $CUSTOM_DOTFILES_PATH
#if [ -f "$CUSTOM_DOTFILES_PATH/zshrc" ]; then
  #echo "sourcing custom zshrc"
  #source "$CUSTOM_DOTFILES_PATH/zshrc" 
#fi

# Additional PATH entries
path+=(
    $HOME/.linkerd2/bin
    $HOME/confluent-hub/bin
    /usr/local/kafka/bin
    $HOME/kafka/bin
)

# Load kubectl completion
source <(kubectl completion zsh)

#OktaAWSCLI
if [[ -f "$HOME/.okta/bash_functions" ]]; then
    . "$HOME/.okta/bash_functions"
fi
if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then
    PATH="$HOME/.okta/bin:$PATH"
fi

export PATH="$HOME/.okta/bin:$PATH"

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf configuration
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.git/*" -not -path "*/node_modules/*"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

precmd () { pwd > /tmp/whereami }
  # This lazy loads nvm
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
  nvm $@
}

export FLYCTL_INSTALL="/home/marko/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Load local zshrc customizations if present
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

alias python=python3
