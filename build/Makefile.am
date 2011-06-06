### $Id: Makefile.am,v 1.2 2009/04/29 13:53:25 ak Exp $
### Makefile.am -- makefile(GNU) for sendmail-virtualmailbox/build
SM_VERSION = 8.14.5
PM_VERSION = 3.22
MD_VERSION = 2.5.3

SM_ARCHIVE = sendmail.$(SM_VERSION).tar.gz
PM_ARCHIVE = procmail-$(PM_VERSION).tar.gz
MD_ARCHIVE = maildrop-$(MD_VERSION).tar.gz

SM_DISTDIR = sendmail-$(SM_VERSION)
PM_DISTDIR = procmail-$(PM_VERSION)
MD_DISTDIR = maildrop-$(MD_VERSION)

SM_DISTURL = ftp://ftp.sendmail.org/pub/sendmail/$(SM_ARCHIVE)
#PM_DISTURL = ftp://ftp.ring.gr.jp/pub/net/mail/procmail/$(PM_ARCHIVE)
#SM_DISTURL = http://dl.dropbox.com/u/8413459/$(SM_ARCHIVE)
PM_DISTURL = http://dl.dropbox.com/u/8413459/$(PM_ARCHIVE)
MD_DISTURL = http://dl.dropbox.com/u/8413459/$(MD_ARCHIVE)
SM_MAILDIR = /$(shell $(BASENAME) @sysconfdir@)

all-am: procmail maildrop sendmail
install-am: install-procmail install-maildrop install-sendmail

procmail: get-procmail build-procmail
maildrop: get-maildrop build-maildrop
sendmail: get-sendmail build-sendmail build-sendmail-cf

get-procmail: $(PM_DISTDIR)
$(PM_DISTDIR):
	mkdir -p archive/
	test -f archive/$(PM_ARCHIVE) && $(CP) archive/$(PM_ARCHIVE) . || $(WGET) $(PM_DISTURL)
	test -f $(PM_ARCHIVE)
	$(CP) $(PM_ARCHIVE) ./archive/
	$(GUNZIP) -dc $(PM_ARCHIVE) | $(TAR) xf -

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
	$(STRIP) @libexecdir@/formail
	$(STRIP) @libexecdir@/lockfile
	$(STRIP) @libexecdir@/procmail

	test -d @sysconfdir@/rc || $(MKDIR) -p @sysconfdir@/rc
	test -d @localstatedir@/log || $(MKDIR) -p @localstatedir@/log

	if [ -f @localstatedir@/log/procmail-local.log ]; then \
		true ;\
	else \
		$(TOUCH) @localstatedir@/log/procmail-local.log ;\
		$(CHMOD) 0600 @localstatedir@/log/procmail-local.log ;\
	fi

get-maildrop: $(MD_DISTDIR)
$(MD_DISTDIR):
	mkdir -p archive/
	test -f archive/$(MD_ARCHIVE) && $(CP) archive/$(MD_ARCHIVE) . || $(WGET) $(MD_DISTURL)
	test -f $(MD_ARCHIVE)
	$(CP) $(MD_ARCHIVE) ./archive/
	$(GUNZIP) -dc $(MD_ARCHIVE) | $(TAR) xf -

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

	test -d @sysconfdir@/rc || $(MKDIR) -p @sysconfdir@/rc
	test -d @localstatedir@/log || $(MKDIR) -p @localstatedir@/log

	if [ -f @localstatedir@/log/maildrop-virtual.log ]; then \
		true ;\
	else \
		$(TOUCH) @localstatedir@/log/maildrop-virtual.log ;\
		$(CHOWN) $(VIRTMAILUSER):root @localstatedir@/log/maildrop-virtual.log ;\
		$(CHMOD) 0600 @localstatedir@/log/maildrop-virtual.log ;\
	fi

get-sendmail: $(SM_DISTDIR)
$(SM_DISTDIR):
	mkdir -p archive/
	test -f archive/$(SM_ARCHIVE) && $(CP) archive/$(SM_ARCHIVE) . || $(WGET) $(SM_DISTURL)
	test -f $(SM_ARCHIVE)
	$(CP) $(SM_ARCHIVE) ./archive
	$(GUNZIP) -dc $(SM_ARCHIVE) | $(TAR) xf -

check-sendmail-user:
	id $(SENDMAILUSER)
	id $(SMSUBMITUSER)

build-sendmail: $(SM_DISTDIR) check-sendmail-user
	if [ -f "./sendmail-build-ok" ]; then \
		true ;\
	else \
		$(CAT) sendmail-site.config.m4 | $(SED) \
			-e 's|__PREFIX__|@prefix@|g' \
			-e 's|__SYSCONFDIR__|@sysconfdir@|g' \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e 's|__LIBEXECDIR__|@libexecdir@|g' \
			-e 's|__BINDIR__|@bindir@|g' \
			-e 's|__SBINDIR__|@sbindir@|g' \
			-e 's|__LOCALSTATEDIR__|@localstatedir@|g' \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
			-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
			-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
			-e 's|\([^:]\)//|\1/|g' > site.config.m4 ;\
		$(CP) site.config.m4 $(SM_DISTDIR)/devtools/Site/ ;\
		$(CAT) submit-mc.in | $(SED) \
			-e 's|__LOCALSTATEDIR__|@localstatedir@|g' \
			-e 's|__DATAROOTDIR__|@datarootdir@|g' \
			-e 's|\([^:]\)//|\1/|g' > $(SM_DISTDIR)/cf/cf/submit.mc ;\
		cd $(SM_DISTDIR) && ( \
			$(PERL) -i -pe "s|^MAILDIR=.*|MAILDIR=$(SM_MAILDIR)|" cf/cf/Makefile && \
			/bin/sh ./Build -c DESTDIR=@prefix@ \
		) ;\
	fi

build-sendmail-cf: $(SM_DISTDIR) sendmail.mc virtmail.m4 sendmail.cf

sendmail.mc:
	$(CAT) sendmail-mc.in | $(SED) \
		-e "s|__TARGET_OSTYPE__|$(TARGET_OSTYPE)|g" \
		-e "s|__TARGET_HOSTNAME__|$(TARGET_HOSTNAME)|g" \
		-e "s|__TARGET_DOMAINNAME__|$(TARGET_DOMAINNAME)|g" \
		-e 's|__PREFIX__|@prefix@|g' \
		-e 's|__SYSCONFDIR__|@sysconfdir@|g' \
		-e 's|__DATAROOTDIR__|@datarootdir@|g' \
		-e 's|__LIBEXECDIR__|@libexecdir@|g' \
		-e 's|__BINDIR__|@bindir@|g' \
		-e 's|__SBINDIR__|@sbindir@|g' \
		-e 's|__LOCALSTATEDIR__|@localstatedir@|g' \
		-e 's|__DATAROOTDIR__|@datarootdir@|g' \
		-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
		-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
		-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@
	$(CP) sendmail.mc $(SM_DISTDIR)/cf/cf/$(TARGET_FQDN).mc

virtmail.m4:
	$(CAT) $@.in | $(SED) \
		-e 's|__PREFIX__|@prefix@|g' \
		-e 's|__SYSCONFDIR__|@sysconfdir@|g' \
		-e 's|__DATAROOTDIR__|@datarootdir@|g' \
		-e 's|__LIBEXECDIR__|@libexecdir@|g' \
		-e 's|__BINDIR__|@bindir@|g' \
		-e 's|__SBINDIR__|@sbindir@|g' \
		-e 's|__LOCALSTATEDIR__|@localstatedir@|g' \
		-e 's|__DATAROOTDIR__|@datarootdir@|g' \
		-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
		-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
		-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@

sendmail.cf: $(SM_DISTDIR) sendmail.mc virtmail.m4
	$(CP) virtmail.m4 $(SM_DISTDIR)/cf/mailer/
	$(M4) $(SM_DISTDIR)/cf/m4/cf.m4 sendmail.mc > $@
	$(CP) sendmail.cf $(SM_DISTDIR)/cf/cf/$(TARGET_FQDN).cf

install-sendmail: $(SM_DISTDIR)
	$(MKDIR) -p @prefix@
	$(MKDIR) -p @sysconfdir@
	$(MKDIR) -p @datarootdir@
	$(MKDIR) -p @datarootdir@/data
	$(MKDIR) -p @datarootdir@/example
	$(MKDIR) -p @libexecdir@
	$(MKDIR) -p @bindir@
	$(MKDIR) -p @sbindir@
	$(MKDIR) -p @localstatedir@
	$(MKDIR) -p @localstatedir@/hoststat
	$(MKDIR) -p @localstatedir@/tmp
	$(MKDIR) -p @prefix@/include
	$(MKDIR) -p @localstatedir@/adm/sm.bin
	cd $(SM_DISTDIR) && ( /bin/sh ./Build install DESTDIR=@prefix@ )

	test -f @sbindir@/sm-mta || $(LN) -s @sbindir@/sendmail @sbindir@/sm-mta
	for L in newaliases hoststat purgestat mailq; do \
		$(LN) -fs @sbindir@/sendmail @bindir@/$$L; \
	done
	test -f @sysconfdir@/aliases || \
		$(INSTALL) -o root -g root -vpm 0644 $(SM_DISTDIR)/sendmail/aliases @sysconfdir@/
	$(CP) -Rp $(SM_DISTDIR)/cf @datarootdir@/cf

install-cf: sendmail.cf
	$(INSTALL) -vpm 0644 -g root -o root sendmail.mc @sysconfdir@/
	$(INSTALL) -vpm 0644 -g root -o root sendmail.cf @sysconfdir@/
	$(INSTALL) -vpm 0644 -g root -o root $(SM_DISTDIR)/cf/cf/submit.mc @sysconfdir@/
	$(INSTALL) -vpm 0644 -g root -o root $(SM_DISTDIR)/cf/cf/submit.cf @sysconfdir@/

.PHONY: clean
clean-am:

	rm -rf $(PM_DISTDIR)
	rm -rf $(MD_DISTDIR)
	rm -rf $(SM_DISTDIR)
	rm -f ./procmail-localconfig.patch
	rm -f ./maildrop-configure
	rm -f ./site.config.m4
	rm -f ./virtmail.m4

distclean: clean

	rm -f $(PM_ARCHIVE)
	rm -f $(MD_ARCHIVE)
	rm -f $(SM_ARCHIVE)
	rm -f ./*-ok
	rm -fr ./archive/*

