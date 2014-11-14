ubuntu=$(uname --all | grep -c Ubuntu)
if [[ 1 = $ubuntu ]]; then
    sudo apt-get -y install ack
else
    sudo yum -y install ack
fi
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/vimproc.vim
make
sudo mv /usr/share/vim/vim74/ftplugin/lisp.vim ~/lisp.vim.backup
