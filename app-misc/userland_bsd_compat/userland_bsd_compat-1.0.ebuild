EAPI=4

inherit eutils

DESCRIPTION="GNU userland support for freebsd crosscompiling"
HOMEPAGE=""

SRC_URI=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}"

src_install() {
	dosym /bin/sed /bin/gsed
	dosym /usr/bin/patch /usr/bin/gpatch
	dosym /usr/bin/find /usr/bin/gfind
	dosym /usr/bin/xargs /usr/bin/gxargs

	dosym /bin/sed /usr/bin/sed
}
