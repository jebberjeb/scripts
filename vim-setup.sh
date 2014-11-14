#! /bin/bash

. env.sh
set_os

sudo $installer install ack

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/vimproc.vim
make
sudo mv /usr/share/vim/vim74/ftplugin/lisp.vim ~/lisp.vim.backup
