### $Id: Makefile.am,v 1.2 2009/04/29 13:53:25 ak Exp $
### Makefile.am -- makefile(GNU) for sendmail-virtualmailbox
SUBDIRS = build src
.PHONY: clean
all-am: Makefile
install-am: maildirs queuedirs install-example message

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
		$(MKDIR) -pm 0700 /var/spool/queues; \
		$(MKDIR) -pm 0700 /var/spool/queues/q.0 ;\
		$(MKDIR) -pm 0700 /var/spool/queues/q.1 ;\
		$(MKDIR) -pm 0700 /var/spool/queues/q.2 ;\
		$(MKDIR) -pm 0700 /var/spool/queues/q.3 ;\
		$(CHOWN) -R root:$(SENDMAILUSER) /var/spool/queues ;\
	)

	test -d @localstatedir@/spool/cqueue || ( \
		$(MKDIR) -pm 0770 /var/spool/cqueue ;\
		$(CHOWN) -R $(SMSUBMITUSER):$(SMSUBMITUSER) /var/spool/cqueue ;\
	)

	test -d /usr/adm/sm.bin || $(MKDIR) -pm 0751 /usr/adm/sm.bin

sendmail-cf:
	cd ./build && $(MAKE) sendmail.cf

install-cf: sendmail-cf
	cd ./build && $(MAKE) install-cf

install-example:
	test -d @datarootdir@/example || $(MKDIR) -p @datarootdir@/example
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
	@echo "  2. Edit /etc/mail/virtusertable, virtuser-domains, aliases"
	@echo "  3. Run newaliases"
	@echo "  4. cd /etc/mail && make virtusertable.db"
	@echo "  5. If you use sid-milter, Edit sendmail.mc and run ``make sendmail.cf'' in"
	@echo "     /etc/mail, and run ``/usr/local/sbin/sidctl start''"
	@echo "  6. /usr/local/sbin/sendmailctl start or /usr/local/sbin/smctl start"
	@echo
	

