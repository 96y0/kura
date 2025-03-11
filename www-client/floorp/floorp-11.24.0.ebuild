# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="A new Firefox based browser from Japan with excellent privacy & flexibility."
HOMEPAGE="https://floorp.app/"
GITHUB="https://github.com/Floorp-Projects/Floorp"
SRC_URI="
	amd64? ( ${GITHUB}/releases/download/v${PV}/floorp-${PV}.linux-x86_64.tar.bz2 -> ${P}-amd64.tar.bz2 )
	arm64? ( ${GITHUB}/releases/download/v${PV}/floorp-${PV}.linux-aarch64.tar.bz2 -> ${P}-arm64.tar.bz2 )
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="*"

S=${WORKDIR}

src_install() {
	DEST="${ED}/opt/${PN}"
	mkdir -p "${DEST}" || die "mkdir failed"
	cp -a "floorp/"* "${DEST}" || die "cp failed"

	newicon -s 128 "floorp/browser/chrome/icons/default/default128.png" "${PN}.png" || die "doicon failed"

	dosym "/opt/floorp/floorp" "/usr/bin/floorp" || die "dosym failed"

	MIMETYPE="MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;"

	make_desktop_entry "${PN} %U" "Floorp Browser" ${PN} "Network;WebBrowser" "StartupWMClass=floorp\n${MIMETYPE}"
}

