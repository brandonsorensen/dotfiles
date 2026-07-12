alias la='ls -a'
alias clock='date +%H:%M:%S'

alias dtypes="column -xt $HOME/.dtypes.tsv"

alias cb='cargo build'
alias cr='cargo run'

alias tcc='tmux -CC'

alias cpwd='pwd|pbcopy'

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
