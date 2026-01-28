# Contributor and POWER Maintainer: Link <link4electronics@gmail.com>

pkgname=roller-git
pkgver=0.1.1.r219.g7c23000
pkgrel=1
pkgdesc="Reverse engineering the 1995 game Whiplash/Fatal Racing"
arch=('x86_64' 'aarch64')
url="https://github.com/FatalDecomp/ROLLER"
license=('GPL')
depends=('sdl3' 'sdl3_image' 'wildmidi')
makedepends=("git" "cmake" "gcc")
options=('!debug' 'strip')
source=("git+https://github.com/FatalDecomp/ROLLER.git")
sha256sums=('SKIP')

pkgver() {
	cd ROLLER
	git describe --long --tags | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

build() {
    cd "${srcdir}/ROLLER"
    cmake -B build . \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="/usr"
    cmake --build build
}

package() {
    cd "${srcdir}/ROLLER"
	install -dm757 "$pkgdir"/usr/bin
    install -m755 build/roller "$pkgdir"/usr/bin
	install -Dm644 images/roller.ico "$pkgdir"/usr/share/pixmaps/roller.ico
    cp -r midi "$pkgdir"/usr
}
