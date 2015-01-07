#! /bin/bash

if [[ $1 == "help" ]]; then
    echo "usage: update.sh <source root|help>
    -help - display this message
    -source root (optional), defaults to ~/source"
    exit 0
fi

if [[ ! -z "$1" ]]; then
    source_dir="$1"
else
    source_dir="$HOME/source"
fi

scripts="$source_dir/scripts"
dotfiles="$source_dir/dotfiles"
private="$source_dir/private"

if [[ -e $scripts ]]; then
    cd $scripts
    git pull
fi

if [[ -e $dotfiles ]]; then
    cd $dotfiles
    git pull
fi

if [[ -e $private ]]; then
    cd $private
    git pull
fi

# This is dangerous, unless we also use the source_dir
#$scripts/spit-xfce-config.sh
#$scripts/symlinks.sh
