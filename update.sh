#! /bin/bash

source_dir="$HOME/source"
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

$scripts/spit-xfce-config.sh
$scripts/symlinks.sh
