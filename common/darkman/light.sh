#!/bin/sh
# Called by darkman when switching to light mode.

gsettings set org.gnome.desktop.interface color-scheme prefer-light

ln -sf "$HOME/dotfiles/common/sway/colors-light" "$HOME/.config/sway/colorscheme"
swaymsg reload

cp "$HOME/.config/waybar/style-light.css" "$HOME/.config/waybar/style.css"
systemctl --user restart waybar
