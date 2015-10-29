#! /bin/bash

function setup() {
    echo "Testing sudo access"
    sudo touch /foo
    if [[ $? -ne 0 ]]; then
        echo "Making user a sudoer, enter su password"
        su -c "usermod jeb -a -G wheel"
        echo "Log out, back in, then rerun script"
        exit -1
    fi

    echo "Disabling SE Linux"
    echo "SELINUX=disabled
    SELINUXTYPE=targeted" | sudo tee /etc/selinux/config

    echo "Prime installer"
    sudo apt-get -y update

    echo "Set timezone"
    sudo unlink /etc/localtime
    sudo ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

    echo "Configure audio"
    sudo usermod -a -G audio jeb
}

function install_packages() {
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
    sudo apt-get -y install espeak
    sudo apt-get -y install libreoffice
    sudo apt-get -y install htop
    sudo apt-get -y install rlwrap
}

function setup_dotfiles() {
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
}

function install_chrome() {
    echo "Install Chrome"
    sudo bash -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
    sudo bash -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get -y update
    sudo apt-get -y install google-chrome-stable
}

function install_maven() {
    echo "Install Maven"
    wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
    tar xvf apache-maven-3.0.5-bin.tar.gz
    sudo cp -rf apache-maven-3.0.5 /usr/local/
    rm -rf apache-maven-3.0.5
    rm apache-maven-3.0.5-bin.tar.gz
}

function install_leiningen() {
    echo "Install Leiningen"
    curl --insecure https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein | sudo tee /usr/local/bin/lein
    sudo chmod a+x /usr/local/bin/lein
}

function install_hipchat() {
    echo "Install HipChat"
    sudo bash -c 'echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list'
    sudo bash -c 'wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -'
    sudo apt-get -y update
    sudo apt-get -y install hipchat
}

function install_bitchx() {
    echo "Install BitchX"
    cd ~
    svn checkout svn://svn.code.sf.net/p/bitchx/code/trunk bitchx-code
    cd bitchx-code
    ./configure --prefix=/usr
    make
    sudo make install
}

function install_dragondisk() {
    echo "Install DragonDisk"
    cd ~
    wget http://download.dragondisk.com/dragondisk_1.0.5-0ubuntu_amd64.deb
    sudo apt-get -y install libqt4-dbus libqt4-network libqt4-xml libqtcore4 libqtgui4
    sudo dpkg -i dragondisk_1.0.5-0ubuntu_amd64.deb
}

function install_racket() {
    echo "Install Racket"
    cd ~
    wget http://mirror.racket-lang.org/installers/5.3.6/racket/racket-5.3.6-src-unix.tgz
    tar xvf racket-5.3.6-src-unix.tgz
    cd racket-5.3.6/src
    ./configure --prefix=/usr
    make
    sudo make install
}

function install_vim() {
    echo "Install Vim"
    cd ~
    git clone https://github.com/b4winckler/vim.git ~/vim
    cd ~/vim
    #git checkout tags/v7-4-200
    make distclean
    ./configure --enable-rubyinterp --enable-pythoninterp --enable-multibyte --with-features=big --prefix=/usr --enable-mzschemeinterp
    make
    sudo make install
    ~/source/scripts/vim-setup.sh
}

function install_neovim() {
    sudo apt-get install -y cmake
    sudo apt-get install -y build-essential
    sudo apt-get install -y libtool
    sudo apt-get install -y pkg-config
    sudo apt-get install -y automake
    cd ~
    git clone https://github.com/neovim/neovim.git
    cd neovim
    sudo make install
}

if [[ ${1} == "all" ]]; then
    setup
    install_packages
    setup_dotfiles
    install_chrome
    install_maven
    install_leiningen
    install_hipchat
    install_bitchx
    install_dragondisk
    #TODO - make this opt-in, rather than default (expensive)
    #install_racket
    install_vim
    install_neovim
fi

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
