#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake          \
    libcdio        \
    sdl3_image     \
    shaderc        \
    vulkan-headers \
    wildmidi

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

make-aur-package adlmidi

echo "Building ROLLER..."
echo "---------------------------------------------------------------"
REPO="https://github.com/FatalDecomp/ROLLER"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --depth 1 "$REPO" ./ROLLER
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./ROLLER
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
mv -v roller ../../AppDir/bin
cp -rv ../midi ../../AppDir/bin
