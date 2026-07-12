# CLAUDE.md

This file provides guidance to coding agents working in this repository.

## Repository structure

This is a multi-platform dotfiles repository deployed with GNU Stow. Canonical
configuration lives directly in flat packages under `modules/`; do not create
secondary copies elsewhere.

- `modules/component-*` — independently selectable functional capabilities
- `modules/platform-*` — operating-system or session-environment overlays
- `modules/host-*` — irreducibly machine-specific overrides
- `profiles/` — explicit package lists consumed by `scripts/stow-profile`
- `bootstrap/` — inputs that are consumed rather than linked into `$HOME`
- `docs/modules.md` — package composition and migration details

Use visible `dot-` names for paths that become dotfiles. The deployment script
always passes Stow's `--dotfiles` and `--no-folding` options.

The `refactor/stow-machine-profiles` branch contains `macbook-pro` and `terra`
profiles. Existing machine branches must remain unchanged until their profiles
have been migrated and verified.

## Deployment safety

Never run `scripts/stow-profile` against the user's real home directory without
explicit approval. Test profiles with a temporary `HOME` first. For an approved
real-home trial, use `scripts/migrate-profile-layout` so existing links and files
have explicit rollback state. Do not use Stow's `--adopt` option.

Preview either a clean deployment or a protected migration with:

```bash
./scripts/stow-profile --dry-run terra
./scripts/migrate-profile-layout --dry-run migrate terra
```

`stow-profile` records applied modules under
`~/.local/state/dotfiles-profiles/` and reconciles modules removed from a
profile. Run legacy migration from a separate permanent checkout while the old
checkout remains in place; never switch the old checkout before migration.

## Applying configuration changes

Most configuration takes effect immediately or with a lightweight reload:

| Configuration | Apply |
| --- | --- |
| Neovim plugins | Run `:Lazy sync` |
| tmux | Run `tmux source ~/.tmux.conf` or restart tmux |
| shell | Run `source ~/.zshrc` |
| Waybar | Run `systemctl --user restart waybar` |
| kanshi | Run `systemctl --user restart kanshi` |
| Sway | Run `swaymsg reload` |

## Vim fallback

`modules/component-vim/dot-vimrc` is a portable Vim 8 server fallback. Keep it
plugin-free and independent of external executables; Neovim is the primary
editor.

## Neovim architecture

The entry point is `modules/component-nvim/dot-config/nvim/init.lua`. It loads
`lua/config/`, enables the shared LSP servers, then loads plugins from
`lua/plugins/` via lazy.nvim.

Plugins are split into single-concern files under `lua/plugins/`. Per-filetype
overrides live in `after/ftplugin/`. Commit `lazy-lock.json` changes so plugin
versions remain reproducible across profiles.

Leader is `<Space>`. Navigation is Vim-style throughout.

## Nord theme

Nord colors are used consistently across tmux and the shell prompt. Keep new UI
configuration consistent with Nord unless a platform or host overlay explicitly
selects another variant.

## Module design

A component name describes stable functionality, not which current profiles
happen to select it. Do not use `common-*`: sharedness is an accidental property
that can change as profiles are added. Keep components independently selectable
so profiles retain fine-grained composition.

Put broadly reusable behavior in `component-*`, OS/session requirements in
`platform-*`, and only hardware-, location-, or source-host-specific values in
`host-*`. Prefer an application's native include mechanism over duplicate
complete configurations. The primary component config should load optional
platform and host fragments when the application supports it.
