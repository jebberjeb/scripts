git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sudo yum -y install ack
vim +PluginInstall +qall
cd ~/.vim/bundle/vimproc.vim
make
sudo mv /usr/share/vim/vim74/ftplugin/lisp.vim ~/lisp.vim.backup
