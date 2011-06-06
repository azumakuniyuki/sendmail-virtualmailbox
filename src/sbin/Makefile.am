# $Id: Makefile.am,v 1.12.2.1 2011/03/19 09:41:17 ak Exp $
# This is the auto-Makefile for src/sbin/, is processed by 
# automake to create Makefile.in.
bin_SCRIPTS = make-vmailbox sendmailctl
instdir = @sbindir@

$(bin_SCRIPTS):
	$(CAT) $@.SH | $(SED) \
		-e "s|__SYSTEMNAME__|$(SYSTEMNAME)|g" \
		-e "s|__SYSVERSION__|$(SYSVERSION)|g" \
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
		-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
		-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
		-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@

install-am:
	$(INSTALL) -o root -g root -vpm 0755 $(bin_SCRIPTS) @sbindir@/
	$(LN) -fs @sbindir@/sendmailctl /usr/local/sbin/smctl

.PHONY: clean
clean:
	rm -f $(bin_SCRIPTS)


