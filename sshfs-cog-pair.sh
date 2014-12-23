#! /bin/bash

if [[ $1 == "start" ]]; then

    if [[ ! -e ~/sshfs ]]; then
        mkdir ~/sshfs
    fi

    sshfs cog-pair:/home/pair ~/sshfs
fi

