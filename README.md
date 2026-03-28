# dotfiles

## Structure

```
common/   # shared config (sway, waybar, kanshi, tmux, etc.)
mac/      # macOS-specific config
scripts/  # utility scripts
```

Configs are symlinked from `~/.config/` into the appropriate subdirectory here.

## One-time setup on a new machine

### Symlink configs

Link the relevant configs into `~/.config/`:

```bash
ln -sf ~/dotfiles/common/sway       ~/.config/sway
ln -sf ~/dotfiles/common/waybar     ~/.config/waybar
ln -sf ~/dotfiles/common/kanshi     ~/.config/kanshi
```

### Set up systemd user services (Linux/sway only)

Waybar and kanshi are managed as systemd user services via
[sway-systemd](https://github.com/alebastr/sway-systemd), which provides
`sway-session.target`. This ensures they start only after sway has exported
the Wayland environment, and restart automatically on crash.

**Install the package:**

```bash
yay -S sway-systemd
```

**Symlink the service files:**

```bash
mkdir -p ~/.config/systemd/user
ln -sf ~/dotfiles/common/systemd/waybar.service ~/.config/systemd/user/waybar.service
ln -sf ~/dotfiles/common/systemd/kanshi.service ~/.config/systemd/user/kanshi.service
```

**Enable the services:**

```bash
systemctl --user daemon-reload
systemctl --user enable waybar.service kanshi.service
```

The services will start automatically on next sway login via `sway-session.target`.
No further manual intervention is needed. To check status:

```bash
systemctl --user status waybar
systemctl --user status kanshi
```
