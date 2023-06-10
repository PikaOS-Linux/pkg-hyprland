#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
#apt install pika-sources.deb --yes --option Acquire::Retries=5 --option Acquire::http::Timeout=100 --option Dpkg::Options::="--force-confnew"
# Clone Upstream

wget https://github.com/hyprwm/Hyprland/releases/download/v0.26.0/source-v0.26.0.tar.gz
mkdir -p ./src-pkg-name
cp -rvf ./debian ./src-pkg-name/
cd ./src-pkg-name/

wget -nv https://github.com/hyprwm/Hyprland/releases/download/v0.26.0/source-v0.26.0.tar.gz
tar -xf ./source-v0.26.0
mkdir -p ./source-v0.26.0
cp -rvf ./debian ./source-v0.26.0/
cd ./source-v0.26.0/

sed -i 's/\/usr\/local/\/usr/g' config.mk

# Get build deps
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
