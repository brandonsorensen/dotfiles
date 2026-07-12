# Modules and profiles

The repository stores deployable configuration directly in GNU Stow modules.
Each immediate child of `modules/` is a Stow package and mirrors paths beneath
`$HOME`.

Stow's `--dotfiles` mode translates every `dot-` prefix in a package path:

```text
modules/component-shell/dot-zshrc                 -> ~/.zshrc
modules/component-nvim/dot-config/nvim/init.lua   -> ~/.config/nvim/init.lua
modules/component-ssh/dot-ssh/config              -> ~/.ssh/config
```

There are no manifest symlinks or secondary canonical copies. Editing a file in
`modules/` edits the source that Stow deploys.

## Module roles

Modules describe one of three independent axes:

- `component-*` provides an independently selectable functional capability;
- `platform-*` overlays requirements of an operating system or session type;
- `host-*` overlays values that are irreducibly specific to one machine.

A component name describes stable functionality, not which profiles currently
select it. The name `common-*` is deliberately avoided because sharedness is an
accidental property that changes as profiles are added. Keeping shell, Git,
editors, terminal applications, and other capabilities in separate component
packages preserves fine-grained profile composition.

Platform modules contain settings that should apply to another machine on the
same platform. Host modules are reserved for hardware, display topology,
location, or source-host-specific connection behavior. For example, Terra's
Wayland services and general Sway configuration are platform settings, while
its DP-3 mode, Vulkan renderer, and darkman coordinates remain host settings.
The MacBook Pro host module currently contains only SSH connection overrides;
its iTerm, yabai, skhd, Colima, and 1Password agent configuration is macOS-wide.

Modules remain in one flat directory because Stow does not permit slashes in
package names. The prefixes preserve logical grouping while allowing an entire
profile to be applied in one transaction.

`component-vim` contains only a portable Vim 8 configuration for editing on
servers. It uses no downloaded plugins or external executables. Neovim remains
the full-featured development editor in `component-nvim`.

## Profiles

Files in `profiles/` list the modules selected for a machine, one per line.
Blank lines and lines beginning with `#` are ignored. A profile is a complete,
explicit deployment specification; the deployment script does not infer
packages from the current operating system or hostname.

Preview, apply, or remove a profile with:

```bash
./scripts/stow-profile --dry-run macbook-pro
./scripts/stow-profile macbook-pro
./scripts/stow-profile --delete macbook-pro
```

The script invokes Stow once for the complete package list, using `modules/` as
the Stow directory and `$HOME` as the target. It passes `--dotfiles` for visible
source names and `--no-folding` so runtime or machine-local files can coexist in
target directories without being written back into the repository.

After a successful apply, the selected modules are recorded under
`~/.local/state/dotfiles-profiles/`. A later apply includes a delete action for
modules present in the recorded state but absent from the current profile, so a
profile remains a complete specification rather than accumulating stale links.
`DOTFILES_PROFILE_STATE_ROOT` overrides this state location.

## Differences inside shared files

Stow combines packages when they own distinct destination paths, but two
selected packages cannot own the same file. Shared configuration should expose
an include or data boundary when possible.

The component SSH configuration loads `~/.ssh/config.d/*` before its defaults.
OpenSSH expands the wildcard lexically and uses the first value found for most
settings, so numeric prefixes encode precedence:

1. `host-macbook-pro/dot-ssh/config.d/10-host.conf`
2. `platform-macos/dot-ssh/config.d/20-platform.conf`
3. defaults in `component-ssh/dot-ssh/config`

Only encode a platform or host difference when the machine has an actual
requirement. Historical branch drift is not a profile requirement; Neovim LSP
enablement and Pi's provider, model, packages, and behavior are component-wide.

Prefer native include mechanisms when only part of an application differs.
`component-ghostty` loads optional `platform.conf` and `host.conf` files, while
`component-tmux` loads optional tmux overlays before TPM initialization. Sway's
Linux platform config similarly includes `~/.config/sway/host.d/*`. This keeps
one reusable primary configuration without sacrificing narrowly scoped
overrides.

Pi settings are user-level component configuration rather than platform state.
The canonical settings use OpenAI Codex with `gpt-5.6-sol`, retain `pi-vim`,
Kagi search, pi-lens, and diet-ripgrep, and expose OpenAI Codex, OpenAI,
Anthropic, OpenRouter DeepSeek, and local Ollama models in the cycle list.
Runtime metadata such as `lastChangelogVersion` is not tracked.

## Non-Stow files

Files that are consumed rather than linked into `$HOME` live outside
`modules/`. This includes profile definitions, deployment scripts,
documentation, and package-manager inputs such as `bootstrap/macos/Brewfile`.

## Migrating an existing checkout

Existing links created by older manual or ad-hoc Stow commands are not owned by
these modules. Keep the legacy checkout intact and run migration from the new
branch in a separate permanent checkout; switching the legacy checkout first
would make its links broken before the helper can record them. Use the
rollback-aware helper instead of removing them manually:

```bash
DOTFILES_LEGACY_ROOT="$HOME/dotfiles" ./scripts/migrate-profile-layout --verbose --dry-run migrate terra
DOTFILES_LEGACY_ROOT="$HOME/dotfiles" ./scripts/migrate-profile-layout migrate terra
```

Before changing anything, the helper deploys the profile into a temporary home
to inventory its exact file destinations. It then validates every destination:

- links must resolve inside the legacy checkout or this repository;
- regular files are moved into the rollback backup;
- directories, broken links, and links to unrelated locations abort the
  operation.

An optional `profiles/PROFILE.retired` file lists obsolete legacy links that no
longer have a destination in the profile. Migration removes only managed links
at those paths and records them for rollback; a real directory is preserved as
machine-local state. The macbook profile uses this to retire the old managed
`~/.vim` tree while leaving an independently managed runtime directory alone.

The previous raw link targets, regular files, and complete deployed-path list
are stored under `~/.local/state/dotfiles-layout/PROFILE`. If applying Stow
fails, the helper automatically attempts to restore the previous layout.

Inspect or roll back an active migration with:

```bash
./scripts/migrate-profile-layout status macbook-pro
./scripts/migrate-profile-layout --dry-run rollback macbook-pro
./scripts/migrate-profile-layout rollback macbook-pro
```

Rollback first verifies that deployed paths are still links into the modules
checkout. If an application replaced one with a regular file or unrelated
link, rollback stops rather than deleting it. After verification, it removes
the profile and restores the exact previous links and file contents. Runtime
files in directories that were already real remain untouched. If new local
state appears beneath a directory that was previously one legacy symlink, the
preflight stops so that state can be reviewed before restoring that link.

After accepting the new layout, validate and remove the rollback backup
explicitly:

```bash
./scripts/migrate-profile-layout --dry-run finalize macbook-pro
./scripts/migrate-profile-layout finalize macbook-pro
```

Finalize refuses to discard state unless every deployed profile path is still a
link into the modules checkout. `DOTFILES_LEGACY_ROOT` and
`DOTFILES_MIGRATION_STATE_ROOT` can override the legacy checkout and state
locations. Do not use `stow --adopt`, because it can overwrite module sources
with files from the target directory.
