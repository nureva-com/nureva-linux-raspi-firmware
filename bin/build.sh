#!/usr/bin/env bash
set -euo pipefail

ARCH=$(uname -m)

# Chech the arch type, this script supports builds for arm64
# TODO: expand support for armhf
if [ "$ARCH" != "aarch64" ]; then
    echo "Must be run on an aarch64 system"
    exit 1
fi

echo "Building the raspberry pi linux binary package"

# Clone the submodule
git submodule update --init
