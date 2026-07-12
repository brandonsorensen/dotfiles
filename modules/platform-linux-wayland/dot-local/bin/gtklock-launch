#!/bin/sh
# GTK CSS url() does not expand environment variables, so the wallpaper path
# cannot reference $HOME directly in style.css. This script generates a
# temporary stylesheet with the resolved path before invoking gtklock.

STYLE=$(mktemp /tmp/gtklock-style-XXXXXX.css)
trap 'rm -f "$STYLE"' EXIT

sed "s|WALLPAPER_PATH|$HOME/Pictures/wallpapers/current|g" \
    "$HOME/.config/gtklock/style.css" > "$STYLE"

exec gtklock --style "$STYLE"
