#! /bin/bash

# History
# -------
# * 2021-03-02 - Revamped for Azure VM running Ubuntu 18.04 LTS

cd ~
mkdir source

SOURCE_PATH=$HOME/source

function install_packages() {
    sudo apt-get -y install ruby
    sudo apt-get -y install xfce4 xfce4-goodies
    sudo apt-get -y install gnome-icon-theme-full tango-icon-theme
    sudo apt-get -y install make
    sudo apt-get -y install gcc
    sudo apt-get -y install default-jdk
    sudo apt-get -y install silversearcher-ag
    sudo apt-get -y install libncurses5-dev
    sudo apt-get -y install python-dev
    sudo apt-get -y install ruby-dev
    sudo apt-get -y install iotop
    sudo apt-get -y install rlwrap
    sudo apt-get -y install tree
    sudo apt-get -y install ctags
    sudo apt install -y postgresql-client-common
    sudo apt install -y postgresql-client
}

function setup_nodejs() {
    curl -sL https://deb.nodesource.com/setup_13.x | sudo bash -
    sudo apt-get install -y nodejs
}

function setup_dotfiles() {
    cd $SOURCE_PATH
    git clone https://github.com/jebberjeb/scripts
    git clone https://github.com/jebberjeb/dotfiles

    cd ~
    rm .bashrc
    rm .bash_profile
    EFS_SOURCE_PATH=$SOURCE_PATH INSTALL_HOME=$HOME $SOURCE_PATH/scripts/symlinks.sh
}

function install_chrome() {
    sudo bash -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
    sudo bash -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get -y install google-chrome-stable
}

function install_leiningen() {
    curl --insecure https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein | sudo tee /usr/local/bin/lein
    sudo chmod a+x /usr/local/bin/lein
}

function install_neovim() {
    sudo apt-get install -y cmake
    sudo apt-get install -y build-essential
    sudo apt-get install -y libtool
    sudo apt-get install -y libtool-bin
    sudo apt-get install -y pkg-config
    sudo apt-get install -y automake
    sudo apt-get install -y gettext
    cd ~
    git clone https://github.com/neovim/neovim.git
    cd neovim
    sudo make install
    cd ~
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    nvim +PluginInstall +qall
}

function install_docker() {
    cd ~
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker vm1user
    sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

function install_az() {
    cd ~
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

sudo apt-get -y update
install_packages
setup_nodejs
setup_dotfiles
install_chrome
install_leiningen
install_neovim
install_docker
install_az

# TODO
echo "More stuff to do:
---
after running xfce, ~/source/scripts/spit-xfce-config.sh
---
logout and back in, so docker works
---
copy over ssh key
---
clone private repo
---
"
