# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="pygmalion"

export TERM="screen-256color"

setxkbmap -option ctrl:nocaps


# Fixes curl error (77)
#export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# Save more history
#
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=50000

stty stop undef # unmap <C-s>
stty erase '^?'

# Oh My ZSH
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="false"
#plugins=(git tmux rails)
plugins=(git)
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

source $ZSH/oh-my-zsh.sh

# Needs to be set after oh-my-zsh
HISTSIZE=20000
SAVEHIST=20000

# Giving problems?
# eval "$(rbenv init -)"

export PATH="$HOME/anaconda2/bin:/usr/local/heroku/bin:$HOME/.rbenv/plugins/ruby-build/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0:$HOME/scripts/bin:$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"

export CDPATH=".:$HOME:$HOME/School:$HOME/.vim"

export EDITOR='vim'

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# overriding git plugin alias...
alias gc="git commit -v -m"

lariosrsync () {
  if [ "$#" -eq 3 ]; then
    rsync -e "ssh -p 22000" $1 $2 deploy@82.196.6.160:/home/deploy/$3
  fi
  if [ "$#" -eq 2 ]; then
    rsync -e "ssh -p 22000" $1 deploy@82.196.6.160:/home/deploy/$2
  fi
}
source ~/.aliases
if [ -f ~/.local_aliases ]; then
    source ~/.local_aliases
fi
source ~/.functions

if type "rbenv" > /dev/null; then
  #eval "$(rbenv init -)"
  # Faster than above. Might need to rehash manually after updates!
  eval "$(rbenv init - --no-rehash)"
fi
