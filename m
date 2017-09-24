From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Sep 2017 16:01:35 +0300
Subject: [PATCH rfc] nvme-cli: NVMf auto discovery systemd service
Message-ID: <1506258095-15916-1-git-send-email-sagi@grimberg.me>

Run a one-shot discovery (and connect) at system boot time. This
allows to auto discover and establish nvmf sessions.

If the user is interested in using this, it should fill in
one or more discovery endpoints, for example:
-t rdma -a 192.168.1.1 -s 4420

This service relies on nvme-fabrics module being loaded, hence
we add it to modules load at boot list.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Don't have a fedora station near-by, manually tested auto
discover during boot with systemd service, and it seem to work
(although I needed to manually get mlx5_ib modules to auto-load
as for some reason it fails to auto load at boot time).

We can also add some documentation into discovery.conf to help
the user add discovery endpoints.

 nvme.spec.in                   | 19 +++++++++++++++++++
 systemd/nvmf-discovery.service | 12 ++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 systemd/nvmf-discovery.service

diff --git a/nvme.spec.in b/nvme.spec.in
index 0be61e398fd0..c22bdeec9138 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -43,12 +43,31 @@ if [ $1 = 1 ]; then # 1 : This package is being installed for the first time
         if [ ! -f /etc/nvme/hostid ]; then
                 uuidgen > /etc/nvme/hostid
         fi
+        if [ ! -f /etc/nvme/discovery.conf ]; then
+		touch /etc/nvme/discovery.conf
+        fi
 fi
 
+# NVMf auto-discovery service
+install -m 0755 systemd/nvmf-discovery.service /lib/systemd/system/
+systemctl enable nvmf-discovery.service
+
+# we rely on /dev/nvme-fabrics misc device, so auto load nvme-fabrics
+# at boot time
+echo nvme-fabrics >> /etc/modules-load.d/modules.conf
+
 %preun
 if [ "$1" = "remove" ]; then
+	sed -i 's/nvme-fabrics//e' /etc/modules-load.d/modules.conf
+
+	if [ -f /lib/systemd/system/nvmf-discovery.service]; then
+		systemctl disable nvmf-discovery.service
+		rm -f /lib/systemd/system/nvmf-discovery.service
+	fi
+
 	if [ -d /etc/nvme ]; then
 		rm -f /etc/nvme/hostnqn
+		rm -f /etc/nvme/discovery.conf
 		if [ ! -n "`ls -A /etc/nvme`" ]; then
 			rm -rf /etc/nvme
 		fi
diff --git a/systemd/nvmf-discovery.service b/systemd/nvmf-discovery.service
new file mode 100644
index 000000000000..25f7bf1f077b
--- /dev/null
+++ b/systemd/nvmf-discovery.service
@@ -0,0 +1,12 @@
+[Unit]
+Description=NVMf auto discovery service
+After=systemd-modules-load.service network-online.target
+
+[Service]
+Type=oneshot
+ExecStart=nvme connect-all
+StandardOutput=journal
+StandardError=journal
+
+[Install]
+WantedBy=multi-user.target
-- 
2.7.4
