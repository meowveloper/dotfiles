#!/usr/bin/env bash

# 1. DBus environment (must stay first)
dbus-update-activation-environment --systemd --all

# 2. Create required directories and files
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/.rmpc-cache
mkdir -p ~/.config/matugen-outs
mkdir -p ~/.cache
touch ~/.config/hypr/src/user-specific.conf
touch ~/.config/shell/user

hyprsunset & 
# swww
swww-daemon &

# matugen
if [[ -f ~/.cache/last-wallpaper.txt ]] && [[ -n "$(cat ~/.cache/last-wallpaper.txt)" ]]; then
    WALL=$(cat ~/.cache/last-wallpaper.txt)
    if [[ -f "$WALL" ]]; then
        matugen image "$WALL"
    else
        # fallback if the file got deleted/moved
        matugen image ~/.config/wallpapers/wallhaven-57qky5.jpg
    fi
else
    matugen image ~/.config/wallpapers/wallhaven-57qky5.jpg
fi

# 6. Start the rest
~/.config/waybar/scripts/launch.sh
