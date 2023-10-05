#! /bin/bash
set -e

# Clone Upstream
git clone https://gitlab.freedesktop.org/mesa/mesa -b mesa-23.1.9
cp -rvf ./debian ./mesa/
cd ./mesa
sed -i ' 1 s/.*/& - PikaOS YellowBirb Mesa Stable/' ./VERSION

# Get build deps
apt-get build-dep ./ -y

# Build package

dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
