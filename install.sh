#!/bin/bash
set -e

# TODO doesn't work if run from outside of dotfiles dir e.g. $ ./dotfiles/install.sh

# TODO should probably just do one file at a time e.g.:
#    $ ./install zshrc
#    Backing up existing...
#    Creating symlink...
     

#olddir=~/dotfiles_old
#echo "Creating $olddir for backup of any existing dotfiles in ~"		
#mkdir -p $olddir		

#dir=`pwd`
#files=`echo *($dir) `

#for file in $files; do		    
  #hidden=".$file" 
  #if [ -f ~/$hidden ];
  #then
    #echo "Moving existing $hidden ~ to $olddir"		    
    #mv ~/$hidden $olddir
  #fi
  #echo "Creating symlink to $hidden in home directory."		    
  ## broken for the dir, see http://stackoverflow.com/a/9104384/4088940
  #ln -s $dir/$file ~/$hidden
#done

mkdir ~/.config/i3
ln -s `pwd`/other/i3_config ~/.config/i3/config
ln -s `pwd`/other/toggle_keyboard_layout.sh ~/.config/i3/toggle_keyboard_layout.sh 

ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/zshrc ~/.zshrc
ln -s `pwd`/functions ~/.functions
ln -s `pwd`/aliases ~/.aliases
ln -s `pwd`/gitconfig ~/.gitconfig
