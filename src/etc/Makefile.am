# $Id: Makefile.am,v 1.12.2.1 2011/03/19 09:41:17 ak Exp $
# This is the auto-Makefile for src/etc/, is processed by 
# automake to create Makefile.in.
sysconf_DATA = procmailrc maildroprc virtusertable virtuser-domains \
	       relay-domains local-host-names access mailertable \
	       queue-interval genericstable generics-domains \
	       daemon-options
instdir = @sysconfdir@

all-am: $(sysconf_DATA) etc-makefile
$(sysconf_DATA):
	$(CAT) $@.in | $(SED) \
		-e "s|__TARGET_FQDN__|$(TARGET_FQDN)|g" \
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
		-e 's|\([^:]\)//|\1/|g' > $@

etc-makefile:
	$(CAT) $@.in | $(SED) \
		-e "s|__TARGET_FQDN__|$(TARGET_FQDN)|g" \
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
		-e 's|\([^:]\)//|\1/|g' > $@

install-am: $(sysconf_DATA) etc-makefile
	for F in $(sysconf_DATA); do \
		test -f @sysconfdir@/$$F || \
			$(INSTALL) -vpm 0644 -o root -g root $$F $(instdir)/ ;\
	done
	$(CP) etc-makefile @sysconfdir@/Makefile
	$(CP) virtusertable @datarootdir@/example/

.PHONY: clean
clean:
	rm -f $(sysconf_DATA) etc-Makefile.in


