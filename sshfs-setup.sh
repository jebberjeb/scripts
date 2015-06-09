#! /bin/bash

sshfs_dir="$HOME/sshfs"

if [[ $1 == "cog-pair" ]]; then

    remote_host="cog-pair"
    remote_path="/home/pair"

elif [[ $1 == "lg-vm" ]]; then

    remote_host="budvar-vm"
    remote_path="/build"

fi

if [[ $2 == "help" ]]; then

    echo "usage: sshfs-setup cog-pair|lg-vm start|stop|help"
    echo "target directory is $sshfs_dir"

elif [[ $2 == "start" ]]; then

    if [[ ! -e $sshfs_dir ]]; then
        mkdir $sshfs_dir
    fi

    sshfs $remote_host:$remote_path $sshfs_dir

elif [[ $2 == "stop" ]]; then

    fusermount -u $sshfs_dir

fi
