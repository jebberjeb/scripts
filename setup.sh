#! /bin/bash

echo "Testing sudo access"
sudo touch /foo
if [[ $? -ne 0 ]]; then
    echo "Making user a sudoer, enter su password"
    su -c "usermod jeb -a -G wheel"
    echo "Log out, back in, then rerun script"
    exit -1
fi

# Turn off SELinux
echo "SELINUX=disabled
SELINUXTYPE=targeted" | sudo tee /etc/selinux/config

# Grab env script, set os, installer
curl https://raw.githubusercontent.com/jebberjeb/scripts/master/env.sh > env.sh
. env.sh
set_os

# Set Central timezone
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

# Turn on audio
sudo adduser jeb audio

# Only need to disable gui boot on Fedora, since we're using
# Ubuntu server.
if [[ "$os" == "fedora" ]]; then
    sudo systemctl set-default multi-user.target
fi

# Install packages
sudo $installer install python
sudo $installer install ruby
sudo $installer install java
sudo $installer install git
sudo $installer install ack
sudo $installer install tmux
sudo $installer install wget
sudo $installer install sshfs
sudo $installer install BitchX

if [[ "$os" == "ubuntu" ]]; then
    sudo apt-get -y install xfce4 xfce4-goodies
    sudo apt-get -y install make
    sudo apt-get -y install gcc
elif [[ "$os" == "fedora" ]]; then
    sudo yum -y install @xfce
    sudo yum -y groupinstall "Development Tools"
fi

# dotfiles
mkdir ~/source
cd ~/source
git clone https://github.com/jebberjeb/scripts
git clone https://github.com/jebberjeb/dotfiles

cd ~
# Only remove these two dotfiles, since this script is used for
# setting up a fresh install.
rm .bashrc
rm .bash_profile
~/source/scripts/symlinks.sh

# Vim
~/source/scripts/vim-install.sh
~/source/scripts/vim-setup.sh

# Chrome
if [[ "$os" == "ubuntu" ]]; then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get -y update
    sudo apt-get -y install google-chrome-stable
elif [[ "$os" == "fedora" ]]; then
    sudo cp ~/source/scripts/google-chrome.repo /etc/yum.repos.d
    sudo yum -y install --nogpgcheck google-chrome-stable
fi

# Maven
wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar xvf apache-maven-3.0.5-bin.tar.gz
sudo cp -rf apache-maven-3.0.5 /usr/local/
rm -rf apache-maven-3.0.5
rm apache-maven-3.0.5-bin.tar.gz

## Leiningen
curl --insecure https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein | sudo tee /usr/local/bin/lein
sudo chmod a+x /usr/local/bin/lein

