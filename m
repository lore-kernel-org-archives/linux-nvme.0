From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 14:49:42 -0700
Subject: [PATCH 2/2] spec, make: Add discovery.conf to the package files list
In-Reply-To: <20190424214942.11288-1-sagi@grimberg.me>
References: <20190424214942.11288-1-sagi@grimberg.me>
Message-ID: <20190424214942.11288-2-sagi@grimberg.me>

Lets add it as part of the package with a little documentation.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 Makefile              | 3 +++
 etc/discovery.conf.in | 4 ++++
 nvme.spec.in          | 1 +
 3 files changed, 8 insertions(+)
 create mode 100644 etc/discovery.conf.in

diff --git a/Makefile b/Makefile
index 02299c45734f..4bfbebbd156a 100644
--- a/Makefile
+++ b/Makefile
@@ -102,6 +102,9 @@ install-etc:
 	$(INSTALL) -d $(DESTDIR)$(SYSCONFDIR)/nvme
 	touch $(DESTDIR)$(SYSCONFDIR)/nvme/hostnqn
 	touch $(DESTDIR)$(SYSCONFDIR)/nvme/hostid
+	if [ ! -f $(DESTDIR)$(SBINDIR)/nvme/discovery.conf ]; then \
+		$(INSTALL) -m 644 -T ./etc/discovery.conf.in $(DESTDIR)$(SYSCONFDIR)/nvme/discovery.conf; \
+	fi
 
 install-spec: install-bin install-man install-bash-completion install-zsh-completion install-etc
 install: install-spec install-hostparams
diff --git a/etc/discovery.conf.in b/etc/discovery.conf.in
new file mode 100644
index 000000000000..14e0d9c3dcbf
--- /dev/null
+++ b/etc/discovery.conf.in
@@ -0,0 +1,4 @@
+# Used for extracting default parameters for discovery
+#
+# Example:
+# --transport=<trtype> --traddr=<traddr> --trsvcid=<trsvcid> --host-traddr=<host-traddr>
diff --git a/nvme.spec.in b/nvme.spec.in
index 147b64a530f8..6934f8fd605b 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -34,6 +34,7 @@ make install-spec DESTDIR=%{buildroot} PREFIX=/usr
 %dir %{_sysconfdir}/nvme
 %{_sysconfdir}/nvme/hostnqn
 %{_sysconfdir}/nvme/hostid
+%{_sysconfdir}/nvme/discovery.conf
 
 %clean
 rm -rf $RPM_BUILD_ROOT
-- 
2.17.1
