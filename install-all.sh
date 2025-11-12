#!/bin/bash

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo ""
    echo "=========================================="
    echo -e "${YELLOW}$1${NC}"
    echo "=========================================="
    echo ""
}

# Function to run installation script
run_install() {
    local script=$1
    local name=$2

    print_header "Installing: $name"

    if [ -f "$script" ]; then
        if bash "$script"; then
            echo -e "${GREEN}✓ $name installed successfully${NC}"
        else
            echo -e "${RED}✗ Failed to install $name${NC}"
            exit 1
        fi
    else
        echo -e "${RED}✗ Script not found: $script${NC}"
        exit 1
    fi
}

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "  Linux Installation Master Script"
echo "=========================================="
echo ""
echo "This script will install the following in sequence:"
echo "1. Zsh"
echo "2. Stow"
echo "3. Dotfiles"
echo "4. Hyprland Overrides"
echo "5. ASDF"
echo "6. Iosevka Font"
echo "7. Claude Code"
echo "8. Brave Browser"
echo "9. Solaar"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

# Installation sequence
run_install "./install-zsh.sh" "Zsh"
run_install "./install-stow.sh" "Stow"
run_install "./install-dotfiles.sh" "Dotfiles"
run_install "./install-hyprland-overrides-config.sh" "Hyprland Overrides"
run_install "./install-asdf.sh" "ASDF"
run_install "./install-iosevka-font.sh" "Iosevka Font"
run_install "./install-claude-code.sh" "Claude Code"
run_install "./install-brave.sh" "Brave Browser"
run_install "./install-solarr.sh" "Solaar"

# Final summary
echo ""
echo "=========================================="
echo -e "${GREEN}✓ All installations completed successfully!${NC}"
echo "=========================================="
echo ""
echo "You may need to:"
echo "  - Log out and log back in for some changes to take effect"
echo "  - Restart your terminal or source your shell configuration"
echo ""
