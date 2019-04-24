From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 14:49:41 -0700
Subject: [PATCH 1/2] spec, Makefile: add /etc/nvme files to package files
Message-ID: <20190424214942.11288-1-sagi@grimberg.me>

This way it can automatically be removed upon uninstallation
and we don't need %preun target. Also, this will also allow
to get these files on manual installation from sources.

Also, don't settle on the "file exists" check, use the '-s'
to check that it is not empty as well.

Lastly, in order to have hostnqn and hostid updated upon pkg
install, we have install-spec target that would omit hostnqn and
hostid files, and let the rpm %post do it (otherwise we
use the normal install target).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 Makefile     | 16 +++++++++++++++-
 nvme.spec.in | 25 +++++++++----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 25c65ab09d67..02299c45734f 100644
--- a/Makefile
+++ b/Makefile
@@ -90,7 +90,21 @@ install-zsh-completion:
 	$(INSTALL) -d $(DESTDIR)$(PREFIX)/share/zsh/site-functions
 	$(INSTALL) -m 644 -T ./completions/_nvme $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_nvme
 
-install: install-bin install-man install-bash-completion install-zsh-completion
+install-hostparams:
+	if [ ! -s $(DESTDIR)$(SYSCONFDIR)/nvme/hostnqn ]; then \
+		echo `$(DESTDIR)$(SBINDIR)/nvme gen-hostnqn` > $(DESTDIR)$(SYSCONFDIR)/nvme/hostnqn; \
+	fi
+	if [ ! -s $(DESTDIR)$(SYSCONFDIR)/nvme/hostid ]; then \
+		uuidgen > $(DESTDIR)$(SYSCONFDIR)/nvme/hostid; \
+	fi
+
+install-etc:
+	$(INSTALL) -d $(DESTDIR)$(SYSCONFDIR)/nvme
+	touch $(DESTDIR)$(SYSCONFDIR)/nvme/hostnqn
+	touch $(DESTDIR)$(SYSCONFDIR)/nvme/hostid
+
+install-spec: install-bin install-man install-bash-completion install-zsh-completion install-etc
+install: install-spec install-hostparams
 
 nvme.spec: nvme.spec.in NVME-VERSION-FILE
 	sed -e 's/@@VERSION@@/$(NVME_VERSION)/g' < $< > $@+
diff --git a/nvme.spec.in b/nvme.spec.in
index c16d0ec0645b..147b64a530f8 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -22,7 +22,7 @@ make
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make install DESTDIR=%{buildroot} PREFIX=/usr
+make install-spec DESTDIR=%{buildroot} PREFIX=/usr
 
 %files
 %defattr(-,root,root)
@@ -31,30 +31,23 @@ make install DESTDIR=%{buildroot} PREFIX=/usr
 %{_mandir}/man1/nvme*.1*
 %{_datadir}/bash-completion/completions/nvme
 %{_datadir}/zsh/site-functions/_nvme
+%dir %{_sysconfdir}/nvme
+%{_sysconfdir}/nvme/hostnqn
+%{_sysconfdir}/nvme/hostid
 
 %clean
 rm -rf $RPM_BUILD_ROOT
 
 %post
-if [ $1 = 1 ]; then # 1 : This package is being installed for the first time
-	if [ ! -f /etc/nvme/hostnqn ]; then
-		install -D /dev/null /etc/nvme/hostnqn
-		echo $(nvme gen-hostnqn) > /etc/nvme/hostnqn
+if [ $1 -eq 1 ]; then # 1 : This package is being installed for the first time
+	if [ ! -s %{_sysconfdir}/nvme/hostnqn ]; then
+		echo $(nvme gen-hostnqn) > %{_sysconfdir}/nvme/hostnqn
         fi
-        if [ ! -f /etc/nvme/hostid ]; then
-                uuidgen > /etc/nvme/hostid
+        if [ ! -s %{_sysconfdir}/nvme/hostid ]; then
+                uuidgen > %{_sysconfdir}/nvme/hostid
         fi
 fi
 
-%preun
-if [ "$1" = "remove" ]; then
-	if [ -d /etc/nvme ]; then
-		rm -f /etc/nvme/hostnqn
-		if [ ! -n "`ls -A /etc/nvme`" ]; then
-			rm -rf /etc/nvme
-		fi
-	fi
-fi
 %changelog
 * Mon Oct 15 2018 Eyal Ben-David <eyalbe at il.ibm.com> - 1.6.81.g899a-2
 - bash-completion check
-- 
2.17.1
