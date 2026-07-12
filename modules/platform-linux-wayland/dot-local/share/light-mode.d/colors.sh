#!/bin/sh
# Called by darkman when switching to light mode.

gsettings set org.gnome.desktop.interface color-scheme prefer-light

ln -sf "$HOME/.config/sway/colors-light" "$HOME/.config/sway/colorscheme"
swaymsg reload

systemctl --user restart waybar
