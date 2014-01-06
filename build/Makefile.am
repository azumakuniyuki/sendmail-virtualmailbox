### $Id: Makefile.am,v 1.2 2009/04/29 13:53:25 ak Exp $
### Makefile.am -- makefile(GNU) for sendmail-virtualmailbox/build
SM_VERSION = 8.14.7
PM_VERSION = 3.22
MD_VERSION = 2.7.1
SI_VERSION = 1.0.0

SM_ARCHIVE = sendmail.$(SM_VERSION).tar.gz
PM_ARCHIVE = procmail-$(PM_VERSION).tar.gz
MD_ARCHIVE = maildrop-$(MD_VERSION).tar.gz
SI_ARCHIVE = sid-milter-$(SI_VERSION).tar.gz

SM_DISTDIR = sendmail-$(SM_VERSION)
PM_DISTDIR = procmail-$(PM_VERSION)
MD_DISTDIR = maildrop-$(MD_VERSION)
SI_DISTDIR = sid-milter-$(SI_VERSION)

#SM_DISTURL = ftp://ftp.sendmail.org/pub/sendmail/$(SM_ARCHIVE)
#PM_DISTURL = ftp://ftp.ring.gr.jp/pub/net/mail/procmail/$(PM_ARCHIVE)
SM_DISTURL = http://dl.dropbox.com/u/8413459/$(SM_ARCHIVE)
PM_DISTURL = http://dl.dropbox.com/u/8413459/$(PM_ARCHIVE)
MD_DISTURL = http://dl.dropbox.com/u/8413459/$(MD_ARCHIVE)
SI_DISTURL = http://dl.dropbox.com/u/8413459/$(SI_ARCHIVE)

if ENABLE_SIDMILTER
all-am: procmail maildrop sendmail sid-milter
install-am: install-procmail install-maildrop install-sendmail install-sid-milter
else
all-am: procmail maildrop sendmail 
install-am: install-procmail install-maildrop install-sendmail
endif

procmail: get-procmail build-procmail
maildrop: get-maildrop build-maildrop
sendmail: get-sendmail build-sendmail build-sendmail-cf
sid-milter: get-sid-milter build-sid-milter

get-procmail: $(PM_DISTDIR)
$(PM_DISTDIR):
	mkdir -p archive/
	test -f archive/$(PM_ARCHIVE) && $(CP) archive/$(PM_ARCHIVE) . || $(WGET) $(PM_DISTURL)
	test -f $(PM_ARCHIVE)
	$(CP) $(PM_ARCHIVE) ./archive/
	$(GUNZIP) -c $(PM_ARCHIVE) | $(TAR) xf -

patch-procmail: $(PM_DISTDIR)
	if [ -f "./procmail-patch-ok" ]; then \
		true ;\
	else \
		$(CAT) procmail-localconfig.diff | $(SED) \
			-e 's|__PREFIX__|@prefix@|g' \
			-e 's|__SYSCONFDIR__|@sysconfdir@|g' \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e 's|__LIBEXECDIR__|@libexecdir@|g' \
			-e 's|__BINDIR__|@bindir@|g' \
			-e 's|__SBINDIR__|@sbindir@|g' \
			-e 's|__LOCALSTATEDIR__|@localstatedir@|g' \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e 's|\([^:]\)//|\1/|g' > procmail-localconfig.patch ;\
		cd $(PM_DISTDIR) && ( \
			$(PATCH) -p0 < $(BUILDROOT)/build/procmail-localconfig.patch && \
			$(PATCH) -p0 < $(BUILDROOT)/build/procmail-conflict-types-for-getline.patch && \
			$(TOUCH) $(BUILDROOT)/build/procmail-patch-ok \
		) \
	fi

build-procmail: $(PM_DISTDIR) patch-procmail
	if [ -f "./procmail-build-ok" ]; then \
		true ;\
	else \
		cd $(PM_DISTDIR) && $(MAKE) ;\
		$(TOUCH) $(BUILDROOT)/build/procmail-build-ok ;\
	fi

install-procmail: build-procmail
	cd $(PM_DISTDIR) && $(MAKE) install
	$(STRIP) @bindir@/formail
	$(STRIP) @bindir@/lockfile
	$(STRIP) @bindir@/procmail

	test -d @sysconfdir@/rcs || $(MKDIR) -p @sysconfdir@/rcs

	if [ -f /var/log/procmail-local.log ]; then \
		true ;\
	else \
		$(TOUCH) /var/log/procmail-local.log ;\
		$(CHMOD) 0600 /var/log/procmail-local.log ;\
	fi

get-maildrop: $(MD_DISTDIR)
$(MD_DISTDIR):
	mkdir -p archive/
	test -f archive/$(MD_ARCHIVE) && $(CP) archive/$(MD_ARCHIVE) . || $(WGET) $(MD_DISTURL)
	test -f $(MD_ARCHIVE)
	$(CP) $(MD_ARCHIVE) ./archive/
	$(GUNZIP) -c $(MD_ARCHIVE) | $(TAR) xf -

build-maildrop: $(MD_DISTDIR)
	if [ -f "./maildrop-build-ok" ]; then \
		true ;\
	else \
		$(CAT) maildrop-configure.sh | $(SED) \
			-e 's|__PREFIX__|@prefix@|g' \
			-e 's|__SYSCONFDIR__|@sysconfdir@|g' \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e 's|__LIBEXECDIR__|@libexecdir@|g' \
			-e 's|__BINDIR__|@bindir@|g' \
			-e 's|__SBINDIR__|@sbindir@|g' \
			-e 's|__LOCALSTATEDIR__|@localstatedir@|g' \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e 's|\([^:]\)//|\1/|g' > maildrop-configure ;\
		cd $(MD_DISTDIR) && ( /bin/sh $(BUILDROOT)/build/maildrop-configure && $(MAKE) ) ;\
		$(TOUCH) $(BUILDROOT)/build/maildrop-build-ok ;\
	fi

check-virtmail-user:
	id $(VIRTMAILUSER)

install-maildrop: check-virtmail-user build-maildrop
	cd $(MD_DISTDIR) && $(MAKE) install-strip
	$(CHOWN) root.$(SENDMAILUSER) @bindir@/lockmail @bindir@/maildrop

	test -d @sysconfdir@/rcs || $(MKDIR) -p @sysconfdir@/rcs
	if [ -f /var/log/maildrop-virtual.log ]; then \
		true ;\
	else \
		$(TOUCH) /var/log/maildrop-virtual.log ;\
		$(CHOWN) $(VIRTMAILUSER):root /var/log/maildrop-virtual.log ;\
		$(CHMOD) 0600 /var/log/maildrop-virtual.log ;\
	fi

get-sendmail: $(SM_DISTDIR)
$(SM_DISTDIR):
	mkdir -p archive/
	test -f archive/$(SM_ARCHIVE) && $(CP) archive/$(SM_ARCHIVE) . || $(WGET) $(SM_DISTURL)
	test -f $(SM_ARCHIVE)
	$(CP) $(SM_ARCHIVE) ./archive
	$(GUNZIP) -c $(SM_ARCHIVE) | $(TAR) xf -

check-sendmail-user:
	id $(SENDMAILUSER)
	id $(SMSUBMITUSER)

build-sendmail: $(SM_DISTDIR) check-sendmail-user
	if [ -f "./sendmail-build-ok" ]; then \
		true ;\
	else \
		$(CAT) sendmail-site.config.m4 | $(SED) \
			-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
			-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
			-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e 's|\([^:]\)//|\1/|g' > site.config.m4 ;\
		$(CP) site.config.m4 $(SM_DISTDIR)/devtools/Site/ ;\
		cd $(SM_DISTDIR) && ( \
			/bin/sh ./Build -c && \
			cd ./libmilter && /bin/sh ./Build -c && \
			$(TOUCH) $(BUILDROOT)/build/sendmail-build-ok ;\
		) ;\
	fi

build-sendmail-cf: $(SM_DISTDIR) sendmail.mc virtmail.m4 sendmail.cf

sendmail.mc:
	$(CAT) sendmail-mc.in | $(SED) \
		-e "s|__TARGET_OSTYPE__|$(TARGET_OSTYPE)|g" \
		-e "s|__TARGET_HOSTNAME__|$(TARGET_HOSTNAME)|g" \
		-e "s|__TARGET_DOMAINNAME__|$(TARGET_DOMAINNAME)|g" \
		-e 's|__PREFIX__|@prefix@|g' \
		-e 's|__BINDIR__|@bindir@|g' \
		-e 's|__SBINDIR__|@sbindir@|g' \
		-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
		-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
		-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@
	$(CP) sendmail.mc $(SM_DISTDIR)/cf/cf/$(TARGET_FQDN).mc
	$(CAT) submit-mc.in | $(SED) \
		-e 's|__LOCALSTATEDIR__|@localstatedir@|g' \
		-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
		-e 's|\([^:]\)//|\1/|g' > submit.mc
	$(CP) submit.mc $(SM_DISTDIR)/cf/cf/submit.mc

virtmail.m4:
	$(CAT) $@.in | $(SED) \
		-e "s|__SYSCONFDIR__|@sysconfdir@|g" \
		-e 's|__BINDIR__|@bindir@|g' \
		-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
		-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
		-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@

sendmail.cf: $(SM_DISTDIR) sendmail.mc virtmail.m4
	$(CP) virtmail.m4 $(SM_DISTDIR)/cf/mailer/
	$(M4) $(SM_DISTDIR)/cf/m4/cf.m4 sendmail.mc > $@
	$(ECHO) '### sendmail.mc ###' >> $@
	$(SED) -e 's|^|# |' sendmail.mc >> $@
	test -f $(SM_DISTDIR)/cf/cf/$(TARGET_FQDN).cf || \
		$(CP) sendmail.cf $(SM_DISTDIR)/cf/cf/$(TARGET_FQDN).cf
	$(M4) $(SM_DISTDIR)/cf/m4/cf.m4 submit.mc > submit.cf
	$(ECHO) '### submit.mc ###' >> submit.cf
	$(SED) -e 's|^|# |' submit.mc >> submit.cf

install-sendmail: $(SM_DISTDIR)
	cd $(SM_DISTDIR) && ( /bin/sh ./Build install )
	cd $(SM_DISTDIR)/libmilter && /bin/sh ./Build install
	test -d /var/spool/hoststat || $(MKDIR) -p /var/spool/hoststat
	test -e /usr/sbin/smtpd || $(LN) -s /usr/sbin/sendmail /usr/sbin/smtpd
	test -f /etc/mail/aliases || \
		$(INSTALL) -o root -g $(SENDMAILUSER) -vpm 0640 $(SM_DISTDIR)/sendmail/aliases /etc/mail/
	test -d @datarootdir@/example || $(MKDIR) -p @datarootdir@/example
	$(CP) $(SM_DISTDIR)/sendmail/aliases @datarootdir@/example/
	$(CP) -Rp $(SM_DISTDIR)/cf /etc/mail/
	$(CHOWN) -R root.root /etc/mail/cf
	$(CP) -Rp $(SM_DISTDIR)/include/* /usr/local/include/

install-cf: sendmail.cf
	for CF in sendmail.cf sendmail.mc submit.cf submit.mc; do \
		test -f /etc/mail/$$CF && $(CP) /etc/mail/$$CF /etc/mail/$$CF.bak ;\
		$(INSTALL) -vpm 0444 -o root -g $(SENDMAILUSER) $$CF /etc/mail/ ;\
	done

get-sid-milter: $(SI_DISTDIR)
$(SI_DISTDIR):
	mkdir -p archive/
	test -f archive/$(SI_ARCHIVE) && $(CP) archive/$(SI_ARCHIVE) . || $(WGET) $(SI_DISTURL)
	test -f $(SI_ARCHIVE)
	$(CP) $(SI_ARCHIVE) ./archive
	$(GUNZIP) -c $(SI_ARCHIVE) | $(TAR) xf -

patch-sid-milter: $(SI_DISTDIR)
	if [ -f "./sid-milter-patch-ok" ]; then \
		true ;\
	else \
		$(CAT) sid-milter-localconfig.diff | $(SED) \
			-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
			-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
			-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
			-e 's|\([^:]\)//|\1/|g' > sid-milter-localconfig.patch ;\
		cd $(SI_DISTDIR) && ( \
			$(PATCH) -p0 < $(BUILDROOT)/build/sid-milter-localconfig.patch && \
			$(TOUCH) $(BUILDROOT)/build/sid-milter-patch-ok \
		) \
	fi

build-sid-milter: $(SI_DISTDIR) patch-sid-milter
	if [ -f "./sid-milter-build-ok" ]; then \
		true ;\
	else \
		cd $(SI_DISTDIR) && /bin/sh ./Build -c ;\
		$(TOUCH) $(BUILDROOT)/build/sid-milter-build-ok ;\
	fi

install-sid-milter: build-sid-milter
	for S in 1 2 3 4 5 6 7 8; do \
		test -d /usr/local/share/man/man$$S || $(MKDIR) -p /usr/local/share/man/man$$S ;\
	done
	cd $(SI_DISTDIR) && /bin/sh ./Build install
	$(LN) -fs /usr/local/bin/sid-filter @bindir@/sid-filter

.PHONY: clean
clean-am:
	rm -rf $(PM_DISTDIR)
	rm -rf $(MD_DISTDIR)
	rm -rf $(SM_DISTDIR)
	rm -rf $(SI_DISTDIR)
	rm -f ./procmail-localconfig.patch
	rm -f ./sid-milter-localconfig.patch
	rm -f ./maildrop-configure
	rm -f ./site.config.m4
	rm -f ./virtmail.m4

distclean: clean
	rm -f $(PM_ARCHIVE)
	rm -f $(MD_ARCHIVE)
	rm -f $(SM_ARCHIVE)
	rm -f $(SI_ARCHIVE)
	rm -f ./*-ok
	rm -fr ./archive/*

