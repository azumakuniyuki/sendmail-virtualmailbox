dnl #                                               -*- Autoconf -*-
dnl # Process this file with autoconf to produce a configure script.
AC_PREREQ(2.61)
AC_INIT([sendmail-virtualmailbox], [1.1.5], [azumakuniyuki@gmail.com])
AM_INIT_AUTOMAKE([foreign])
AC_PREFIX_DEFAULT(/usr/local/virtmail)
AC_CANONICAL_HOST

BUILDROOT=`pwd`
AC_SUBST(BUILDROOT)

SYSTEMNAME=sendmail-virtualmailbox
SYSVERSION=1.1.5
AC_SUBST(SYSTEMNAME)
AC_SUBST(SYSVERSION)

dnl # Checks for programs.
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PATH_PROG(SHELL, sh, :, /bin:/usr/bin:/usr/local/bin)

AC_PROG_LN_S
AC_PATH_PROG(CP, cp, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(M4, m4, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(LN, ln, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(CAT, cat, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(TAR, tar, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(ECHO, echo, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(PERL, perl, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(CHMOD, chmod, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(CHOWN, chown, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(MKDIR, mkdir, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(PATCH, patch, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(STRIP, strip, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(TOUCH, touch, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(GUNZIP, gunzip, :, /bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin)
AC_PATH_PROG(BUNZIP2, bunzip2, :, /bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin)
AC_PATH_PROG(INSTALL, install, :, /bin:/usr/bin:/usr/local/bin)
AC_PATH_PROG(USERADD, useradd, :, /bin:/usr/bin:/sbin:/usr/sbin:)
AC_PATH_PROG(GROUPADD, groupadd, :, /bin:/usr/bin:/sbin:/usr/sbin:)
AC_PATH_PROG(BASENAME, basename, :, /bin:/usr/bin:/sbin:/usr/sbin:)

AC_PATH_PROGS(GREP, grep egrep, :, /bin:/usr/bin:/usr/local/bin)
if test "x$GREP" = x; then
	AC_MSG_ERROR([*** Cannot find grep program(grep, egrep)])
fi

AC_PATH_PROG(FIND, find, :, /bin:/usr/bin:/usr/local/bin)
if test "x$FIND" = x; then
	AC_MSG_ERROR([*** Cannot find find program])
fi

AC_PATH_PROG(SED, sed, :, /bin:/usr/bin:/usr/local/bin)
if test "x$SED" = x; then
	AC_MSG_ERROR([*** Cannot find sed program])
fi

AC_PATH_PROG(WGET, wget ftp curl, :, /bin:/usr/bin:/usr/local/bin)
if test "x$WGET" = x; then
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

