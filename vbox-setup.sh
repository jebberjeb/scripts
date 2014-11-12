#! /bin/bash

# if not exist, make these
# mkdir ~/virtualbox-share
# mkdir ~/sshfs

echo "mount -t vboxsf virtualbox-share ~/virtualbox-share"
echo "sshfs cog-pair:/home/pair ~/sshfs
