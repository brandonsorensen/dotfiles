# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

case "$OSTYPE" in 
	darwin*)
		is_mac=true
		if [ "$ITERM_PROFILE" = "Xcode" ]; then
			ZSH_THEME="sorin"
		else
			ZSH_THEME="norm"
		fi
		;;
	linux*)
		is_linux=true
		ZSH_THEME="agnoster"
		;;
esac

ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
PY_VERSION='python3.8'
if [ "$is_mac" = true ]; then
	export PATH=$(brew --prefix openvpn)/sbin:$PATH
	PY_PACKAGE_DIR="/usr/local/lib/$PY_VERSION/site-packages"
	plugins=(git brew tmux pip osx)
else
	PY_PACKAGE_DIR="$HOME/.local/lib/$PY_VERSION/site-packages"
	plugins=(git tmux pip)
fi

export PATH=$PATH:$HOME/.bin
export POWERLINE_BASE="$PY_PACKAGE_DIR/powerline/"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
if { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
  export TERM=screen-256color
fi

function dusort() {
	du -sh $1/* | sort -rh
}

# Shows a .csv file in tab-separated tabular form
function tabler() {
	column -s, -t < $1 | less -#2 -N -S
}

local_zsh_path="$HOME/.zsh_local"
if [ -f $local_zsh_path ]; then
	# .zsh_local is for environment variables specific to a given
	# device and will not be tracked in the dotfiles repo.
	source $local_zsh_path
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh

export LANG=en_US.UTF-8
export PATH=$HOME/dotfiles/scripts:$PATH
export PATH="/usr/local/sbin:$PATH"
export jport=127.0.0.1:8888:127.0.0.1:8888


bindkey -v  # vim bindings
bindkey "^?" backward-delete-char
bindkey "^a" history-beginning-search-backward
bindkey '^r' history-incremental-search-backward

export GIT_EDITOR=vim
export EDITOR=vim


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

