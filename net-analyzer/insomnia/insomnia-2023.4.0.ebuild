# Copyright 2023 Aaro Koivukangas
# Distributed under the terms of the GNU General Public License v2
#
# Ebuild of insomnia RESTful API-tester. Installed as a precompiled binary
# because of npm being hard to package on gentoo :s
#
# It requires network in src_install phase which is not ideal because of
# sandboxing things not allowing network access during installation...


EAPI=8

P_NAME="Insomnia.Core-${PV}"
S="${WORKDIR}/${P_NAME}"

DESCRIPTION="Insomnia RESTful API tester"
HOMEPAGE="https://github.com/Kong/insomnia"
SRC_URI="https://github.com/Kong/insomnia/releases/download/core@${PV}/Insomnia.Core-${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

# DEPEND=">=net-libs/nodejs-18.6.0[npm]
		# >=dev-vsc/git-2.41.0"

src_unpack() {
	# einfo "Unpacking"
	unpack ${A}
	# ls ${S}
}

src_install() {
	# einfo "Making dirs"
	dodir /usr/bin/
	dodir /usr/lib/insomnia/

	# einfo "Copying files to lib in ${D}/usr/lib/insomnia"
	cp ${S}/* ${D}/usr/lib/insomnia -r || die "Install failed"
	# ls ${D}/usr/lib/insomnia -l

	# einfo "Doing symlink"
	dosym ${EPREFIX}/usr/lib/insomnia/insomnia ${EPREFIX}/usr/bin/insomnia
	# ls ${D}/usr/bin -l
}

