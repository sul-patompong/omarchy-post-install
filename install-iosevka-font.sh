#!/bin/bash
set -e

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip"
FONT_DIR="${HOME}/.local/share/fonts/IosevkaTerm"
TEMP_FILE="/tmp/IosevkaTerm.zip"

echo "Downloading IosevkaTerm Nerd Font..."
curl -fsSL "$FONT_URL" -o "$TEMP_FILE"

echo "Installing font to $FONT_DIR..."
mkdir -p "$FONT_DIR"
unzip -o "$TEMP_FILE" -d "$FONT_DIR"

echo "Updating font cache..."
fc-cache -f "$FONT_DIR"

echo "Cleaning up..."
rm "$TEMP_FILE"

echo "Done! IosevkaTerm Nerd Font installed successfully."
echo "The font is now available in your applications."
