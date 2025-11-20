
#!/bin/bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/sul-patompong/dotfiles"
REPO_NAME="dotfiles"

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "removing old configs"
  # Below is the original config maybe need for references
  # rm -rf ~/.config/nvim ~/.config/starship.toml ~/.local/share/nvim/ ~/.cache/nvim/ ~/.config/ghostty/config
  rm -rf ~/.config/starship.toml
  rm -rf ~/.config/fontconfig
  rm -rf ~/.bashrc

  cd "$REPO_NAME"
  stow hypr
  stow ssh
  stow fontconfig
  stow bashrc
else
  echo "Failed to clone the repository."
  exit 1
fi
