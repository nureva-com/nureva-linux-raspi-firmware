#!/usr/bin/env bash
# Installs the needed dependences to run the ./build.sh script
# Usage: sudo ./install_deps.sh 

set -euo pipefail

# Check for debhelper-compat (= 13)
if ! dpkg-query -W -f='${Version}\n' debhelper-compat 2>/dev/null | grep -qx '13'; then
    echo "Installing debhelper-compat (= 13)..."
    sudo apt-get update
    sudo apt-get install -y debhelper-compat
fi

# Check for zstd
if ! dpkg -s zstd >/dev/null 2>&1; then
    echo "Installing zstd..."
    sudo apt-get update
    sudo apt-get install -y zstd
fi

echo "System is setup to run build.sh"
exit 0