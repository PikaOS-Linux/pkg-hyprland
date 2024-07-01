#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Dead Pika Release Quirk??
apt-get install libglib2.0-0=2.78.0-2 libglib2.0-bin=2.78.0-2 libglib2.0-dev-bin=2.78.0-2 -y

# Clone Upstream
wget -nv https://github.com/hyprwm/Hyprland/releases/download/v.0/source-v.0.tar.gz
tar -xf ./source-v.0.tar.gz
cp -rvf ./debian ./hyprland-source/debian
cd ./hyprland-source

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
