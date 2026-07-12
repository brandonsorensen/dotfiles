# CLAUDE.md

This file provides guidance to coding agents working in this repository.

## Repository structure

This is a multi-platform dotfiles repository deployed with GNU Stow. Canonical
configuration lives directly in flat packages under `modules/`; do not create
secondary copies elsewhere.

- `modules/common-*` — configuration shared by profiles
- `modules/platform-*` — operating-system configuration
- `modules/host-*` — individual machine overrides
- `modules/<application>-<variant>` — mutually exclusive complete variants
- `profiles/` — explicit package lists consumed by `scripts/stow-profile`
- `bootstrap/` — inputs that are consumed rather than linked into `$HOME`
- `docs/modules.md` — package composition and migration details

Use visible `dot-` names for paths that become dotfiles. The deployment script
always passes Stow's `--dotfiles` and `--no-folding` options.

The `refactor/stow-machine-profiles` branch is a proof of concept. Existing
machine branches must remain unchanged until their profiles have been migrated
and verified.

## Deployment safety

Never run `scripts/stow-profile` against the user's real home directory without
explicit approval. Test profiles with a temporary `HOME` first. For an approved
real-home trial, use `scripts/migrate-profile-layout` so existing links and files
have explicit rollback state. Do not use Stow's `--adopt` option.

Preview either a clean deployment or a protected migration with:

```bash
./scripts/stow-profile --dry-run macbook-pro
./scripts/migrate-profile-layout --dry-run migrate macbook-pro
```

## Applying configuration changes

Most configuration takes effect immediately or with a lightweight reload:

| Configuration | Apply |
| --- | --- |
| Neovim plugins | Run `:Lazy sync` |
| tmux | Run `tmux source ~/.tmux.conf` or restart tmux |
| shell | Run `source ~/.zshrc` |

## Neovim architecture

The entry point is `modules/common-nvim/dot-config/nvim/init.lua`. It loads
`lua/config/`, then plugins from `lua/plugins/` via lazy.nvim. Optional machine
data comes from `~/.config/dotfiles/nvim.lua`.

Plugins are split into single-concern files under `lua/plugins/`. Per-filetype
overrides live in `after/ftplugin/`. LSP servers are enabled in `init.lua` unless
machine data sets `enable_lsps = false`.

Leader is `<Space>`. Navigation is Vim-style throughout.

## Nord theme

Nord colors are used consistently across tmux and the shell prompt. Keep new UI
configuration consistent with Nord unless a profile explicitly selects another
variant.
