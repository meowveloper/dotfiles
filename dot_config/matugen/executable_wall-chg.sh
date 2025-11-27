#!/usr/bin/env bash
# ~/.config/yazi/set-wallpaper.sh
WALL="$1"

rm ~/.cache/last-wallpaper
cp "${WALL}" ~/.cache/last-wallpaper

matugen image "$WALL"
