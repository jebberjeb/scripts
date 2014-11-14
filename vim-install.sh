. env.sh
set_os

cd ~
git clone https://github.com/b4winckler/vim.git ~/vim
cd ~/vim
git checkout tags/v7-4-200
sudo $installer install ncurses-devel
sudo $installer install python-devel
sudo $installer install ruby-devel
make distclean
./configure --enable-rubyinterp --enable-pythoninterp --enable-multibyte --with-features=big --prefix=/usr
make
sudo make install

