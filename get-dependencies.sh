#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake      \
    libdecor   \
    sdl3       \
    sdl3_image \
    wildmidi

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package

# If the application needs to be manually built that has to be done down here
echo "Making nightly build of ROLLER..."
echo "---------------------------------------------------------------"
REPO="https://github.com/FatalDecomp/ROLLER"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./ROLLER
echo "$VERSION" > ~/version

cd ./ROLLER
mkdir -p build && cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="/usr"
make -j$(nproc)

mv -v roller /usr/bin
cp -v ../images/roller.ico /usr/share/pixmaps/roller.ico
cp -rv ../midi /usr
