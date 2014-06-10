sudo yum install @xfce
sudo systemctl set-default multi-user.target
sudo yum install git
sudo yum install tmux
sudo yum groupinstall "Development Tools"
mkdir ~/source
cd ~/source
git clone https://github.com/jebberjeb/scripts
git clone https://github.com/jebberjeb/dotfiles
cd ~
rm .bashrc
rm .bash_profile
ln -s ~/source/dotfiles/.bashrc .bashrc
ln -s ~/source/dotfiles/.bash_profile .bash_profile
ln -s ~/source/dotfiles/.vimrc .vimrc
ln -s ~/source/dotfiles/.vim .vim
ln -s ~/source/dotfiles/.git-prompt.sh .git-prompt.sh
ln -s ~/source/dotfiles/.lein .lein
ln -s ~/source/dotfiles/.tmux.conf .tmux.conf
~/source/scripts/install_jebs_vim.sh
~/source/scripts/vim-setup.sh

