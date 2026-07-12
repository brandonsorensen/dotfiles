#!/bin/bash
set -e

sudo tee /usr/share/wayland-sessions/sway-nvidia.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=Sway (NVIDIA)
Comment=An i3-compatible Wayland compositor
Exec=start-sway
Type=Application
DesktopNames=sway;wlroots
EOF

sudo tee /etc/greetd/config.toml > /dev/null << 'EOF'
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --remember --remember-session --sessions /usr/share/wayland-sessions"
user = "greeter"
EOF

sudo systemctl restart greetd
