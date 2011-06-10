# $Id: maildrop-configure,v 1.1 2010/02/02 11:39:49 ak Exp $
./configure \
	--prefix=__PREFIX__ \
	--bindir=__BINDIR__ \
	--sysconfdir=__SYSCONFDIR__ \
	--localstatedir=__LOCALSTATEDIR__ \
	--enable-sendmail=/usr/sbin/sendmail \
	--enable-keep-fromline=1 \
	--enable-unicode \
	--with-etcdir=__SYSCONFDIR__
