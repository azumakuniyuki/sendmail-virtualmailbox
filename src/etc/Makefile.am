# $Id: Makefile.am,v 1.12.2.1 2011/03/19 09:41:17 ak Exp $
# This is the auto-Makefile for src/etc/, is processed by 
# automake to create Makefile.in.
sysconf_DATA = procmailrc maildroprc 
sendmail_MAPS = virtusertable access mailertable genericstable authinfo
sendmail_CONF = virtuser-domains relay-domains local-host-names generics-domains \
		masquerade-domains
if ENABLE_SIDMILTER
other_CONF = queue-interval daemon-options sid-peer-hosts sid-pass-domains sid-options
else
other_CONF = queue-interval daemon-options
endif
instdir = @sysconfdir@

all-am: $(sysconf_DATA) etc-makefile $(sendmail_CONF) $(sendmail_MAPS) $(other_CONF)
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
		-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
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

install-am: $(sysconf_DATA) $(sendmail_MAPS) $(sendmail_CONF) $(other_CONF) etc-makefile
	test -d @sysconfdir@ || $(MKDIR) -p @sysconfdir@
	for F in $(sysconf_DATA); do \
		test -s @sysconfdir@/$$F || \
			$(INSTALL) -vpm 0644 -o root -g root $$F $(instdir)/$$F ;\
	done
	for M in $(sendmail_MAPS); do \
		test -s /etc/mail/$$M || \
			$(INSTALL) -vpm 0644 -o root -g root $$M /etc/mail/$$M ;\
	done
	$(CP) etc-makefile /etc/mail/Makefile
	test -d @datarootdir@/example || $(MKDIR) -p @datarootdir@/example
	for M in $(sendmail_MAPS); do \
		test -s /etc/mail/$$M || \
			$(INSTALL) -vpm 0644 -o root -g $(SENDMAILUSER) $$M /etc/mail/$$M ;\
		$(CP) $$M @datarootdir@/example/$$M ;\
	done
	test -s /etc/mail/authinfo && chmod 0600 /etc/mail/authinfo
	for C in $(sendmail_CONF); do \
		test -s /etc/mail/$$C || \
			$(INSTALL) -vpm 0640 -o root -g $(SENDMAILUSER) $$C /etc/mail/$$C ;\
		$(CP) $$C @datarootdir@/example/$$C ;\
	done
	for O in $(other_CONF); do \
		test -s /etc/mail/$$O || \
			$(INSTALL) -vpm 0644 -o root -g $(SENDMAILUSER) $$O /etc/mail/$$O ;\
		$(CP) $$O @datarootdir@/example/$$O ;\
	done

.PHONY: clean
clean:
	rm -f $(sysconf_DATA) etc-Makefile $(sendmail_MAPS) $(sendmail_CONF) $(other_CONF)


