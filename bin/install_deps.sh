#!/usr/bin/env bash
# Installs the needed dependencies to run the ./build.sh script
# Usage: sudo ./install_deps.sh 

set -euo pipefail

# Check for debhelper-compat (= 13). We need a specific version of debhelper for this
if ! dpkg-query -W -f='${Version}\n' debhelper-compat 2>/dev/null | grep -qx '13'; then
    echo "Installing debhelper-compat (= 13)..."
    sudo apt-get update
    sudo apt-get install -y debhelper-compat
fi

packages=(
    dpkg-dev
    apt-utils
    zstd
)

missing=()
for pkg in "${packages[@]}"; do
    dpkg -s "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
done

if [ "${#missing[@]}" -gt 0 ]; then
    echo "Installing missing packages: ${missing[*]}"
    sudo apt-get update -y
    sudo apt-get install -y "${missing[@]}"
fi

echo "System is setup to run build.sh"
exit 0