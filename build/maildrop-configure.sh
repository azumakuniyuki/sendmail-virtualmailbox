# $Id: maildrop-configure,v 1.1 2010/02/02 11:39:49 ak Exp $
./configure \
	--prefix=/usr/local/virtmail \
	--enable-sendmail=/usr/sbin/sendmail \
	--enable-keep-fromline=1 \
	--enable-unicode \
	--with-etcdir=/usr/local/virtmail/etc
