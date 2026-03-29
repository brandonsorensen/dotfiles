# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository structure

This is a multi-platform dotfiles repository. Configs live in `common/` (shared) and `mac/` (macOS-specific). Deployment is via manual symlinks — no GNU Stow.

- `common/` — nvim, tmux, shell, git, and Linux/Wayland configs (sway, waybar, kanshi, gtklock, systemd)
- `mac/` — Brewfile, iTerm2 profiles
- `scripts/` — utility scripts (gtklock wrapper, NVIDIA sway setup)

**Branches:** `master` is the common base. Machine-specific branches (e.g. `terra`) extend it for a particular OS and hardware. See `README.md` for the branch strategy and sync workflow.

## Applying config changes

Most configs take effect immediately or with a lightweight reload — no build step:

| Config | How to apply |
|--------|-------------|
| sway | `$mod+Shift+r` or `swaymsg reload` |
| waybar | `systemctl --user restart waybar` |
| kanshi | `systemctl --user restart kanshi` |
| nvim plugins | `:Lazy sync` inside nvim |
| tmux | `prefix + I` to install plugins, or `tmux source ~/.tmux.conf` |
| shell | `source ~/.zshrc` |

## Neovim architecture

Config entry point: `common/nvim/init.lua` → loads `lua/config/` (keymaps, options, autocmds) and `lua/plugins/` via lazy.nvim.

Plugins are split into single-concern files under `lua/plugins/`. Per-filetype overrides live in `after/ftplugin/`. LSP servers are configured in `lua/plugins/lsp/init.lua`: rust_analyzer, lua_ls, bashls, basedpyright, ruff, terraformls.

Leader key is `<Space>`. Navigation is vim-style throughout.

## Sway/Wayland setup (terra branch)

- **Mod key:** Alt (Mod1)
- **Terminal:** ghostty  |  **Launcher:** wofi  |  **Notifications:** mako
- **Lock screen:** gtklock via `scripts/gtklock-launch.sh` (wrapper required — GTK CSS `url()` doesn't expand `$HOME`)
- **Waybar/kanshi** are systemd user services (`sway-session.target`), not exec'd from sway config
- **Display scaling:** kanshi profile `home` drives the 5K display at 2× HiDPI; `exec_always` in sway config auto-restarts kanshi on every reload to reapply scaling. Profile `gaming` sets scale 1 for native-res gaming — switch with `kanshictl switch gaming` / `kanshictl switch home`
- **Media keys:** Keychron K8 requires `hid_apple` module with `fnmode=1` — see README for persistence instructions
- **Audio:** PipeWire + WirePlumber; use `wpctl` for CLI control, `pavucontrol` for GUI

## Wallpaper convention

`~/Pictures/wallpapers/current` is a symlink to the active wallpaper. Both sway (`output * bg`) and gtklock reference this path.

## Nord theme

Nord color palette is used consistently across sway window borders, waybar, tmux (nord-tmux plugin), and shell prompt (Powerlevel10k). Keep new UI additions consistent with Nord.
