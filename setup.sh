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
echo "Disabling SE Linux"
echo "SELINUX=disabled
SELINUXTYPE=targeted" | sudo tee /etc/selinux/config

# Prime installer
echo "Prime installer"
sudo apt-get -y update

# Set Central timezone
echo "Set timezone"
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

# Turn on audio
echo "Configure audio"
sudo usermod -a -G audio jeb

# Install packages
echo "Install apt-get packages"
sudo apt-get -y install python
sudo apt-get -y install ruby
sudo apt-get -y install git
sudo apt-get -y install tmux
sudo apt-get -y install wget
sudo apt-get -y install sshfs
sudo apt-get -y install subversion
sudo apt-get -y install xfce4 xfce4-goodies
sudo apt-get -y install gnome-icon-theme-full tango-icon-theme
sudo apt-get -y install make
sudo apt-get -y install gcc
sudo apt-get -y install default-jdk
sudo apt-get -y install ack-grep
sudo apt-get -y install libncurses5-dev
sudo apt-get -y install python-dev
sudo apt-get -y install ruby-dev

# dotfiles
echo "Setup dotfiles and scripts"
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

# Chrome
echo "Install Chrome"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable

# Maven
echo "Install Maven"
wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar xvf apache-maven-3.0.5-bin.tar.gz
sudo cp -rf apache-maven-3.0.5 /usr/local/
rm -rf apache-maven-3.0.5
rm apache-maven-3.0.5-bin.tar.gz

# Leiningen
echo "Install Leiningen"
curl --insecure https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein | sudo tee /usr/local/bin/lein
sudo chmod a+x /usr/local/bin/lein

# Hipchat
echo "Install HipChat"
sudo echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
      /etc/apt/sources.list.d/atlassian-hipchat.list
sudo wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
sudo apt-get -y update
sudo apt-get -y install hipchat

# BitchX
echo "Install BitchX"
cd ~
svn checkout svn://svn.code.sf.net/p/bitchx/code/trunk bitchx-code
cd bitchx-code
./configure --prefix=/usr
make
sudo make install

# DragonDisk (for s3)
echo "Install DragonDisk"
wget http://download.dragondisk.com/dragondisk_1.0.5-0ubuntu_amd64.deb
sudo apt-get -y install libqt4-dbus libqt4-network libqt4-xml libqtcore4 libqtgui4
sudo dpkg -i dragondisk_1.0.5-0ubuntu_amd64.deb

# Vim
echo "Install Vim"
cd ~
git clone https://github.com/b4winckler/vim.git ~/vim
cd ~/vim
git checkout tags/v7-4-200
make distclean
./configure --enable-rubyinterp --enable-pythoninterp --enable-multibyte --with-features=big --prefix=/usr
make
sudo make install
~/source/scripts/vim-setup.sh

# TODO
echo "More stuff to do:
---
* After running xfce, ~/source/scripts/spit-xfce-config.sh
---
* Device -> Insert Guest Additions CD...
* Right click on CD, mount, open terminal here
* Run VBoxInstaller.run as sudo
---
copy over ssh key
---
clone private repo
---
"
