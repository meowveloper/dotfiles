#!/bin/bash

echo "installing extra packages."

cat "$PKGLIST" | yay -S - --noconfirm --needed

echo "installation of extra packages complete."
