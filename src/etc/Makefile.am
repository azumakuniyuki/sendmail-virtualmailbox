# $Id: Makefile.am,v 1.12.2.1 2011/03/19 09:41:17 ak Exp $
# This is the auto-Makefile for src/etc/, is processed by 
# automake to create Makefile.in.
sysconf_DATA = procmailrc maildroprc 
sendmail_MAPS = virtusertable access mailertable genericstable 
sendmail_CONF = virtuser-domains relay-domains local-host-names generics-domains
other_CONF = queue-interval daemon-options sid-peer-hosts sid-pass-domains sid-options
instdir = @sysconfdir@

all-am: $(sysconf_DATA) etc-makefile $(sendmail_CONF) $(other_CONF)
$(sysconf_DATA):
	$(CAT) $@.in | $(SED) \
		-e "s|__TARGET_FQDN__|$(TARGET_FQDN)|g" \
		-e "s|__TARGET_HOSTNAME__|$(TARGET_HOSTNAME)|g" \
		-e "s|__TARGET_DOMAINNAME__|$(TARGET_DOMAINNAME)|g" \
		-e 's|__BINDIR__|@bindir@|g' \
		-e 's|__SBINDIR__|@sbindir@|g' \
		-e 's|\([^:]\)//|\1/|g' > $@

$(sendmail_MAPS):
	$(CAT) $@.in | $(SED) \
		-e "s|__TARGET_FQDN__|$(TARGET_FQDN)|g" \
		-e "s|__TARGET_HOSTNAME__|$(TARGET_HOSTNAME)|g" \
		-e "s|__TARGET_DOMAINNAME__|$(TARGET_DOMAINNAME)|g" \
		-e 's|__DATAROOTDIR__|@datarootdir@|g' \
		-e "s|__VIRTMAILHOME__|$(VIRTMAILHOME)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@

$(sendmail_CONF):
	$(CAT) $@.in | $(SED) \
		-e "s|__TARGET_FQDN__|$(TARGET_FQDN)|g" \
		-e "s|__TARGET_HOSTNAME__|$(TARGET_HOSTNAME)|g" \
		-e "s|__TARGET_DOMAINNAME__|$(TARGET_DOMAINNAME)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@

$(other_CONF):
	$(CAT) $@.in | $(SED) \
		-e "s|__TARGET_FQDN__|$(TARGET_FQDN)|g" \
		-e "s|__TARGET_HOSTNAME__|$(TARGET_HOSTNAME)|g" \
		-e "s|__TARGET_DOMAINNAME__|$(TARGET_DOMAINNAME)|g" \
		-e 's|__BINDIR__|@bindir@|g' \
		-e 's|__SBINDIR__|@sbindir@|g' \
		-e 's|\([^:]\)//|\1/|g' > $@

etc-makefile:
	$(CAT) $@.in | $(SED) -e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" > $@

install-am: $(sysconf_DATA) $(sendmail_CONF) $(other_CONF)
	test -d @sysconfdir@ || $(MKDIR) -p @sysconfdir@
	for F in $(sysconf_DATA); do \
		test -s @sysconfdir@/$$F || \
			$(INSTALL) -vpm 0644 -o root -g root $$F $(instdir)/$$F ;\
	done
	test -s /etc/mail/Makefile || $(CP) etc-makefile.in /etc/mail/Makefile
	test -d @datarootdir@/example || $(MKDIR) -p @datarootdir@/example
	for F in $(sendmail_CONF); do \
		test -s /etc/mail/$$F || \
			$(INSTALL) -vpm 0640 -o root -g $(SENDMAILUSER) $$F /etc/mail/$$F ;\
		$(CP) $$F.in @datarootdir@/example/$$F ;\
	done

.PHONY: clean
clean:
	rm -f $(sysconf_DATA) etc-Makefile.in $(sendmail_MAPS) $(sendmail_CONF) $(other_CONF)


