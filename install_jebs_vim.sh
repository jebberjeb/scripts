cd ~
hg clone https://vim.googlecode.com/hg/ vim
sudo yum -y install python-devel
sudo yum -y install ruby-devel
cd vim
make distclean
./configure --enable-rubyinterp --enable-pythoninterp --enable-multibyte --with-features=big
make
sudo make install
cd ~
cp scripts/.vimrc .
cp -rf scripts/.vim .
cd .vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make clean
make
sudo make install
