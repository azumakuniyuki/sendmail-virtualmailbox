# $Id: Makefile.am,v 1.12.2.1 2011/03/19 09:41:17 ak Exp $
# This is the auto-Makefile for src/sbin/, is processed by 
# automake to create Makefile.in.
bin_SCRIPTS = make-vmailbox sendmailctl sidctl
instdir = @sbindir@

$(bin_SCRIPTS):
	$(CAT) $@.SH | $(SED) \
		-e "s|__SYSVERSION__|$(SYSVERSION)|g" \
		-e "s|__SMSUBMITUSER__|$(SMSUBMITUSER)|g" \
		-e "s|__SENDMAILUSER__|$(SENDMAILUSER)|g" \
		-e "s|__VIRTMAILUSER__|$(VIRTMAILUSER)|g" \
		-e "s|__VIRTMAILHOME__|$(VIRTMAILHOME)|g" \
		-e 's|\([^:]\)//|\1/|g' > $@

install-am:
	test -d @sbindir@ || $(MKDIR) -p @sbindir@
	$(INSTALL) -o root -g root -vpm 0755 $(bin_SCRIPTS) @sbindir@/
	test -e /usr/local/sbin/smctl || \
		$(LN) -fs @sbindir@/sendmailctl /usr/local/sbin/smctl

.PHONY: clean
clean:
	rm -f $(bin_SCRIPTS)


