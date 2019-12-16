#! /bin/bash

ln -f -s $SOURCE_PATH/dotfiles/.bashrc ~/.bashrc
ln -f -s $SOURCE_PATH/dotfiles/.bashrc-git ~/.bashrc-git
ln -f -s $SOURCE_PATH/dotfiles/.bashrc-path ~/.bashrc-path
ln -f -s $SOURCE_PATH/dotfiles/.bash_profile ~/.bash_profile
ln -f -s $SOURCE_PATH/dotfiles/.ctags ~/.ctags
ln -f -s $SOURCE_PATH/dotfiles/.inputrc ~/.inputrc
ln -f -s $SOURCE_PATH/dotfiles/.vimrc ~/.vimrc
ln -f -s $SOURCE_PATH/dotfiles/.vim ~/.vim
ln -f -s $SOURCE_PATH/dotfiles/.git-prompt.sh ~/.git-prompt.sh
ln -f -s $SOURCE_PATH/dotfiles/.tmux.conf ~/.tmux.conf
ln -f -s $SOURCE_PATH/dotfiles/.gitignore ~/.gitignore
ln -f -s $SOURCE_PATH/dotfiles/.gitconfig ~/.gitconfig
ln -f -s $SOURCE_PATH/dotfiles/.bitchxrc ~/.bitchxrc
ln -f -s $SOURCE_PATH/dotfiles/.xserverrc ~/.xserverrc
mkdir ~/.config
ln -f -s ~/.vim ~/.config/nvim
ln -f -s ~/.vimrc ~/.config/nvim/init.vim
