#!/bin/bash

# Script to install asdf with latest Node.js on Arch Linux
# Run with: bash install-asdf-nodejs.sh

set -e  # Exit on error

echo "==================================="
echo "Installing asdf with Node.js"
echo "==================================="

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "Error: yay is not installed. Please install yay first."
    echo "You can install it from: https://aur.archlinux.org/yay.git"
    exit 1
fi


# Check if asdf is already installed
if command -v asdf &> /dev/null; then
    echo "asdf is already installed!"
    asdf version
else
    echo "Installing asdf via AUR (yay)..."
    yay -S --noconfirm asdf-vm
    echo "asdf installed successfully!"
fi

# Add asdf shims to PATH in shell configuration
SHELL_RC="$HOME/.zshrc"
if [ -f "$HOME/.bashrc" ] && [ ! -f "$SHELL_RC" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

if ! grep -q "asdf/shims" "$SHELL_RC" 2>/dev/null; then
    echo "Configuring asdf in $SHELL_RC..."
    echo "" >> "$SHELL_RC"
    echo "# asdf version manager" >> "$SHELL_RC"
    echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> "$SHELL_RC"
else
    echo "asdf already configured in $SHELL_RC"
fi

# Source the updated config for current session
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Install Node.js plugin for asdf
echo "Installing Node.js plugin..."
if asdf plugin list | grep -q "nodejs"; then
    echo "Node.js plugin already installed"
else
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    echo "Node.js plugin installed!"
fi

# Install latest Node.js version
echo "Installing latest Node.js version..."
LATEST_NODE=$(asdf latest nodejs)
echo "Latest Node.js version: $LATEST_NODE"

if asdf list nodejs 2>/dev/null | grep -q "$LATEST_NODE"; then
    echo "Node.js $LATEST_NODE is already installed"
else
    asdf install nodejs latest
    echo "Node.js $LATEST_NODE installed successfully!"
fi

# Set as global default
echo "Setting Node.js $LATEST_NODE as global default..."
asdf set -u nodejs latest

# Verify installation
echo ""
echo "==================================="
echo "Installation Complete!"
echo "==================================="
echo ""
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"
echo ""
echo "To use asdf in your current shell, run:"
echo "source $SHELL_RC"
echo ""
echo "Or open a new terminal to start using Node.js"
echo ""
echo "Useful asdf commands:"
echo "  asdf list nodejs           - List installed Node.js versions"
echo "  asdf install nodejs <ver>  - Install a specific version"
echo "  asdf set -u nodejs <ver>   - Set global default version"
echo "  asdf set nodejs <ver>      - Set version for current directory"
