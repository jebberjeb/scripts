# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

PATH=$PATH:$HOME/bin

# stuff created by ruby-build install.sh
export PATH=/home/vagrant/.rbenv/bin:/opt/rbenv/shims:/opt/rbenv/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
eval "$(rbenv init -)"

export TERM=xterm-256color

# .git-prompt
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
