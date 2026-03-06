#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

REPO="YuanxinPan/PPPx_bin"
EXE_NAME="pppx"
INSTALL_DIR="${HOME}/.local/bin"

echo "Starting installation of $EXE_NAME..."

# 1. Detect Operating System
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
if [ "$OS" = "darwin" ]; then
    OS="macos"
elif [ "$OS" != "linux" ]; then
    echo "Error: Unsupported OS '$OS'. This script only supports Linux and macOS."
    exit 1
fi

# 2. Detect Architecture
ARCH="$(uname -m)"
if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "amd64" ]; then
    ARCH="x86_64"
elif [ "$ARCH" = "arm64" ] || [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
else
    echo "Error: Unsupported architecture '$ARCH'."
    exit 1
fi

echo "Detected system: $OS ($ARCH)"

# 3. Fetch the latest release download URL from GitHub API
echo "Fetching latest release data..."
LATEST_JSON=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Search for the asset that matches the OS and Architecture
# Assuming your assets are named something like: PPPx_v1.2.0_linux_x86_64.tar.gz
echo "$LATEST_JSON" | grep '"browser_download_url":'
DOWNLOAD_URL=$(echo "$LATEST_JSON" | grep '"browser_download_url":' | grep -i "pppx.*${OS}_${ARCH}\.zip" | head -n 1 | cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Could not find a matching release asset for $OS $ARCH."
    echo "Please download and install manually from: https://github.com/$REPO/releases/latest"
    exit 1
fi

echo "Downloading from: $DOWNLOAD_URL"

# 4. Download and Extract to a temporary directory
TMP_DIR=$(mktemp -d)
ZIP_FILE="$TMP_DIR/release.zip"

# Download the file
echo "Downloading to: $ZIP_FILE"
curl -sL "$DOWNLOAD_URL" -o "$ZIP_FILE"

echo "Extracting..."
unzip "$ZIP_FILE" -d "$TMP_DIR"

# Find the executable (in case it extracted into a subfolder)
find "$TMP_DIR" -type f -name "$EXE_NAME"
EXTRACTED_EXE=$(find "$TMP_DIR" -type f -name "$EXE_NAME" | head -n 1)

if [ -z "$EXTRACTED_EXE" ]; then
    echo "Error: Could not find the '$EXE_NAME' executable inside the downloaded archive."
    rm -rf "$TMP_DIR"
    exit 1
fi

# 5. Move to the installation directory
echo "Installing to $INSTALL_DIR..."
echo "You may be prompted for your password to grant 'sudo' permissions."
mv "$EXTRACTED_EXE" "$INSTALL_DIR/$EXE_NAME"
chmod +x "$INSTALL_DIR/$EXE_NAME"

# 6. macOS Quarantine bypass (prevents the "Cannot be opened" security warning)
if [ "$OS" = "macos" ]; then
    echo "Applying macOS specific configurations..."
    xattr -d com.apple.quarantine "$INSTALL_DIR/$EXE_NAME" 2>/dev/null || true
fi

# 7. Clean up
rm -rf "$TMP_DIR"

echo ""
echo "Installation complete! You can now run '$EXE_NAME' from anywhere in your terminal."
