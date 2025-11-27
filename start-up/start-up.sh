#!/usr/bin/env bash
set -euo pipefail

# Colors for pretty output (optional but nice)
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Installing / updating chezmoi${NC}"
if ! command -v chezmoi >/dev/null 2>&1; then
  sudo pacman -S --noconfirm --needed chezmoi
else
  echo "chezmoi already installed"
fi

echo -e "${GREEN}Cloning and applying dotfiles${NC}"
SOURCEDIR="${HOME}/.local/share/chezmoi"
if [[ -d "$SOURCEDIR" ]]; then
  echo "Source directory exists—updating..."
  chezmoi update --apply --verbose
else
  echo "No source directory—initializing fresh..."
  chezmoi init --apply --verbose https://github.com/meowveloper/dotfiles.git
fi


# The package list is now managed by chezmoi, so it’s guaranteed to exist
PKGLIST="${SOURCEDIR}/start-up/packages.txt"

echo -e "${GREEN}Updating system and installing all packages${NC}"
# --needed skips already-installed packages, so the script is safe to re-run
sudo pacman -Syu --noconfirm --needed - < "$PKGLIST"

# yay install
YAY_SCRIPT_PATH="${SOURCEDIR}/start-up/yay-install.sh"
bash "${YAY_SCRIPT_PATH}"

echo -e "${GREEN}Updating font cache${NC}"
fc-cache -f -v

echo -e "${GREEN}Enabling system-wide services (if needed)${NC}"
sudo systemctl enable --now warp-svc.service

echo -e "${GREEN}All done! You can reboot now or just log out/in.${NC}"
echo "    reboot"
echo "    or log out and back in if you started this from a TTY"
