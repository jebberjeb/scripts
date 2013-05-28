# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias dir="ls -aFl"
alias vim="TERM=xterm-256color vim"
alias lein="/usr/local/bin/lein"
