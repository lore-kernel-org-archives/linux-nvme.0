From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:43:59 +0200
Subject: [PATCH nvme-cli] nvme_fc auto-connect scripts
Message-ID: <20190430064359.24905-1-hare@suse.de>

Here's a set of script to enable FC-NVMe autoconnect, based on
the initial posting from James Smart.
FC-NVMe already generates an uevent whenever a new FC-NVMe remote
port is registered, so we can create an udev rule to parse this
event and start connecting to it.

The problem here is that the 'nvme connect-all' call might be taking
some time or might even stall altogether, so we cannot call it
directly from the udev rule. Rather, the udev rule starts a systemd
service, which then calls 'nvme connect-all' as a 'simple' service.
With this approach we are insulated from any stalls in udev rules.
Additionally we can implement a boot service to restart any missed
connections attempts.

To stop autoconnect an additional nvmefc-connect.target has been
added, which will instruct systemd to cancel all outstanding
autoconnect services.

Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Simon Schricker <sschricker at suse.com>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvme-fc-autoconnect/70-nvmefc-autoconnect.conf      |  1 +
 nvme-fc-autoconnect/70-nvmefc-autoconnect.rules     |  8 ++++++++
 nvme-fc-autoconnect/nvmefc-boot-connections.service |  9 +++++++++
 nvme-fc-autoconnect/nvmefc-connect.target           |  2 ++
 nvme-fc-autoconnect/nvmefc-connect at .service         | 13 +++++++++++++
 5 files changed, 33 insertions(+)
 create mode 100644 nvme-fc-autoconnect/70-nvmefc-autoconnect.conf
 create mode 100644 nvme-fc-autoconnect/70-nvmefc-autoconnect.rules
 create mode 100644 nvme-fc-autoconnect/nvmefc-boot-connections.service
 create mode 100644 nvme-fc-autoconnect/nvmefc-connect.target
 create mode 100644 nvme-fc-autoconnect/nvmefc-connect at .service

diff --git a/nvme-fc-autoconnect/70-nvmefc-autoconnect.conf b/nvme-fc-autoconnect/70-nvmefc-autoconnect.conf
new file mode 100644
index 0000000..b92d94f
--- /dev/null
+++ b/nvme-fc-autoconnect/70-nvmefc-autoconnect.conf
@@ -0,0 +1 @@
+install_items+="/usr/lib/udev/rules.d/70-nvmefc-autoconnect.rules"
diff --git a/nvme-fc-autoconnect/70-nvmefc-autoconnect.rules b/nvme-fc-autoconnect/70-nvmefc-autoconnect.rules
new file mode 100644
index 0000000..aa4f9bf
--- /dev/null
+++ b/nvme-fc-autoconnect/70-nvmefc-autoconnect.rules
@@ -0,0 +1,8 @@
+#
+# nvme_fc: udev event to automatically scan (via discovery controller)
+#   new FC nvme remote ports and auto-connect to the subsystems they report.
+#
+
+ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
+  ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
+  RUN+="/usr/bin/systemctl --no-block start nvmefc-connect at --host-traddr=$env{NVMEFC_HOST_TRADDR}\\x20--traddr=$env{NVMEFC_TRADDR}.service"
diff --git a/nvme-fc-autoconnect/nvmefc-boot-connections.service b/nvme-fc-autoconnect/nvmefc-boot-connections.service
new file mode 100644
index 0000000..aa35c15
--- /dev/null
+++ b/nvme-fc-autoconnect/nvmefc-boot-connections.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=Auto-connect to subsystems on FC-NVME devices during boot
+
+[Service]
+Type=oneshot
+ExecStart=/bin/sh -c "echo add > /sys/class/fc/fc_udev_device/nvme_discovery"
+
+[Install]
+WantedBy=default.target
diff --git a/nvme-fc-autoconnect/nvmefc-connect.target b/nvme-fc-autoconnect/nvmefc-connect.target
new file mode 100644
index 0000000..953c0b7
--- /dev/null
+++ b/nvme-fc-autoconnect/nvmefc-connect.target
@@ -0,0 +1,2 @@
+[Unit]
+Description=All instances of nvme-fc-autoconnect daemon
diff --git a/nvme-fc-autoconnect/nvmefc-connect at .service b/nvme-fc-autoconnect/nvmefc-connect at .service
new file mode 100644
index 0000000..a8ff271
--- /dev/null
+++ b/nvme-fc-autoconnect/nvmefc-connect at .service
@@ -0,0 +1,13 @@
+#
+# Unit file used by 70-nvmefc-autoconnect.rules.
+#
+
+[Unit]
+Description=Auto-connect to subsystems on FC-NVME devices
+After=syslog.target
+PartOf=nvmefc-connect.target
+Requires=nvmefc-connect.target
+
+[Service]
+Type=simple
+ExecStart=/bin/sh -c "/usr/sbin/nvme connect-all --transport=fc `/usr/bin/echo -e '%i'`"
-- 
2.16.4
