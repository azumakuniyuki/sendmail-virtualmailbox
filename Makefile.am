### $Id: Makefile.am,v 1.2 2009/04/29 13:53:25 ak Exp $
### Makefile.am -- makefile(GNU) for sendmail-virtualmailbox
SUBDIRS = build src
if LOCALSENDMAIL
LSTATEDIR = @localstatedir@
else
LSTATEDIR = /var
endif

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
	test -d $(LSTATEDIR)/spool/queues || ( \
		$(MKDIR) -pm 0700 $(LSTATEDIR)/spool/queues; \
		$(MKDIR) -pm 0700 $(LSTATEDIR)/spool/queues/q.0 ;\
		$(MKDIR) -pm 0700 $(LSTATEDIR)/spool/queues/q.1 ;\
		$(MKDIR) -pm 0700 $(LSTATEDIR)/spool/queues/q.2 ;\
		$(MKDIR) -pm 0700 $(LSTATEDIR)/spool/queues/q.3 ;\
		$(CHOWN) -R root:root $(LSTATEDIR)/spool/queues ;\
	)

	test -d @localstatedir@/spool/cqueue || ( \
		$(MKDIR) -pm 0770 @localstatedir@/spool/cqueue ;\
		$(CHOWN) -R $(SMSUBMITUSER):$(SMSUBMITUSER) @localstatedir@/spool/cqueue ;\
	)

lstatedirs:
	test -d $(LSTATEDIR)/log || $(MKDIR) -pm 0755 $(LSTATEDIR)/log
	test -d $(LSTATEDIR)/run || $(MKDIR) -pm 0755 $(LSTATEDIR)/run

sendmail-cf:
	cd ./build && $(MAKE) sendmail.cf

install-cf: sendmail-cf
	cd ./build && $(MAKE) install-cf

install-example:
	$(CP) -Rp example/* @datarootdir@/example/

clean-am:
	rm -f ./*~ ./*.bak ./*.tmp ./*.db
	rm -fr ./.temp ./.test

distclean-am: clean-am

message:
	@echo "-----------------------------------------------------------------------------"
	@echo " $(SYSTEMNAME) $(SYSVERSION) "
	@echo "-----------------------------------------------------------------------------"
	@echo
	@echo "  1. Run ``make sendmail-cf && make install-cf'' at current directory or Edit"
	@echo "     sendmail.mc and install sendmail.cf in ./build directory"
	@echo "  2. Edit @sysconfdir@/virtusertable, virtuser-domains, aliases"
	@echo "  3. Run @sbindir@/newaliases"
	@echo "  4. cd @sysconfdir@ && make virtusertable.db"
	@echo "  5. If you use sid-milter, Edit sendmail.mc and run ``make sendmail.cf'' in"
	@echo "     @sysconfdir@, and run ``@bindir@/sidctl start''"
	@echo "  6. @prefix@/sbin/sendmailctl start or /usr/local/sbin/smctl start"
	@echo
	

