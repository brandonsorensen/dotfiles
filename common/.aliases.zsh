alias la='ls -a'
alias clock='date +%H:%M:%S'

alias dtypes="column -xt $HOME/.dtypes.tsv"

alias cb='cargo build'
alias cr='cargo run'

alias tcc='tmux -CC'

alias pbcopy='wl-copy'
alias pbpaste='wl-paste'

alias cpwd='pwd|wl-copy'

alias gs='git switch'
alias co='git checkout'
alias lg='lazygit'
alias lc='lazydocker'

alias rg="rg --hidden --glob '!.git'"

alias j='just'
alias jb='just build'
alias jr='just run'

alias le='eza'

alias darkmode="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to true'"
alias lightmode="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to false'"

unalias hn 2>/dev/null
hn() {
    local theme_config="$HOME/.config/hn-tui-$(darkman get).toml"
    if [[ -f "$theme_config" ]]; then
        hackernews_tui --config "$theme_config" "$@"
    else
        hackernews_tui "$@"
    fi
}

# Prevent suspend for a given number of seconds (default: 1 hour)
# Usage: caffeinate [seconds]
caffeinate() {
    systemd-inhibit --what=sleep --who="caffeinate" --why="manual hold" sleep "${1:-3600}"
}
