#! /bin/bash

ln -f -s $EFS_SOURCE_PATH/dotfiles/.bashrc $INSTALL_HOME/.bashrc
ln -f -s $EFS_SOURCE_PATH/dotfiles/.bashrc-git $INSTALL_HOME/.bashrc-git
ln -f -s $EFS_SOURCE_PATH/dotfiles/.bashrc-path $INSTALL_HOME/.bashrc-path
ln -f -s $EFS_SOURCE_PATH/dotfiles/.bash_profile $INSTALL_HOME/.bash_profile
ln -f -s $EFS_SOURCE_PATH/dotfiles/.ctags $INSTALL_HOME/.ctags
ln -f -s $EFS_SOURCE_PATH/dotfiles/.inputrc $INSTALL_HOME/.inputrc
ln -f -s $EFS_SOURCE_PATH/dotfiles/.vimrc $INSTALL_HOME/.vimrc
ln -f -s $EFS_SOURCE_PATH/dotfiles/.vim $INSTALL_HOME/.vim
ln -f -s $EFS_SOURCE_PATH/dotfiles/.git-prompt.sh $INSTALL_HOME/.git-prompt.sh
ln -f -s $EFS_SOURCE_PATH/dotfiles/.tmux.conf $INSTALL_HOME/.tmux.conf
ln -f -s $EFS_SOURCE_PATH/dotfiles/.gitignore $INSTALL_HOME/.gitignore
ln -f -s $EFS_SOURCE_PATH/dotfiles/.gitconfig $INSTALL_HOME/.gitconfig
ln -f -s $EFS_SOURCE_PATH/dotfiles/.bitchxrc $INSTALL_HOME/.bitchxrc
ln -f -s $EFS_SOURCE_PATH/dotfiles/.xserverrc $INSTALL_HOME/.xserverrc
mkdir -p $INSTALL_HOME/.config
ln -f -s $EFS_SOURCE_PATH/dotfiles/.vnc $INSTALL_HOME/.vnc
ln -f -s $INSTALL_HOME/.vim $INSTALL_HOME/.config/nvim
ln -f -s $INSTALL_HOME/.vimrc $INSTALL_HOME/.config/nvim/init.vim
