#!/bin/bash

# Script to install zsh with Oh My Zsh on Arch Linux
# Run with: bash install-zsh.sh

set -e  # Exit on error

echo "==================================="
echo "Installing Zsh with Oh My Zsh"
echo "==================================="

# Check if zsh is already installed
if command -v zsh &> /dev/null; then
    echo "Zsh is already installed!"
    zsh --version
else
    # Update package database
    echo "Updating package database..."
    sudo pacman -Sy

    # Install zsh
    echo "Installing zsh..."
    sudo pacman -S --noconfirm zsh

    # Verify zsh installation
    if ! command -v zsh &> /dev/null; then
        echo "Error: zsh installation failed"
        exit 1
    fi

    echo "Zsh installed successfully!"
    zsh --version
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed. Skipping..."
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell
echo "Setting zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    echo "Default shell changed to zsh"
    echo "Please log out and log back in for the change to take effect"
else
    echo "Zsh is already your default shell"
fi

echo ""
echo "==================================="
echo "Installation Complete!"
echo "==================================="
echo ""
echo "To start using zsh now, run: zsh"
echo "Or log out and log back in to use it as your default shell"
echo ""
echo "Oh My Zsh configuration file: ~/.zshrc"
echo "You can customize your shell by editing this file"
