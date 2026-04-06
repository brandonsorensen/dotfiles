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

hn() {
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
    hackernews_tui -c ~/.config/hn-tui-dark.toml "$@"
  else
    hackernews_tui -c ~/.config/hn-tui-light.toml "$@"
  fi
}
