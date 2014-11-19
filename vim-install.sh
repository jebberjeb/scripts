. env.sh
set_os

cd ~
git clone https://github.com/b4winckler/vim.git ~/vim
cd ~/vim
git checkout tags/v7-4-200
if [[ "$os" == "ubuntu" ]]; then
    sudo $installer install ncurses-dev
    sudo $installer install python-dev
    sudo $installer install ruby-dev
elif [[ "$os" == "fedora" ]]; then
    sudo $installer install ncurses-devel
    sudo $installer install python-devel
    sudo $installer install ruby-devel
fi
make distclean
./configure --enable-rubyinterp --enable-pythoninterp --enable-multibyte --with-features=big --prefix=/usr
make
sudo make install

