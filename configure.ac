dnl #                                               -*- Autoconf -*-
dnl # Process this file with autoconf to produce a configure script.
AC_PREREQ(2.61)
AC_INIT([sendmail-virtualmailbox], [1.1.7], [azumakuniyuki@gmail.com])
AM_INIT_AUTOMAKE([foreign])
AC_PREFIX_DEFAULT(/usr/local/virtmail)
AC_CANONICAL_HOST

BUILDROOT=`pwd`
AC_SUBST(BUILDROOT)

SYSTEMNAME=sendmail-virtualmailbox
SYSVERSION=1.1.7
AC_SUBST(SYSTEMNAME)
AC_SUBST(SYSVERSION)

dnl # Checks for programs.
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PATH_PROG(SHELL, sh, :, /bin:/usr/bin:/usr/local/bin)
if test "x$SHELL" = xno; then
	AC_MSG_ERROR([*** Cannot find sh program])
fi

AC_PROG_LN_S
AC_PATH_PROG(CP, cp, no, /bin:/usr/bin:/usr/local/bin)
if test "x$CP" = xno; then
	AC_MSG_ERROR([*** Cannot find cp program])
fi

AC_PATH_PROG(M4, m4, no, /bin:/usr/bin:/usr/local/bin)
if test "x$M4" = xno; then
	AC_MSG_ERROR([*** Cannot find m4 program])
fi

AC_PATH_PROG(LN, ln, no, /bin:/usr/bin:/usr/local/bin)
if test "x$LN" = xno; then
	AC_MSG_ERROR([*** Cannot find ln program])
fi

AC_PATH_PROG(CAT, cat, no, /bin:/usr/bin:/usr/local/bin)
if test "x$CAT" = xno; then
	AC_MSG_ERROR([*** Cannot find cat program])
fi

AC_PATH_PROG(TAR, tar, no, /bin:/usr/bin:/usr/local/bin)
if test "x$TAR" = xno; then
	AC_MSG_ERROR([*** Cannot find tar program])
fi

AC_PATH_PROG(ECHO, echo, no, /bin:/usr/bin:/usr/local/bin)
if test "x$ECHO" = xno; then
	AC_MSG_ERROR([*** Cannot find echo program])
fi

AC_PATH_PROG(PERL, perl, no, /bin:/usr/bin:/usr/local/bin)
if test "x$PERL" = xno; then
	AC_MSG_ERROR([*** Cannot find perl program])
fi

AC_PATH_PROG(CHMOD, chmod, no, /bin:/usr/bin:/usr/local/bin)
if test "x$CHMOD" = xno; then
	AC_MSG_ERROR([*** Cannot find chmod program])
fi

AC_PATH_PROG(CHOWN, chown, no, /bin:/usr/bin:/usr/local/bin)
if test "x$CHOWN" = xno; then
	AC_MSG_ERROR([*** Cannot find chown program])
fi

AC_PATH_PROG(MKDIR, mkdir, no, /bin:/usr/bin:/usr/local/bin)
if test "x$MKDIR" = xno; then
	AC_MSG_ERROR([*** Cannot find mkdir program])
fi

AC_PATH_PROG(PATCH, patch, no, /bin:/usr/bin:/usr/local/bin)
if test "x$PATCH" = xno; then
	AC_MSG_ERROR([*** Cannot find patch program])
fi

AC_PATH_PROG(STRIP, strip, no, /bin:/usr/bin:/usr/local/bin)
if test "x$STRIP" = xno; then
	AC_MSG_ERROR([*** Cannot find strip program])
fi

AC_PATH_PROG(TOUCH, touch, no, /bin:/usr/bin:/usr/local/bin)
if test "x$TOUCH" = xno; then
	AC_MSG_ERROR([*** Cannot find touch program])
fi

AC_PATH_PROG(GUNZIP, gunzip, no, /bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin)
if test "x$GUNZIP" = xno; then
	AC_MSG_ERROR([*** Cannot find gunzip program])
fi

AC_PATH_PROG(BUNZIP2, bunzip2, no, /bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin)
if test "x$BUNZIP2" = xno; then
	AC_MSG_ERROR([*** Cannot find bunzip2 program])
fi

AC_PATH_PROG(INSTALL, install, no, /bin:/usr/bin:/usr/local/bin)
if test "x$INSTALL" = xno; then
	AC_MSG_ERROR([*** Cannot find install program])
fi

AC_PATH_PROG(USERADD, useradd, no, /bin:/usr/bin:/sbin:/usr/sbin:)
if test "x$USERADD" = xno; then
	AC_MSG_ERROR([*** Cannot find useradd program])
fi

AC_PATH_PROG(GROUPADD, groupadd, no, /bin:/usr/bin:/sbin:/usr/sbin:)
if test "x$GROUPADD" = xno; then
	AC_MSG_ERROR([*** Cannot find groupadd program])
fi

AC_PATH_PROG(BASENAME, basename, no, /bin:/usr/bin:/sbin:/usr/sbin:)
if test "x$BASENAME" = xno; then
	AC_MSG_ERROR([*** Cannot find basename program])
fi

AC_PATH_PROGS(GREP, grep egrep, no, /bin:/usr/bin:/usr/local/bin)
if test "x$GREP" = xno; then
	AC_MSG_ERROR([*** Cannot find grep program(grep, egrep)])
fi

AC_PATH_PROG(FIND, find, no, /bin:/usr/bin:/usr/local/bin)
if test "x$FIND" = xno; then
	AC_MSG_ERROR([*** Cannot find find program])
fi

AC_PATH_PROG(SED, sed, no, /bin:/usr/bin:/usr/local/bin)
if test "x$SED" = xno; then
	AC_MSG_ERROR([*** Cannot find sed program])
fi

AC_PATH_PROG(WGET, wget ftp curl, no, /bin:/usr/bin:/usr/local/bin)
if test "x$WGET" = xno; then
	AC_MSG_ERROR([*** Cannot find wget program])
fi

AC_ARG_WITH([sendmail-user],
	AC_HELP_STRING(
		[--sendmail-user=USER],
		[sendmail run as the user [sendmail]]),
	[SENDMAILUSER=$withval],[SENDMAILUSER=sendmail])
AC_SUBST(SENDMAILUSER)

AC_ARG_WITH([submit-user],
	AC_HELP_STRING(
		[--submit-user=USER],
		[submission run as the user [smsubmit]]),
	[SMSUBMITUSER=$withval],[SMSUBMITUSER=smsubmit])
AC_SUBST(SMSUBMITUSER)

AC_ARG_WITH([virtmail-user],
	AC_HELP_STRING(
		[--virtualmailbox-user=USER],
		[virtual mailbox owner [virtmail]]),
	[VIRTMAILUSER=$withval],[VIRTMAILUSER=virtmail])
AC_SUBST(VIRTMAILUSER)

AC_ARG_WITH([virtmail-home],
	AC_HELP_STRING(
		[--virtualmailbox-home=DIR],
		[virtual mailbox home, [/home/$VIRTMAILUSER]]),
	[VIRTMAILHOME=$withval],[VIRTMAILHOME=/home/$VIRTMAILUSER])
AC_SUBST(VIRTMAILHOME)

#AC_ARG_ENABLE(local-sendmail,
#	AC_HELP_STRING( [--enable-local-sendmail], [Enable local-sendmail(default=no)] ),
#	[enable_localsendmail="$enableval"], [enable_localsendmail="no"])
#	AM_CONDITIONAL([LOCALSENDMAIL], [test "x$enable_localsendmail" = "xyes"])

# Check OS
case $host_os in
	aix3*) targetos=aix3 ;;
	aix4*) targetos=aix4 ;;
	aix5*) targetos=aix5 ;;
	bsdi*) targetos=bsdi ;;
	cygwin*) targetos=cygwin ;;
	darwin*) targetos=darwin ;;
	dgux*) targetos=dgux ;;
	freebsd4*) targetos=freebsd4 ;;
	freebsd5*) targetos=freebsd5 ;;
	freebsd6*) targetos=freebsd6 ;;
	hpux9*) targetos=hpux9 ;;
	hpux10*) targetos=hpux10 ;;
	hpux11*) targetos=hpux11 ;;
	irix4*) targetos=irix4 ;;
	irix5*) targetos=irix5 ;;
	irix6*) targetos=irix6 ;;
	linux*|gnu*|k*bsd*-gnu) targetos=linux ;;
	mingw*) targetos=win32 ;;
	netbsd*) targetos=openbsd;;
	nextstep*) targetos=nextstep ;;
	openbsd*) targetos=openbsd ;;
	osf*) targetos=osf1 ;;
	sco*) targetos=sco3.2 ;;
	solaris2*) targetos=solaris2 ;;
	solaris8*) targetos=solaris8 ;;
	sunos3*) targetos=sunos3.5 ;;
	sunos4*) targetos=sunos4.1 ;;
	ultrix*) targetos=ultrix4 ;;
esac
if test x"$targetos" = x"" ; then
	AC_MSG_ERROR([*** Cannot detect ostype])
fi
TARGET_OSTYPE=$targetos
AC_SUBST(TARGET_OSTYPE)

TARGET_FQDN="`hostname`"
AC_SUBST(TARGET_FQDN)

AC_ARG_WITH([hostname],
	AC_HELP_STRING(
		[--hostname=HOST],
		[hostname for sendmail.cf]),
	[TARGET_HOSTNAME=$withval],[TARGET_HOSTNAME="`hostname | cut -d. -f1`"])
AC_SUBST(TARGET_HOSTNAME)

AC_ARG_WITH([domainname],
	AC_HELP_STRING(
		[--domainname=DOMAIN],
		[domainname for sendmail.cf]),
	[TARGET_DOMAINNAME=$withval],[TARGET_DOMAINNAME="`hostname | cut -d. -f2,3,4,5,6,7,8,9`"])
AC_SUBST(TARGET_DOMAINNAME)


AC_CONFIG_FILES([Makefile
                 build/Makefile
                 src/Makefile
                 src/etc/Makefile
                 src/sbin/Makefile])
AC_OUTPUT

