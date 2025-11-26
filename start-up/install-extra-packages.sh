#!/bin/bash

SOURCEDIR="${HOME}/.local/share/chezmoi"
PKGLIST="${SOURCEDIR}/start-up/extra-packages.txt"
echo "installing extra packages."

cat "$PKGLIST" | yay -S - --noconfirm --needed

echo "installation of extra packages complete."
