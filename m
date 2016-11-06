From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  6 Nov 2016 21:13:01 +0200
Subject: [PATCH RFC nvme-cli 2/2] nvme.spec: generate hostnqn file on install
 and remove on uninstall
In-Reply-To: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
Message-ID: <1478459581-22654-3-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvme.spec.in | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/nvme.spec.in b/nvme.spec.in
index a4718773a962..e95810995395 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -33,6 +33,20 @@ make install DESTDIR=%{buildroot} PREFIX=/usr
 %clean
 rm -rf $RPM_BUILD_ROOT
 
+%post
+if [ $1 = 1 ]; then # 1 : This package is being installed for the first time
+	if [ ! -f /etc/nvme/hostnqn ]; then
+		install -D /dev/null /etc/nvme/hostnqn
+		year_month=$(date | awk '{print $6"-"$3}')
+		uuid=$(cat /proc/sys/kernel/random/uuid)
+		echo "nqn.$year_month.org.nvmexpress:NVMf:uuid:$uuid" > /etc/nvme/hostnqn
+        fi
+fi
+
+%preun
+if [ "$1" = "remove" ]; then
+    rm -rf /etc/nvme
+fi
 %changelog
 * Thu Oct 15 2015 Keith Busch <keith.busch at intel.com>
 - Initial RPM spec
-- 
2.7.4
