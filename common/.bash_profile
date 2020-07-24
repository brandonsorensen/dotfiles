# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

alias ls="ls -G"

export PS1="\[\033[38;5;9m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;11m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;10m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\] "

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Brandon/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/Brandon/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Brandon/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/Brandon/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export XLEPATH=$/Users/Brandon/Library/Mobile Documents/com~apple~CloudDocs/School/GrammarForm/xle-intelmac-kn-2014-04-23
export PATH=${XLEPATH}/bin:$PATH
export LD_LIBRARY_PATH=${XLEPATH}/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=${XLEPATH}/lib:$DYLD_LIBRARY_PATH

# added by Miniconda3 installer
export PATH="/Users/Brandon/miniconda3/bin:$PATH"
