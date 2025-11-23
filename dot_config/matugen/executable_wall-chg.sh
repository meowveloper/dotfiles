#!/usr/bin/env bash
# ~/.config/yazi/set-wallpaper.sh
WALL="$1"

echo "$WALL" > ~/.cache/last-wallpaper.txt

matugen image "$WALL"
