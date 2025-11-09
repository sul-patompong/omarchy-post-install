#!/bin/bash

set -e

HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
CUSTOM_OVERRIDES="$HOME/.config/hypr/mycustom-overrides.conf"
SOURCE_LINE="source = ~/.config/hypr/mycustom-overrides.conf"

# Check if custom overrides config exists
if [ ! -f "$CUSTOM_OVERRIDES" ]; then
    echo "Error: Custom overrides config not found at $CUSTOM_OVERRIDES"
    exit 1
fi

# Check if hyprland config exists
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Error: Hyprland config not found at $HYPRLAND_CONFIG"
    exit 1
fi

# Check if source line already exists in hyprland.conf
if grep -Fxq "$SOURCE_LINE" "$HYPRLAND_CONFIG"; then
    echo "Source line already exists in $HYPRLAND_CONFIG"
else
    echo "Adding source line to $HYPRLAND_CONFIG"
    echo "" >> "$HYPRLAND_CONFIG"
    echo "$SOURCE_LINE" >> "$HYPRLAND_CONFIG"
    echo "Source line added successfully"
fi

echo "Hyprland overrides setup complete!"
