# dotfiles

Multi-platform configuration managed as composable GNU Stow modules. Shared,
platform-specific, and host-specific settings coexist on one branch; profiles
select the modules deployed to each machine.

This branch is a complete proof of concept for `macbook-pro`. The existing
machine branches remain unchanged while the layout is evaluated.

## Structure

```text
modules/      # canonical Stow packages that mirror paths beneath $HOME
profiles/     # explicit module lists for each machine
bootstrap/    # package-manager inputs and machine bootstrap assets
scripts/      # deployment and utility scripts
docs/         # architecture and migration documentation
```

Deployable configuration has one canonical location under `modules/`. GNU
Stow's `--dotfiles` mode maps visible names such as `dot-zshrc` and `dot-config`
to `.zshrc` and `.config` in the target.

See [`docs/modules.md`](docs/modules.md) for package composition, host overrides,
and migration details.

## Preview and apply

GNU Stow 2.4 or newer is recommended:

```bash
./scripts/stow-profile --dry-run macbook-pro
./scripts/stow-profile macbook-pro
```

Remove links owned by the profile with:

```bash
./scripts/stow-profile --delete macbook-pro
```

The profile is applied in one Stow invocation so conflicts abort the complete
operation. Preview before replacing links from an older layout; do not use
`--adopt` during migration.

## Test with rollback protection

Use the migration helper when testing the modules against the real home
directory:

```bash
./scripts/migrate-profile-layout --verbose --dry-run migrate macbook-pro
./scripts/migrate-profile-layout migrate macbook-pro
```

It records legacy links, backs up conflicting regular files, and then applies
the profile. Rollback state is stored outside the repository under
`~/.local/state/dotfiles-layout/`.

```bash
./scripts/migrate-profile-layout status macbook-pro
./scripts/migrate-profile-layout --dry-run rollback macbook-pro
./scripts/migrate-profile-layout rollback macbook-pro
```

Rollback removes only links into this repository and restores the exact old
link targets and file contents. The helper refuses unexpected links,
directories, broken links, or deployed paths replaced during the test. Once the
new layout is accepted, explicitly discard the old backups with:

```bash
./scripts/migrate-profile-layout --dry-run finalize macbook-pro
./scripts/migrate-profile-layout finalize macbook-pro
```

## macbook-pro profile

`profiles/macbook-pro` composes shared modules with:

- macOS application configuration;
- macbook-specific SSH host settings;
- the macbook tmux variant;
- Neovim machine data;
- shared shell, Git, SSH, Vim, Neovim, terminal, tmux data, and pi settings.

The effective result has been checked against the existing `macbook-pro` branch.
The only omitted tree differences are a repository-only `.gitignore` under pi's
source directory and removal of a blank line in a Neovim options file.

## Bootstrap assets

Files that are not linked into `$HOME` live under `bootstrap/`. For example:

```bash
brew bundle --file bootstrap/macos/Brewfile
```

## Applying configuration changes

Most configuration takes effect immediately or with a lightweight reload:

| Configuration | Apply |
| --- | --- |
| Neovim plugins | Run `:Lazy sync` |
| tmux | Run `tmux source ~/.tmux.conf` or restart tmux |
| shell | Run `source ~/.zshrc` |
