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

ubuntu=0

if [[ 1 = $(uname --all | grep -c Ubuntu) ]]; then
    ubuntu=1
fi

# Set Central timezone
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

# Other OS specific stuff
sudo adduser jeb audio
if [[ 1 = $ubuntu ]]; then
    echo "using ubuntu server, don't need to turn off gui boot"
else
    sudo systemctl set-default multi-user.target
fi

# Install packages
if [[ 1 = $ubuntu ]]; then

    # Same name, just using apt-get
    sudo apt-get -y install python
    sudo apt-get -y install ruby
    sudo apt-get -y install java
    sudo apt-get -y install git
    sudo apt-get -y install ack
    sudo apt-get -y install tmux
    sudo apt-get -y install wget
    sudo apt-get -y install sshfs
    sudo apt-get -y install BitchX

    # Different package names
    sudo apt-get -y install xfce4 xfce4-goodies
    sudo apt-get -y install make
    sudo apt-get -y install gcc

else

    # Same name, just using yum
    sudo yum -y install python
    sudo yum -y install ruby
    sudo yum -y install java
    sudo yum -y install git
    sudo yum -y install ack
    sudo yum -y install tmux
    sudo yum -y install wget
    sudo yum -y install sshfs
    sudo yum -y install BitchX

    # Differnt package names
    sudo yum -y install @xfce
    sudo yum -y groupinstall "Development Tools"
fi

# dotfiles
mkdir ~/source
cd ~/source
git clone https://github.com/jebberjeb/scripts
git clone https://github.com/jebberjeb/dotfiles

cd ~
rm .bashrc
rm .bash_profile
~/source/scripts/symlinks.sh

# Vim
~/source/scripts/vim-install.sh
~/source/scripts/vim-setup.sh

# Other apps/tools w/ more complex setup

## Chrome
if [[ 1 = $ubuntu ]]; then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get -y update
    sudo apt-get -y install google-chrome-stable
else
    sudo cp ~/source/scripts/google-chrome.repo /etc/yum.repos.d
    sudo yum -y install --nogpgcheck google-chrome-stable
fi

## Maven
wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar xvf apache-maven-3.0.5-bin.tar.gz
sudo cp -rf apache-maven-3.0.5 /usr/local/
rm -rf apache-maven-3.0.5
rm apache-maven-3.0.5-bin.tar.gz

## Leiningen
curl --insecure https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein | sudo tee /usr/local/bin/lein
sudo chmod a+x /usr/local/bin/lein

