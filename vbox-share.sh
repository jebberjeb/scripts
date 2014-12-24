#! /bin/bash

share_dir="$HOME/virtualbox-share"

if [[ ! -e $share_dir ]]; then
    mkdir $share_dir
fi

sudo mount -t vboxsf virtualbox-share $share_dir
