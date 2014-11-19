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
sudo $installer install git
sudo $installer install tmux
sudo $installer install wget
sudo $installer install sshfs
sudo $installer install subversion

if [[ "$os" == "ubuntu" ]]; then
    sudo $installer install xfce4 xfce4-goodies
    sudo $installer install make
    sudo $installer install gcc
    sudo $installer install default-jdk
    sudo $installer install ack-grep
elif [[ "$os" == "fedora" ]]; then
    sudo $installer install @xfce
    sudo $installer groupinstall "Development Tools"
    sudo $installer install java
    sudo $installer install ack
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
    sudo $installer update
    sudo $installer install google-chrome-stable
elif [[ "$os" == "fedora" ]]; then
    sudo cp ~/source/scripts/google-chrome.repo /etc/yum.repos.d
    sudo $installer install --nogpgcheck google-chrome-stable
fi

# Maven
wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar xvf apache-maven-3.0.5-bin.tar.gz
sudo cp -rf apache-maven-3.0.5 /usr/local/
rm -rf apache-maven-3.0.5
rm apache-maven-3.0.5-bin.tar.gz

# Leiningen
curl --insecure https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein | sudo tee /usr/local/bin/lein
sudo chmod a+x /usr/local/bin/lein

# Hipchat
if [[ "$os" == "ubuntu" ]]; then
    sudo su
    echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
          /etc/apt/sources.list.d/atlassian-hipchat.list
    wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
    $installer update
    $installer install hipchat
elif [[ "$os" == "fedora" ]]; then
    sudo su
    echo "[atlassian-hipchat]
name=Atlassian Hipchat
baseurl=http://downloads.hipchat.com/linux/yum
enabled=1
gpgcheck=1
gpgkey=https://www.hipchat.com/keys/hipchat-linux.key
" > /etc/yum.repos.d/atlassian-hipchat.repo
    yum install hipchat
fi

# BitchX
cd ~
svn checkout svn://svn.code.sf.net/p/bitchx/code/trunk bitchx-code
./configure --prefix=/usr
make
sudo make install

# DragonDisk (for s3)
if [[ "$os" == "ubuntu" ]]; then
    wget http://download.dragondisk.com/dragondisk_1.0.5-0ubuntu_amd64.deb
    sudo $installer install libqt4-dbus libqt4-network libqt4-xml libqtcore4 libqtgui4
    sudo dpkg -i dragondisk_1.0.5-0ubuntu_amd64.deb
elif [[ "$os" == "fedora" ]]; then
    cd ~
    wget http://download.dragondisk.com/dragondisk-1.0.5-1.i686.rpm
    sudo rpm -i dragondisk-1.0.5-1.i686.rpm
fi

# TODO
echo "More stuff to do:
---
* Device -> Insert Guest Additions CD...
* Right click on CD, mount, open terminal here
* Run VBoxInstaller.run as sudo
---
* cp ~/source/scripts/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/
---"

