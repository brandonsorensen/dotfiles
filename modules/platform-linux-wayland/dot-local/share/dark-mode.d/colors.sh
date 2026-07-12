#!/bin/sh
# Called by darkman when switching to dark mode.

gsettings set org.gnome.desktop.interface color-scheme prefer-dark

ln -sf "$HOME/.config/sway/colors-dark" "$HOME/.config/sway/colorscheme"
swaymsg reload

systemctl --user restart waybar
