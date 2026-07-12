alias la='ls -a'
alias clock='date +%H:%M:%S'

alias dtypes="column -xt $HOME/.dtypes.tsv"
alias bztar='tar -jcvf'
alias bzuntar='tar -xjf'

alias prun='poetry run python3'

alias cb='cargo build'
alias cr='cargo run'

alias tcc='tmux -CC'

if command -v wl-copy >/dev/null 2>&1; then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
fi

cpwd() {
    if command -v pbcopy >/dev/null 2>&1; then
        pwd | pbcopy
    elif command -v wl-copy >/dev/null 2>&1; then
        pwd | wl-copy
    else
        printf 'No clipboard command is available.\n' >&2
        return 1
    fi
}

alias gs='git switch'
alias co='git checkout'
alias lg='lazygit'
alias lc='lazydocker'

alias rg="rg --hidden --glob '!.git'"

alias j='just'
alias jb='just build'
alias jr='just run'

alias le='eza'

darkmode() {
    if command -v darkman >/dev/null 2>&1; then
        command darkman set dark
    else
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    fi
}

lightmode() {
    if command -v darkman >/dev/null 2>&1; then
        command darkman set light
    else
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
    fi
}

unalias hn 2>/dev/null
hn() {
    local theme_config=""

    if command -v darkman >/dev/null 2>&1; then
        theme_config="$HOME/.config/hn-tui-$(darkman get).toml"
    elif command -v defaults >/dev/null 2>&1; then
        if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
            theme_config="$HOME/.config/hn-tui-dark.toml"
        else
            theme_config="$HOME/.config/hn-tui-light.toml"
        fi
    fi

    if [[ -z "$theme_config" || ! -f "$theme_config" ]]; then
        theme_config="$HOME/.config/hn-tui-dark.toml"
    fi

    if [[ -f "$theme_config" ]]; then
        hackernews_tui --config "$theme_config" "$@"
    else
        hackernews_tui "$@"
    fi
}

# Prevent suspend for a given number of seconds (default: one hour).
if command -v systemd-inhibit >/dev/null 2>&1; then
    caffeinate() {
        systemd-inhibit --what=sleep --who="caffeinate" --why="manual hold" sleep "${1:-3600}"
    }
fi
