ubuntu=$(uname --all | grep -c Ubunut)
cd ~
git clone https://github.com/b4winckler/vim.git ~/vim
cd ~/vim
git checkout tags/v7-4-200
if [[ 1 = $ubuntu ]]; then
    sudo apt-get -y install ncurses-devel
    sudo apt-get -y install python-devel
    sudo apt-get -y install ruby-devel
else
    sudo yum -y install ncurses-devel
    sudo yum -y install python-devel
    sudo yum -y install ruby-devel
fi
make distclean
./configure --enable-rubyinterp --enable-pythoninterp --enable-multibyte --with-features=big --prefix=/usr
make
sudo make install

