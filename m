From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  6 Nov 2016 21:13:00 +0200
Subject: [PATCH RFC nvme-cli 1/2] debain: generate hostnqn file on install and
 remove on uninstall
In-Reply-To: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
Message-ID: <1478459581-22654-2-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 debian/postinst | 22 ++++++++++++++++++++++
 debian/prerm    |  5 +++++
 2 files changed, 27 insertions(+)
 create mode 100644 debian/postinst
 create mode 100644 debian/prerm

diff --git a/debian/postinst b/debian/postinst
new file mode 100644
index 000000000000..f0e3aaf8c4d0
--- /dev/null
+++ b/debian/postinst
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+set -e
+
+case "$1" in
+    configure|install)
+	if [ ! -f /etc/nvme/hostnqn ]; then
+		install -D /dev/null /etc/nvme/hostnqn
+		year_month=$(date | awk '{print $6"-"$3}')
+		uuid=$(cat /proc/sys/kernel/random/uuid)
+		echo "nqn.$year_month.org.nvmexpress:NVMf:uuid:$uuid" > /etc/nvme/hostnqn
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
diff --git a/debian/prerm b/debian/prerm
new file mode 100644
index 000000000000..40c6fea42284
--- /dev/null
+++ b/debian/prerm
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+if [ "$1" = "remove" ]; then
+    rm -rf /etc/nvme
+fi
-- 
2.7.4
