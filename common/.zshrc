# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export BAT_CONFIG_PATH="$HOME/.bat.conf"
export LANG=en_US.UTF-8


case "$OSTYPE" in
	darwin*)
		is_mac=true
		;;
	linux*)
		is_linux=true
		;;
esac

if [ "$is_mac" = true ]; then
	export PATH="/opt/homebrew/bin/:$PATH"
	eval "$(brew shellenv)"
	fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
	plugins=(git brew tmux pip macos)
else
	plugins=(git tmux pip)
fi

export PATH="$HOME/.local/bin:/usr/local/sbin:$PATH"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

local_zsh_path="$HOME/.zsh_local"
if [ -f $local_zsh_path ]; then
	# .zsh_local is for environment variables specific to a given
	# device and will not be tracked in the dotfiles repo.
	source $local_zsh_path
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh


bindkey -v  # vim bindings
bindkey "^?" backward-delete-char
bindkey "^a" history-beginning-search-backward
bindkey '^r' history-incremental-search-backward
# Insert newline symbol with Alt-Return
bindkey '^[^M' self-insert-unmeta  

export GIT_EDITOR=nvim
export EDITOR=nvim

export FZF_DEFAULT_COMMAND='fd --type f --exclude .git --ignore-file ~/.git/info/exclude'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$PYENV_ROOT/shims:${PATH}"
eval "$(pyenv init -)"

alias vfzf="fzf --bind 'enter:become(nvim {})'"
run_fzf_widget() {
	vfzf .
}
zle -N run_fzf_widget
bindkey '^F' run_fzf_widget
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
