#!/bin/sh
# Called by darkman when switching to dark mode.

gsettings set org.gnome.desktop.interface color-scheme prefer-dark

ln -sf "$HOME/dotfiles/common/sway/colors-dark" "$HOME/.config/sway/colorscheme"
swaymsg reload

cp "$HOME/.config/waybar/style-dark.css" "$HOME/.config/waybar/style.css"
systemctl --user restart waybar
