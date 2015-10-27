sudo pacman -S ruby
sudo pacman -S python2
sudo pacman -S python2-pip
sudo pacman -S cmake
sudo pacman -S pkg-config
sudo pacman -S automake
sudo pacman -S libtool
sudo pacman -S lua
sudo pacman -S luarocks

cd ~/source/neovim
sudo make distclean
sudo make install
sudo pip2 install neovim
