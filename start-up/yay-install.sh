#!/bin/bash
BUILD_DIR="/tmp/yay-install-build"
SOURCEDIR="${HOME}/.local/share/chezmoi"
PKGLIST="${SOURCEDIR}/start-up/extra-packages.txt"

echo "Attempting to install yay..."

if command -v yay &> /dev/null
then
    echo "yay is already installed. Skipping build process."
    exit 0
fi

sudo pacman -S --needed git base-devel --noconfirm

rm -rf "$BUILD_DIR"
git clone https://aur.archlinux.org/yay.git "$BUILD_DIR"

cd "$BUILD_DIR" || { echo "Failed to enter $BUILD_DIR. Exiting."; exit 1; }
makepkg -si --noconfirm

rm -rf "$BUILD_DIR"

echo "yay installation complete."

echo "installing extra packages."

cat "$PKGLIST" | yay -S - --noconfirm --needed

echo "installation of extra packages complete."
