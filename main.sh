#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/hyprwm/Hyprland.git
cd Hyprland
git submodule update --init
cp -rvf ../debian ./

#sed -i 's/\/usr\/local/\/usr/g' config.mk
sed -E -i -e 's/(soversion = 12)([^032]|$$)/soversion = 12032/g' subprojects/wlroots/meson.build

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
