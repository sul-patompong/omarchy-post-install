#!/bin/bash
set -e

echo "Installing GNU Stow..."
yay -S --needed --noconfirm stow

echo "Done! Stow installed successfully."
