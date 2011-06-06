### $Id: Makefile.am,v 1.2 2009/04/29 13:53:25 ak Exp $
### Makefile.am -- makefile(GNU) for sendmail-virtualmailbox
SUBDIRS = build src
.PHONY: clean
all-am: Makefile
install-am: maildirs lstatedirs queuedirs install-example message

maildirs:
	test -d /root/Maildir || ( \
		$(MKDIR) -pm 0700 /root/Maildir/cur; \
		$(MKDIR) -pm 0700 /root/Maildir/new; \
		$(MKDIR) -pm 0700 /root/Maildir/tmp; \
	)
	test -d /etc/skel/Maildir || ( \
		$(MKDIR) -pm 0700 /etc/skel/Maildir/cur; \
		$(MKDIR) -pm 0700 /etc/skel/Maildir/new; \
		$(MKDIR) -pm 0700 /etc/skel/Maildir/tmp; \
	)

queuedirs:
	test -d @localstatedir@/spool/mqueue || ( \
		$(MKDIR) -pm 0700 @localstatedir@/spool/mqueue; \
		$(MKDIR) -pm 0700 @localstatedir@/spool/mqueue/q.0 ;\
		$(MKDIR) -pm 0700 @localstatedir@/spool/mqueue/q.1 ;\
		$(MKDIR) -pm 0700 @localstatedir@/spool/mqueue/q.2 ;\
		$(MKDIR) -pm 0700 @localstatedir@/spool/mqueue/q.3 ;\
		$(CHOWN) -R root:root @localstatedir@/spool/mqueue ;\
	)

	test -d @localstatedir@/spool/cqueue || ( \
		$(MKDIR) -pm 0770 @localstatedir@/spool/cqueue ;\
		$(CHOWN) -R $(SMSUBMITUSER):$(SMSUBMITUSER) @localstatedir@/spool/cqueue ;\
	)

lstatedirs:
	$(MKDIR) -pm 0755 @localstatedir@/log
	$(MKDIR) -pm 0755 @localstatedir@/run
	$(MKDIR) -pm 0755 @localstatedir@/tmp
	$(MKDIR) -pm 0755 @localstatedir@/hoststat
	$(MKDIR) -pm 0755 @localstatedir@/adm/sm.bin

sendmail-cf:
	cd ./build && $(MAKE) sendmail.cf

install-cf: sendmail-cf
	cd ./build && $(MAKE) install-cf

install-example:
	$(CP) example/* @datarootdir@/example/

clean-am:
	rm -f ./*~ ./*.bak ./*.tmp ./*.db
	rm -fr ./.temp ./.test

distclean-am: clean-am

message:
	@echo "-----------------------------------------------------------------------------"
	@echo " $(SYSTEMNAME) $(SYSVERSION) "
	@echo "-----------------------------------------------------------------------------"
	@echo
	@echo "  1. Run ``make sendmail-cf install-cf'' or Edit sendmail.mc and install "
	@echo "     sendmail.cf in ./build directory"
	@echo "  2. Edit @sysconfdir@/virtusertable, virtuser-domains, aliases"
	@echo "  3. Run @sbindir@/newaliases"
	@echo "  4. cd @sysconfdir@ && make virtusertable.db"
	@echo "  5. cd @sysconfdir@ && make start"
	@echo "  6. export PATH=\"@sbindir@:@bindir@:${PATH}\""
	@echo
	

