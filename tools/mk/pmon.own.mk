#	$OpenBSD: bsd.own.mk,v 1.53 2001/09/02 14:34:14 art Exp $
#	$NetBSD: bsd.own.mk,v 1.24 1996/04/13 02:08:09 thorpej Exp $

# Host-specific overrides
.if defined(MAKECONF) && exists(${MAKECONF})
.include "${MAKECONF}"
.elif exists(/etc/pmon_mk.conf)
.include "/etc/pmon_mk.conf"
.endif

# Set `WARNINGS' to `yes' to add appropriate warnings to each compilation
WARNINGS?=	no
# Set `DEBUGLIBS' to `yes' to build libraries with debugging symbols
DEBUGLIBS?=	no
# Set toolchain for libdl and other "differences"
.if (${MACHINE_ARCH} == "alpha" || ${MACHINE_ARCH} == "powerpc" || ${MACHINE_ARCH} == "sparc64")
ELF_TOOLCHAIN?=	yes
.else
ELF_TOOLCHAIN?=	no
.endif

# where the system object and source trees are kept; can be configurable
# by the user in case they want them in ~/foosrc and ~/fooobj, for example
PMONSRCDIR?=	/usr/pmon/src
PMONOBJDIR?=	/usr/pmon/obj

BINGRP?=	bin
BINOWN?=	root
BINMODE?=	555
NONBINMODE?=	444
DIRMODE?=	755

# Define MANZ to have the man pages compressed (gzip)
#MANZ=		1

# Define MANPS to have PostScript manual pages generated
#MANPS=		1

SHAREDIR?=	/usr/share
SHAREGRP?=	bin
SHAREOWN?=	root
SHAREMODE?=	${NONBINMODE}

MANDIR?=	/usr/share/man/cat
MANGRP?=	bin
MANOWN?=	root
MANMODE?=	${NONBINMODE}

PSDIR?=		/usr/share/man/ps
PSGRP?=		bin
PSOWN?=		root
PSMODE?=	${NONBINMODE}

LIBDIR?=	/usr/lib
LINTLIBDIR?=	/usr/libdata/lint
LIBGRP?=	${BINGRP}
LIBOWN?=	${BINOWN}
LIBMODE?=	${NONBINMODE}

DOCDIR?=        /usr/share/doc
DOCGRP?=	bin
DOCOWN?=	root
DOCMODE?=       ${NONBINMODE}

NLSDIR?=	/usr/share/nls
NLSGRP?=	bin
NLSOWN?=	root
NLSMODE?=	${NONBINMODE}

INSTALL_COPY?=	-c
.ifndef DEBUG
INSTALL_STRIP?=	-s
.endif

# This may be changed for _single filesystem_ configurations (such as
# routers and other embedded systems); normal systems should leave it alone!
STATIC?=	-static

# Define SYS_INCLUDE to indicate whether you want symbolic links to the system
# source (``symlinks''), or a separate copy (``copies''); (latter useful
# in environments where it's not possible to keep /sys publicly readable)
#SYS_INCLUDE= 	symlinks

# don't try to generate PIC versions of libraries on machines
# which don't support PIC.
.if (${MACHINE_ARCH} == "vax") || \
    (${MACHINE_ARCH} == "hppa") || (${MACHINE_ARCH} == "m88k")
NOPIC=
.endif

# don't try to generate PROFILED versions of libraries on machines
# which don't support profiling.
# to add this back use the following line
.if (${MACHINE_ARCH} == "m88k") || (${MACHINE_ARCH} == "sparc64")
#.if 0
NOPROFILE=
.endif

# No lint, for now.
NOLINT=

BSD_OWN_MK=Done

.PHONY: spell clean cleandir obj manpages print all \
	depend beforedepend afterdepend cleandepend \
	all lint cleanman nlsinstall cleannls includes \
	beforeinstall realinstall maninstall afterinstall install
