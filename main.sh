# Clone Upstream
git clone https://gitlab.freedesktop.org/mesa/mesa -b mesa-23.1.5
cp -rvf ./debian ./mesa/
cd ./mesa

# Get build deps
apt-get build-dep ./ -y

# Build package

LOGNAME=root dh_make --createorig -y -l -p mesa_23.1.5

dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
