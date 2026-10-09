#!/usr/bin/env bash
# Script is used to build our custom version of the linux firmware raspi package with the latest .elfs from Raspberry Pi
# Usage: ./bin/build.sh

set -euo pipefail

# This commit corresponds to this release tag: 
# https://github.com/raspberrypi/firmware/releases/tag/1.20260915
BOOT_COMMIT="6f0881cba8bea8ec24956a5718714730e9936ec5"

# Chech the arch type, this script supports builds for arm64
# TODO: expand support for armhf
ARCH=$(uname -m)
if [ "$ARCH" != "aarch64" ]; then
    echo "Must be run on an aarch64 system"
    exit 1
fi

echo "Building the raspberry pi linux binary package"

# Clone the submodule
git submodule update --init

pushd ./linux-firmware-raspi

# Replace the boot commit we want to source from the raspberry pi firmware
sed -i "s/^BOOTCOMMIT:= .*$/BOOTCOMMIT:= $BOOT_COMMIT/" debian/rules

# Fetch the actual raspberry pi binaries from source
# note that this command does a clean operation as well.
./debian/rules get-orig-source

# Build the package using the debian rules file
dpkg-buildpackage -b -us -uc

popd

# Remove all of the uneeded archives that the builddeb generates as a temporary step.
# We could modify the debian/rules file to do this but this is easier IMO
rm -f *-firmware-raspi_12.orig{,-bluez,-boot,-nonfree}.tar.gz
