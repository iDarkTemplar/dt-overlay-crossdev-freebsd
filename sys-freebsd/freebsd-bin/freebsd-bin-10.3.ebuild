# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit bsdmk freebsd

DESCRIPTION="FreeBSD /bin tools"
SLOT="0"

IUSE="build"

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

EXTRACTONLY="
	bin/
	usr.bin/
	sbin/
	lib/
"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	>=dev-libs/libedit-20120311.3.0-r1
	sys-libs/ncurses:0=
	sys-apps/ed
	!app-misc/realpath
	!<sys-freebsd/freebsd-ubin-8"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	>=sys-devel/flex-2.5.31-r2"

S=${WORKDIR}/bin

# csh and tcsh are provided by tcsh package, rmail is sendmail stuff.
REMOVE_SUBDIRS="csh rmail ed freebsd-version"

pkg_setup() {
	mymakeopts="${mymakeopts} WITHOUT_TCSH= WITHOUT_SENDMAIL= WITHOUT_RCMDS= "
}

src_prepare() {
	if use build ; then
		# Don't build sh as it requires some build-time tools
		# which can't run in cross-compilation environment
		sed -i '/[[:blank:]]sh[[:blank:]]/d' "${WORKDIR}"/bin/Makefile
	fi
}
