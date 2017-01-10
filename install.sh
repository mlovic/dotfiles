#!/bin/bash
set -e

olddir=~/dotfiles_old
echo "Creating $olddir for backup of any existing dotfiles in ~"		
mkdir -p $olddir		

dir=`pwd`
files=`ls $dir`

for file in $files; do		    
  hidden=".$file" 
  if [ -f ~/$hidden ];
  then
    echo "Moving existing $hidden ~ to $olddir"		    
    mv ~/$hidden $olddir
  fi
  echo "Creating symlink to $hidden in home directory."		    
  # broken for the dir, see http://stackoverflow.com/a/9104384/4088940
  ln -s $dir/$file ~/$hidden
done
