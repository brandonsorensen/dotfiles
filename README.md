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
ln -sf ~/dotfiles/common/gtklock    ~/.config/gtklock
```

### Wallpaper

The sway config and gtklock stylesheet reference `~/Pictures/wallpapers/current`.
Set this to your desired wallpaper via symlink:

```bash
ln -sf ~/Pictures/wallpapers/<name>.jpg ~/Pictures/wallpapers/current
```

### Lock screen (gtklock)

`gtklock` is used as the lock screen. The wrapper script `scripts/gtklock-launch.sh`
resolves `$HOME` in the CSS stylesheet at runtime (GTK CSS `url()` does not expand
environment variables). Make the script executable after cloning:

```bash
chmod +x ~/dotfiles/scripts/gtklock-launch.sh
```

### Keychron K8 media keys

The Keychron K8 requires the `hid_apple` kernel module for media keys to work on Linux.
To persist this across reboots:

```bash
sudo modprobe hid_apple
echo 'options hid_apple fnmode=1' | sudo tee /etc/modprobe.d/hid_apple.conf
sudo mkinitcpio -P
```

Alternatively, hold `fn+X+L` for 4 seconds to toggle hardware fn mode without any
driver configuration.

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
