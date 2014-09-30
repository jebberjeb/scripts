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

# Set Central timezone
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

# Setup desktop (xfce)
sudo yum -y install @xfce
sudo systemctl set-default multi-user.target

# Tools (that go on easy)
sudo yum -y install git
sudo yum -y groupinstall "Development Tools"
sudo yum -y install ack
sudo yum -y install tmux
sudo yum -y install wget

# dotfiles
mkdir ~/source
cd ~/source
git clone https://github.com/jebberjeb/scripts
git clone https://github.com/jebberjeb/dotfiles

cd ~
rm .bashrc
rm .bash_profile
ln -s ~/source/dotfiles/.bashrc ~/.bashrc
ln -s ~/source/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/source/dotfiles/.vimrc ~/.vimrc
ln -s ~/source/dotfiles/.vim ~/.vim
ln -s ~/source/dotfiles/.git-prompt.sh ~/.git-prompt.sh
ln -s ~/source/dotfiles/.lein ~/.lein
ln -s ~/source/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/source/dotfiles/.gitignore ~/.gitignore
ln -s ~/source/dotfiles/.gitconfig ~/.gitconfig

# Vim
~/source/scripts/vim-install.sh
~/source/scripts/vim-setup.sh

# Other apps/tools w/ more complex setup

## skype
wget http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm
sudo yum -y localinstall skype-4.3.0.37-fedora.i586.rpm

## chrome
sudo cp ~/source/scripts/google-chrome.repo /etc/yum.repos.d
sudo yum -y install --nogpgcheck google-chrome-stable

## java
wget https://www.dropbox.com/sh/at2y14m65f12qe9/AAAX9amN5DyuoUu8AZPGJ1F5a/virtualbox-stuff/jdk-7u60-linux-x64.rpm
sudo rpm -i jdk-7u60-linux-x64.rpm
sudo rm /usr/bin/java
sudo ln -s /usr/java/default/bin/java /usr/bin/java

## maven
wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar xvf apache-maven-3.0.5-bin.tar.gz
sudo cp -rf apache-maven-3.0.5 /usr/local/
rm -rf apache-maven-3.0.5
rm apache-maven-3.0.5-bin.tar.gz

## lein
curl --insecure https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein | sudo tee /usr/local/bin/lein
sudo chmod a+x /usr/local/bin/lein
