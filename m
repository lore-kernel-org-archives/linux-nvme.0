From: hare@suse.de (Hannes Reinecke)
Date: Fri, 16 Nov 2018 09:00:24 +0100
Subject: [PATCH nvme-cli] nvme_fc auto-connect scripts
Message-ID: <20181116080024.12078-1-hare@suse.de>

From: James Smart <jsmart2021@gmail.com>

Sagi recently posted a "one-shot" call to nvme-connect via a systemd
script. FC has no problems operating with it assuming all the required
connect fields are present (host_traddr required).

However FC is a bit more dynamic, and we've built up scripts that can
be triggered whenever a new FC remote port with a discovery subsytem is
detected. Whenever such a port is detected (by registration of the
remoteport with the nvme_fc transport by the lldd), the transport
generates a udev event.  A udev rule is created that parses the event
information into the FC remote port (traddr) that supports a discovery
subsystem and the FC host port that is connected to the FC remote port
(host_traddr). The rule then invokes an instance-based systemd service
to perform a "nvme connect-all" with the traddr and host-traddr info.

To resolve some issues seen by discovery of remote ports before the udev
service was running we've added an additional system service
nvmefc-boot-connections.service which will retrigger the event by
writint 'add' into the 'nvme_discovery' sysfs attribute.

This patch has been adapted from an earlier patch from James Smart.

Signed-off-by: James Smart <james.smart at broadcom.com>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 Makefile                                |  9 +++++++++
 nvme-fc/70-nvmefc-autoconnect.rules     |  8 ++++++++
 nvme-fc/nvmefc-boot-connections.service |  9 +++++++++
 nvme-fc/nvmefc-connect at .service         | 14 ++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 nvme-fc/70-nvmefc-autoconnect.rules
 create mode 100644 nvme-fc/nvmefc-boot-connections.service
 create mode 100644 nvme-fc/nvmefc-connect at .service

diff --git a/Makefile b/Makefile
index 70541cb..8b9d0e1 100644
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,8 @@ DESTDIR =
 PREFIX ?= /usr/local
 SYSCONFDIR = /etc
 SBINDIR = $(PREFIX)/sbin
+SYSTEMDDIR = /usr/lib/systemd
+UDEVDIR = /usr/lib/udev
 LIB_DEPENDS =
 
 ifeq ($(LIBUUID),0)
@@ -86,6 +88,13 @@ install-bash-completion:
 	$(INSTALL) -d $(DESTDIR)$(PREFIX)/share/bash-completion/completions
 	$(INSTALL) -m 644 -T ./completions/bash-nvme-completion.sh $(DESTDIR)$(PREFIX)/share/bash-completion/completions/nvme
 
+install-udev:
+	$(INSTALL) -d $(DESTDIR)$(SYSTEMDDIR)/system
+	$(INSTALL) -m 644 ./nvme-fc/nvme-fc-connect at .service $(DESTDIR)$(SYSTEMDDIR)/system
+	$(INSTALL) -m 644 ./nvme-fc/nvmefc-boot-connections.service $(DESTDIR)$(SYSTEMDIR)/system
+	$(INSTALL) -d $(DESTDIR)$(UDEVDIR)/rules.d
+	$(INSTALL) -m 644 ./nvme-fc/70-nvme-fc-autoconnect.rules $(DESTDIR)$(UDEVDIR)/rules.d
+
 install: install-bin install-man install-bash-completion
 
 nvme.spec: nvme.spec.in NVME-VERSION-FILE
diff --git a/nvme-fc/70-nvmefc-autoconnect.rules b/nvme-fc/70-nvmefc-autoconnect.rules
new file mode 100644
index 0000000..aa4f9bf
--- /dev/null
+++ b/nvme-fc/70-nvmefc-autoconnect.rules
@@ -0,0 +1,8 @@
+#
+# nvme_fc: udev event to automatically scan (via discovery controller)
+#   new FC nvme remote ports and auto-connect to the subsystems they report.
+#
+
+ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
+  ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
+  RUN+="/usr/bin/systemctl --no-block start nvmefc-connect at --host-traddr=$env{NVMEFC_HOST_TRADDR}\\x20--traddr=$env{NVMEFC_TRADDR}.service"
diff --git a/nvme-fc/nvmefc-boot-connections.service b/nvme-fc/nvmefc-boot-connections.service
new file mode 100644
index 0000000..aa35c15
--- /dev/null
+++ b/nvme-fc/nvmefc-boot-connections.service
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
diff --git a/nvme-fc/nvmefc-connect at .service b/nvme-fc/nvmefc-connect at .service
new file mode 100644
index 0000000..c2370d6
--- /dev/null
+++ b/nvme-fc/nvmefc-connect at .service
@@ -0,0 +1,14 @@
+#
+# Unit file used by 70-nvmefc-autoconnect.rules.
+#
+
+[Unit]
+Description=Auto-connect to subsystems on FC-NVME devices
+After=syslog.target
+
+[Service]
+Type=oneshot
+ExecStart=/bin/sh -c "/usr/sbin/nvme connect-all --transport=fc `/usr/bin/echo -e '%i'`"
+
+[Install]
+WantedBy=default.target
-- 
2.13.7
