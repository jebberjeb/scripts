#! /bin/bash

sshfs_dir="$HOME/sshfs"

if [[ $1 == "help" ]]; then

    echo "usage: sshfs-cog-pair start|stop|help"
    echo "target directory is $sshfs_dir"

elif [[ $1 == "start" ]]; then

    if [[ ! -e $sshfs_dir ]]; then
        mkdir $sshfs_dir
    fi

    sshfs cog-pair:/home/pair $sshfs_dir

elif [[ $1 == "stop" ]]; then

    fusermount -u $sshfs_dir

fi
