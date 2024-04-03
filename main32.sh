#! /bin/bash
set -e

# Clone Upstream
git clone https://gitlab.freedesktop.org/mesa/mesa -b mesa-24.0.4
cp -rvf ./debian ./mesa/
cd ./mesa
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done
sed -i ' 1 s/.*/& - PikaOS YellowBirb Mesa Stable/' ./VERSION

# Get build deps
apt-get build-dep ./ -y

# Build package

dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
