dnl $Id: a-part-of-sendmail.mc,v 1.2 2010/02/02 11:07:37 ak Exp $

FEATURE(`virtusertable',`hash -o /etc/mail/virtusertable')dnl
VIRTUSER_DOMAIN_FILE(`-o /etc/mail/virtuser-domains')dnl
define(`PROCMAIL_MAILER_PATH',`/usr/local/mda/bin/procmail')dnl

dnl * Other available macros(mailer/virtmail.m4)
dnl
dnl   <MACRO NAME> = <DEFAULT VALUE | OTHER AVAILABLE VALUE>
dnl     VIRTMAIL_MAILER_MAX = <none> | any numerals
dnl     VIRTMAIL_MAILER_USER = virtmail | anyone else
dnl                            ** procmail does not use this value
dnl     VIRTMAIL_MAILER_PATH = /usr/local/bin/maildrop | anything else
dnl     VIRTMAIL_MAILER_TYPE = maildrop | procmail
dnl     VIRTMAIL_MAILER_ARGS = maildrop -f $f -d virtmail $u 
dnl                          = procmail -tY -m $h $f $u
dnl     VIRTMAIL_MAILER_QGRP = <none> | anything else
dnl     VIRTMAIL_MAILER_FLAGS = 91AlnoPSsW
dnl     VIRTMAIL_MAILER_PSEUDOTLD = VIRTMAIL | anything else
dnl     VIRTMAIL_MAILDR_CONFIGDIR = /usr/local/etc/procmailrcs | /path/to/procmailrcs
dnl                                 ** maildrop does not use this value
dnl

dnl A. If you use maildrop as a LDA for virtual mailbox
define(`VIRTMAIL_MAILER_PATH',`/usr/local/mda/bin/maildrop')dnl
define(`VIRTMAIL_MAILER_USER',`virtmail')dnl

dnl B. If you use procmail as a LDA for virtual mailbox
define(`VIRTMAIL_MAILER_PATH',`/usr/local/mda/bin/procmail')dnl
define(`VIRTMAIL_MAILER_CONFIGDIR',`/usr/local/mda/etc/procmailrcs')dnl


MAILER(`local')
MAILER(`smtp')
MAILER(`procmail')
MAILER(`virtmail')

