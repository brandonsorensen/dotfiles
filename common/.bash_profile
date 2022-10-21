# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PS1="\[\033[38;5;9m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;11m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;10m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\] "

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
