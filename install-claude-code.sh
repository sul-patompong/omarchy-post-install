#!/bin/bash
set -e

echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

# Add ~/.local/bin to PATH
SHELL_RC="${HOME}/.zshrc"
[ -f "${HOME}/.bashrc" ] && [ ! -f "$SHELL_RC" ] && SHELL_RC="${HOME}/.bashrc"

if ! grep -q '.local/bin' "$SHELL_RC" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
    echo "Added ~/.local/bin to PATH in $SHELL_RC"
fi

export PATH="$HOME/.local/bin:$PATH"

echo "Done! Run 'claude' to start (or 'source $SHELL_RC' in current shell)"
