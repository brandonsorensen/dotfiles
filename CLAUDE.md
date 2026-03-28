# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository structure

This is a multi-platform dotfiles repository. Configs live in `common/` (shared) and `mac/` (macOS-specific). Deployment is via manual symlinks — no GNU Stow.

- `common/` — nvim, tmux, shell, git, and Linux/Wayland configs (sway, waybar, kanshi, gtklock, systemd)
- `mac/` — Brewfile, iTerm2 profiles
- `scripts/` — utility scripts

**Branches:** `master` is the common base. Machine-specific branches (e.g. `terra`) extend it for a particular OS and hardware. See `README.md` for the branch strategy and sync workflow.

## Applying config changes

Most configs take effect immediately or with a lightweight reload — no build step:

| Config | How to apply |
|--------|-------------|
| nvim plugins | `:Lazy sync` inside nvim |
| tmux | `prefix + I` to install plugins, or `tmux source ~/.tmux.conf` |
| shell | `source ~/.zshrc` |

## Neovim architecture

Config entry point: `common/nvim/init.lua` → loads `lua/config/` (keymaps, options, autocmds) and `lua/plugins/` via lazy.nvim.

Plugins are split into single-concern files under `lua/plugins/`. Per-filetype overrides live in `after/ftplugin/`. LSP servers are configured in `lua/plugins/lsp/init.lua`: rust_analyzer, lua_ls, bashls, basedpyright, ruff, terraformls.

Leader key is `<Space>`. Navigation is vim-style throughout.

## Nord theme

Nord color palette is used consistently across tmux (nord-tmux plugin) and shell prompt (Powerlevel10k). Machine branches extend this to their UI (e.g. sway borders, waybar on Linux). Keep new UI additions consistent with Nord.
