sudo pacman -S --noconfirm ruby
sudo pacman -S --noconfirm python2
sudo pacman -S --noconfirm python2-pip
sudo pacman -S --noconfirm cmake
sudo pacman -S --noconfirm pkg-config
sudo pacman -S --noconfirm automake
sudo pacman -S --noconfirm libtool
sudo pacman -S --noconfirm lua
sudo pacman -S --noconfirm luarocks
sudo pacman -S --noconfirm ack

cd ~/source
git clone https://github.com/neovim/neovim.git
cd ~/source/neovim
sudo make distclean
sudo make install
sudo pip2 install neovim
mkdir -p ~/.local/share/nvim
