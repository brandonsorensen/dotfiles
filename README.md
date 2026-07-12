# dotfiles

Multi-platform configuration managed as composable GNU Stow modules.
Independently selectable components plus platform and host overlays coexist on
one branch; profiles select the modules deployed to each machine.

This branch contains complete profiles for `macbook-pro` and the Linux/Wayland
workstation `terra`. Existing machine branches remain unchanged while the
layout is evaluated.

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

See [`docs/modules.md`](docs/modules.md) for the component/platform/host model,
overlay composition, and migration details.

## Preview and apply

GNU Stow 2.4 or newer is recommended:

```bash
./scripts/stow-profile --dry-run terra
./scripts/stow-profile terra
```

Replace `terra` with `macbook-pro` on the Mac. The script records the applied
module list under `~/.local/state/dotfiles-profiles/`. On the next run it
unstows modules removed from the profile before restowing the selected set.

Remove links owned by the profile with:

```bash
./scripts/stow-profile --delete terra
```

The profile is applied in one Stow invocation so conflicts abort the complete
operation. Preview before replacing links from an older layout; do not use
`--adopt` during migration.

## Test with rollback protection

Use the migration helper when testing the modules against the real home
directory:

Run migration from the new branch in a permanent checkout while the legacy
checkout still exists. Do not switch the legacy checkout first: doing so makes
its home-directory links broken before they can be recorded.

```bash
DOTFILES_LEGACY_ROOT="$HOME/dotfiles" ./scripts/migrate-profile-layout --verbose --dry-run migrate terra
DOTFILES_LEGACY_ROOT="$HOME/dotfiles" ./scripts/migrate-profile-layout migrate terra
```

It records legacy links, backs up conflicting regular files, and then applies
the profile. Rollback state is stored outside the repository under
`~/.local/state/dotfiles-layout/`.

```bash
./scripts/migrate-profile-layout status terra
./scripts/migrate-profile-layout --dry-run rollback terra
./scripts/migrate-profile-layout rollback terra
```

Rollback removes only links into this repository and restores the exact old
link targets and file contents. The helper refuses unexpected links,
directories, broken links, or deployed paths replaced during the test. Once the
new layout is accepted, explicitly discard the old backups with:

```bash
./scripts/migrate-profile-layout --dry-run finalize terra
./scripts/migrate-profile-layout finalize terra
```

## terra profile

`profiles/terra` combines reusable components with the Linux/Wayland platform
overlay and Terra's display, graphics, location, and Sway host overrides. Root-owned configuration and package lists remain bootstrap
assets:

```bash
sudo ln -sf "$PWD/bootstrap/linux/greetd/config.toml" /etc/greetd/config.toml
sudo pacman -S --needed - < bootstrap/linux/terra/packages.txt
```

On the existing Terra installation, `~/.tmux` is a legacy directory symlink and
its ignored `plugins/` directory is runtime state. After migration, copy that
state into the new real directory before testing tmux:

```bash
mkdir -p ~/.tmux/plugins
cp -a "$HOME/dotfiles/common/.tmux/plugins/." ~/.tmux/plugins/
```

Remove `~/.tmux/plugins` before using the rollback helper; otherwise its
local-state check will intentionally stop rollback.

Initialize the current color mode, reload user units, and preserve their
existing enablement:

```bash
"$HOME/.local/share/$(darkman get)-mode.d/colors.sh"
systemctl --user daemon-reload
systemctl --user restart waybar kanshi
```

The darkman hooks select Sway colors and restart Waybar with the matching
stylesheet. `gtklock-launch` is deployed to `~/.local/bin` so Sway does not
depend on the checkout location.

## macbook-pro profile

`profiles/macbook-pro` composes shared modules with:

- macOS application configuration;
- macbook-specific SSH host settings;
- the macbook tmux variant;
- shared shell, Git, SSH, Vim, Neovim, terminal, tmux data, and pi settings.

The effective result was checked against the existing `macbook-pro` branch,
then normalized where branch drift was not a genuine machine requirement.
Neovim is the primary development editor; Vim is intentionally reduced to a
portable, plugin-free server fallback.

## Bootstrap assets

Files that are not linked into `$HOME` live under `bootstrap/`. For example:

```bash
brew bundle --file bootstrap/macos/Brewfile
sudo pacman -S --needed - < bootstrap/linux/terra/packages.txt
```

## Applying configuration changes

Most configuration takes effect immediately or with a lightweight reload:

| Configuration | Apply |
| --- | --- |
| Neovim plugins | Run `:Lazy sync` |
| tmux | Run `tmux source ~/.tmux.conf` or restart tmux |
| shell | Run `source ~/.zshrc` |
