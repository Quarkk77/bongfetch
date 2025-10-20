#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/bin/"
SCRIPT_NAME="bongfetch"
SCRIPT_PATH='./bongfetch'

DEPS=("fortune" "cowsay" "fastfetch")

# check for dependencies
echo ">>> Checking dependencies..."
missing=()
for dep in "${DEPS[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
        missing+=("$dep")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo -e "\033[1;31m>>> Missing commands: ${missing[*]}\033[0m"
    echo "Install their corresponding packages and rerun this installer."
    exit 1
fi

# make sure ~/.local/bin exists
mkdir -p $INSTALL_DIR

# copy the script
echo ">>> Installing $SCRIPT_NAME to $INSTALL_DIR..."
cp "$SCRIPT_PATH" "$INSTALL_DIR/$SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

echo ">>> Installation complete!"

# check PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo
    echo "⚠️  $INSTALL_DIR is not in your PATH."
    echo "Run this to fix it:"
    echo 'export PATH="$HOME/.local/bin:$PATH"'' >> ~/.bashrc'
    echo "Then reopen your terminal."
fi

echo
echo "Run with:  $SCRIPT_NAME"
