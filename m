From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 13:13:29 +0200
Subject: [PATCH nvme-cli v3 2/3] nvme.spec/debian: Auto generate host nqn as
 part of install
In-Reply-To: <1484219610-18370-1-git-send-email-sagi@grimberg.me>
References: <1484219610-18370-1-git-send-email-sagi@grimberg.me>
Message-ID: <1484219610-18370-3-git-send-email-sagi@grimberg.me>

The installation will generate a hostnqn and store it in
/etc/nvme/hostnqn file (in case it doesn't exist).
This file will be removed upon uninstallation (purge on for debian).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 debian/postinst | 20 ++++++++++++++++++++
 debian/postrm   | 10 ++++++++++
 nvme.spec.in    | 17 +++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 debian/postinst
 create mode 100644 debian/postrm

diff --git a/debian/postinst b/debian/postinst
new file mode 100644
index 000000000000..cd497b7af90b
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
+		echo `nvme gen-hostnqn` > /etc/nvme/hostnqn
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
index 000000000000..c655ee47004a
--- /dev/null
+++ b/debian/postrm
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+if [ "$1" = "purge" ]; then
+	if [ -d /etc/nvme ]; then
+		rm -f /etc/nvme/hostnqn
+		if [ ! -n "`ls -A /etc/nvme`" ]; then
+			rm -rf /etc/nvme
+		fi
+	fi
+fi
diff --git a/nvme.spec.in b/nvme.spec.in
index a4718773a962..36c3b2141641 100644
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
+		if [ ! -n "`ls -A /etc/nvme`" ]; then
+			rm -rf /etc/nvme
+		fi
+	fi
+fi
 %changelog
 * Thu Oct 15 2015 Keith Busch <keith.busch at intel.com>
 - Initial RPM spec
-- 
2.7.4
