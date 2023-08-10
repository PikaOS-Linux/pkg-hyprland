#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
wget -nv https://github.com/hyprwm/Hyprland/releases/download/v0.28.0/source-v0.28.0.tar.gz
tar -xf ./source-v0.28.0.tar.gz
cp -rvf ./debian ./hyprland-source
cd ./hyprland-source

#sed -i 's/\/usr\/local/\/usr/g' config.mk
sed -E -i -e 's/(soversion = 12)([^032]|$$)/soversion = 12032/g' subprojects/wlroots/meson.build

# Get build deps
apt-get update
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
