From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 17 Nov 2016 14:54:48 +0200
Subject: [PATCH nvme-cli v2 2/2] nvme.spec/debian: Auto generate host nqn as
 part of install
In-Reply-To: <1479387288-13367-1-git-send-email-sagi@grimberg.me>
References: <1479387288-13367-1-git-send-email-sagi@grimberg.me>
Message-ID: <1479387288-13367-3-git-send-email-sagi@grimberg.me>

The installation will generate a hostnqn and store it in
/etc/nvme/hostnqn file (in case it doesn't exist).
This file will be removed upon uninstallation (purge on for debian).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 debian/postinst | 20 ++++++++++++++++++++
 debian/postrm   | 10 ++++++++++
 nvme.spec.in    | 17 +++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 debian/postinst
 create mode 100644 debian/postrm

diff --git a/debian/postinst b/debian/postinst
new file mode 100644
index 000000000000..b258cf569c3e
--- /dev/null
+++ b/debian/postinst
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+set -e
+
+case "$1" in
+    configure|install)
+	if [ ! -f /etc/nvme/hostnqn ]; then
+		install -D /dev/null /etc/nvme/hostnqn
+		echo $(nvme gen-hostnqn) > /etc/nvme/hostnqn
+        fi
+        ;;
+
+    upgrade|abort-upgrade)
+        ;;
+    *)
+        echo "postinst called with unknown argument \`$1'" >&2
+        exit 0
+        ;;
+esac
+exit 0
diff --git a/debian/postrm b/debian/postrm
new file mode 100644
index 000000000000..a7a724352327
--- /dev/null
+++ b/debian/postrm
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+if [ "$1" = "purge" ]; then
+	if [ -d /etc/nvme ]; then
+		rm -f /etc/nvme/hostnqn
+		if [ ! -n "$(ls -A /etc/nvme)" ]; then
+			rm -rf /etc/nvme
+		fi
+	fi
+fi
diff --git a/nvme.spec.in b/nvme.spec.in
index a4718773a962..6efb28847005 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -33,6 +33,23 @@ make install DESTDIR=%{buildroot} PREFIX=/usr
 %clean
 rm -rf $RPM_BUILD_ROOT
 
+%post
+if [ $1 = 1 ]; then # 1 : This package is being installed for the first time
+	if [ ! -f /etc/nvme/hostnqn ]; then
+		install -D /dev/null /etc/nvme/hostnqn
+		echo $(nvme gen-hostnqn) > /etc/nvme/hostnqn
+        fi
+fi
+
+%preun
+if [ "$1" = "remove" ]; then
+	if [ -d /etc/nvme ]; then
+		rm -f /etc/nvme/hostnqn
+		if [ ! -n "$(ls -A /etc/nvme)" ]; then
+			rm -rf /etc/nvme
+		fi
+	fi
+fi
 %changelog
 * Thu Oct 15 2015 Keith Busch <keith.busch at intel.com>
 - Initial RPM spec
-- 
2.7.4
