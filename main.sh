#! /bin/bash

set -e

# Dead Pika Release Quirk??
apt-get install libglib2.0-0=2.78.0-2 libglib2.0-bin=2.78.0-2 libglib2.0-dev-bin=2.78.0-2 -y --allow-downgrades

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone -b v0.41.2 --depth=1 https://github.com/hyprwm/Hyprland ./hyprland
cp -rvf ./debian ./hyprland/debian
cd ./hyprland

#sed -i 's/\/usr\/local/\/usr/g' config.mk
#sed -E -i -e 's/(soversion = 12)([^032]|$$)/soversion = 12032/g' subprojects/wlroots/meson.build

# Get build deps
apt-get update
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
