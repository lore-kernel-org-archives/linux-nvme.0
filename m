From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:32:57 -0800
Subject: [PATCH nvme-cli rfc 6/6] fc: add autoconnect systemd service and udev
 rule for fc discovery log changes
In-Reply-To: <20190223023257.21227-1-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
Message-ID: <20190223023257.21227-7-sagi@grimberg.me>

From: Hannes Reinecke <hare@suse.de>

Whenever a new FC remote port with a discovery subsytem is detected.
Whenever such a port is detected (by registration of the remoteport
with the nvme_fc transport by the lldd), the transport generates
a udev event.  A udev rule is created that parses the event information
into the FC remote port (traddr) that supports a discovery subsystem and
the FC host port that is connected to the FC remote port (host_traddr).

The rule then invokes an instance-based systemd service to perform a
"nvme connect-all" with the traddr and host-traddr info.

Signed-off-by: Hannes Reinecke <hare at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvme.spec.in                            | 1 +
 systemd/nvmefc-boot-connections.service | 9 +++++++++
 udev/70-nvmf-autoconnect.rules          | 4 ++++
 3 files changed, 14 insertions(+)
 create mode 100644 systemd/nvmefc-boot-connections.service

diff --git a/nvme.spec.in b/nvme.spec.in
index 7b5b664e63d9..68cfcb626982 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -37,6 +37,7 @@ make install-spec DESTDIR=%{buildroot} PREFIX=/usr
 %{_sysconfdir}/nvme/discovery.conf
 /usr/lib/udev/rules.d/70-nvmf-autoconnect.rules
 /usr/lib/systemd/system/nvmf-connect at .service
+/usr/lib/systemd/system/nvmefc-boot-connections.service
 
 %clean
 rm -rf $RPM_BUILD_ROOT
diff --git a/systemd/nvmefc-boot-connections.service b/systemd/nvmefc-boot-connections.service
new file mode 100644
index 000000000000..aa35c1519f84
--- /dev/null
+++ b/systemd/nvmefc-boot-connections.service
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
diff --git a/udev/70-nvmf-autoconnect.rules b/udev/70-nvmf-autoconnect.rules
index a149036c3833..0d8b5e5edf2a 100644
--- a/udev/70-nvmf-autoconnect.rules
+++ b/udev/70-nvmf-autoconnect.rules
@@ -5,3 +5,7 @@
 
 SUBSYSTEM=="nvme", ACTION=="change", ENV{NVME_EVENT}=="discovery",\
   RUN+="/bin/systemctl --no-block start nvmf-connect at --device=nvme$env{NVME_INSTANCE}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
+
+ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
+  ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
+  RUN+="/bin/systemctl --no-block start nvmf-connect@'--transport=fc\t--host-traddr=$env{NVMEFC_HOST_TRADDR}\t--traddr=$env{NVMEFC_TRADDR}'.service"
-- 
2.17.1
