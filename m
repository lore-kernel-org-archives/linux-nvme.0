From: jsmart2021@gmail.com (James Smart)
Date: Mon,  9 Oct 2017 13:10:32 -0700
Subject: [PATCH] nvme_fc auto-connect scripts
Message-ID: <20171009201032.2018-1-jsmart2021@gmail.com>

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
service was running and where the events were not replayed, there is an
additional systemd service that runs once and invokes a script which
locates the FC host ports on the system, looks for any connected FC
remote ports with discovery subsystems, and invokes a connect-all for
them.  The FC port information is specific to lpfc attributes currently,
but when the shared transport is in place, they will be common.

I don't claim to be a systemd expert, so comments are certainly welcome.

There's a spec file for an rpm, but as a general notice, the installation
is as follows:

(as root)
cp 70-nvmefc-autoconnect.conf        /usr/lib/dracut/dracut.conf.d/
cp 70-nvmefc-autoconnect.rules       /usr/lib/udev/rules.d/
cp nvmefc-connect at .service           /usr/lib/systemd/system/
cp nvmefc-boot-connections.service   /usr/lib/systemd/system/
cp nvmefc_boot_connections.sh        /usr/sbin/lpfc/

chmod 644 /usr/lib/dracut/dracut.conf.d/70-nvmefc-autoconnect.conf
chmod 644 /usr/lib/udev/rules.d/70-nvmefc-autoconnect.rules
chmod 644 /usr/lib/systemd/system/nvmefc-connect at .service
chmod 644 /usr/lib/systemd/system/nvmefc-boot-connections.service
chmod 544 /usr/sbin/lpfc/nvmefc_boot_connections.sh

systemctl -q enable nvmefc-boot-connections
systemctl -q daemon-reload
udevadm control --reload-rules
udevadm trigger --action=change --subsystem-match=fc
dracut -f

The nvmefc_boot_connections.sh script can be put somewhere other than
/usr/sbin/lpfc. If moved, the nvmefc-boot-connections.service file must
be revised with the proper pathname.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 nvme-fc-autoconnect/70-nvmefc-autoconnect.conf     |   1 +
 nvme-fc-autoconnect/70-nvmefc-autoconnect.rules    |   6 +
 .../nvmefc-boot-connections.service                |   9 ++
 nvme-fc-autoconnect/nvmefc-connect.spec            | 138 +++++++++++++++++++++
 nvme-fc-autoconnect/nvmefc-connect at .service        |  14 +++
 nvme-fc-autoconnect/nvmefc_boot_connections.sh     |  25 ++++
 6 files changed, 193 insertions(+)
 create mode 100644 nvme-fc-autoconnect/70-nvmefc-autoconnect.conf
 create mode 100644 nvme-fc-autoconnect/70-nvmefc-autoconnect.rules
 create mode 100644 nvme-fc-autoconnect/nvmefc-boot-connections.service
 create mode 100644 nvme-fc-autoconnect/nvmefc-connect.spec
 create mode 100644 nvme-fc-autoconnect/nvmefc-connect at .service
 create mode 100644 nvme-fc-autoconnect/nvmefc_boot_connections.sh

diff --git a/nvme-fc-autoconnect/70-nvmefc-autoconnect.conf b/nvme-fc-autoconnect/70-nvmefc-autoconnect.conf
new file mode 100644
index 000000000000..b92d94fda336
--- /dev/null
+++ b/nvme-fc-autoconnect/70-nvmefc-autoconnect.conf
@@ -0,0 +1 @@
+install_items+="/usr/lib/udev/rules.d/70-nvmefc-autoconnect.rules"
diff --git a/nvme-fc-autoconnect/70-nvmefc-autoconnect.rules b/nvme-fc-autoconnect/70-nvmefc-autoconnect.rules
new file mode 100644
index 000000000000..a84ea61fca5f
--- /dev/null
+++ b/nvme-fc-autoconnect/70-nvmefc-autoconnect.rules
@@ -0,0 +1,6 @@
+#
+# nvme_fc: udev event to automatically scan (via discovery controller)
+#   new FC nvme remote ports and auto-connect to the subsystems they report.
+#
+
+ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", RUN+="/usr/bin/systemctl --no-block start nvmefc-connect at --host-traddr=$env{NVMEFC_HOST_TRADDR}\\x20--traddr=$env{NVMEFC_TRADDR}.service"
diff --git a/nvme-fc-autoconnect/nvmefc-boot-connections.service b/nvme-fc-autoconnect/nvmefc-boot-connections.service
new file mode 100644
index 000000000000..6b0a7585a43e
--- /dev/null
+++ b/nvme-fc-autoconnect/nvmefc-boot-connections.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=Auto-connect to subsystems on FC-NVME devices during boot
+
+[Service]
+Type=oneshot
+ExecStart=/bin/sh -c "/usr/sbin/lpfc/nvmefc_boot_connections.sh"
+
+[Install]
+WantedBy=default.target
diff --git a/nvme-fc-autoconnect/nvmefc-connect.spec b/nvme-fc-autoconnect/nvmefc-connect.spec
new file mode 100644
index 000000000000..8497128096a9
--- /dev/null
+++ b/nvme-fc-autoconnect/nvmefc-connect.spec
@@ -0,0 +1,138 @@
+#/*----------------------------------------------------------------------------
+#
+# Broadcom Confidential. Copyright 2017 Broadcom. All Rights Reserved.
+# The term "Broadcom" refers to Broadcom Limited and/or its subsidiaries.
+# Unpublished work. Copying, access, use, or distribution requires an
+# applicable license approved by Broadcom.
+#
+#----------------------------------------------------------------------------*/
+
+%define _sandbox        %(dirname %{_topdir})
+%define _version_str    %{_versionstr}
+
+
+Name: nvmefc-connect
+Vendor: Broadcom Ltd or its subsidiaries
+Version: %{_version_str}
+Release: 1
+Summary: NVMe FC Auto Connect
+License: Copyright 2017 Broadcom. All Rights Reserved. The term "Broadcom" refers to Broadcom Limited and/or its subsidiaries.
+URL: www.broadcom.com
+Group: Applications/System
+ExclusiveOS: linux
+Requires: dracut, nvme-cli, systemd, udev
+AutoReqProv: yes
+Source: nvmefc-connect-%{version}-linux.tgz
+BuildRoot: %{_sandbox}/tmp/nvmefc-connect
+
+#During an installation
+#%pre:
+#   Runs before the package is installed
+#%post:
+#   Runs after the package is installed
+
+#During an uninstallation
+#%preun
+#   Runs before the package is uninstalled
+#%postun
+#   Runs after the package is uninstalled
+
+#During an Upgrade
+#%pre of new package
+#   Install new files
+#%post of new package
+#
+#%preun of old package
+#   Delete any old files not overwritten by newer ones
+#%postun of old package
+
+%description
+NVMe FC Auto Connect
+
+
+%prep
+
+
+
+
+%setup
+
+
+
+
+%pre
+# During an upgrade, remove the symbolic links
+if [ "$1" = "2" ]; then
+    systemctl -q disable nvmefc-boot-connections
+    systemctl -q daemon-reload
+fi
+
+
+
+
+%install
+rm -rf %{buildroot}/usr/lib/dracut/dracut.conf.d/
+rm -rf %{buildroot}/usr/lib/systemd/system/
+rm -rf %{buildroot}/usr/lib/udev/rules.d/
+rm -rf %{buildroot}/usr/sbin/lpfc/
+
+mkdir -p %{buildroot}/usr/lib/dracut/dracut.conf.d/
+mkdir -p %{buildroot}/usr/lib/systemd/system/
+mkdir -p %{buildroot}/usr/lib/udev/rules.d/
+mkdir -p %{buildroot}/usr/sbin/lpfc/
+
+cp ./usr/lib/dracut/dracut.conf.d/70-nvmefc-autoconnect.conf  %{buildroot}/usr/lib/dracut/dracut.conf.d/
+cp ./usr/lib/udev/rules.d/70-nvmefc-autoconnect.rules         %{buildroot}/usr/lib/udev/rules.d/
+cp ./usr/lib/systemd/system/nvmefc-connect at .service           %{buildroot}/usr/lib/systemd/system/
+cp ./usr/lib/systemd/system/nvmefc-boot-connections.service   %{buildroot}/usr/lib/systemd/system/
+cp ./usr/sbin/lpfc/nvmefc_boot_connections.sh                 %{buildroot}/usr/sbin/lpfc/
+
+chmod 644 %{buildroot}/usr/lib/dracut/dracut.conf.d/70-nvmefc-autoconnect.conf
+chmod 644 %{buildroot}/usr/lib/udev/rules.d/70-nvmefc-autoconnect.rules
+chmod 644 %{buildroot}/usr/lib/systemd/system/nvmefc-connect at .service
+chmod 644 %{buildroot}/usr/lib/systemd/system/nvmefc-boot-connections.service
+chmod 544 %{buildroot}/usr/sbin/lpfc/nvmefc_boot_connections.sh
+
+
+
+
+%post
+systemctl -q enable nvmefc-boot-connections
+systemctl -q daemon-reload
+udevadm control --reload-rules
+udevadm trigger --action=change --subsystem-match=fc
+dracut -f
+
+
+
+
+%preun
+# Perform the following only if this an uninstallation.
+# i.e. "rpm -ev"
+if [ "$1" = "0" ]; then
+    systemctl -q disable nvmefc-boot-connections
+    systemctl -q daemon-reload
+fi
+
+
+
+
+%postun
+systemctl -q daemon-reload
+udevadm control --reload-rules
+# Perform the following only if this an uninstallation.
+# i.e. "rpm -ev"
+if [ "$1" = "0" ]; then
+    dracut -f
+fi
+
+
+
+
+%files
+/usr/lib/dracut/dracut.conf.d/70-nvmefc-autoconnect.conf
+/usr/lib/udev/rules.d/70-nvmefc-autoconnect.rules
+/usr/lib/systemd/system/nvmefc-connect at .service
+/usr/lib/systemd/system/nvmefc-boot-connections.service
+/usr/sbin/lpfc/nvmefc_boot_connections.sh
+
diff --git a/nvme-fc-autoconnect/nvmefc-connect at .service b/nvme-fc-autoconnect/nvmefc-connect at .service
new file mode 100644
index 000000000000..c2370d63dab1
--- /dev/null
+++ b/nvme-fc-autoconnect/nvmefc-connect at .service
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
diff --git a/nvme-fc-autoconnect/nvmefc_boot_connections.sh b/nvme-fc-autoconnect/nvmefc_boot_connections.sh
new file mode 100644
index 000000000000..b1c1e67cdd8b
--- /dev/null
+++ b/nvme-fc-autoconnect/nvmefc_boot_connections.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+connect_discovery_servers_on_host()
+{
+  INFOFILE=$1/nvme_info
+  HOSTNM=`basename $1`
+  if [ -f ${INFOFILE} ] ; then
+    WWNN=`cat /sys/class/fc_host/${HOSTNM}/node_name`
+    WWPN=`cat /sys/class/fc_host/${HOSTNM}/port_name`
+    HOST_TRADDR="nn-${WWNN}:pn-${WWPN}"
+    cat ${INFOFILE} | awk -v haddr=${HOST_TRADDR} '/^NVME RPORT.*DISCSRVC/{print "/usr/sbin/nvme connect-all --transport=fc --host-traddr=" haddr " --traddr=nn-0" $6 ":pn-0" $4 }' | bash
+  fi
+}
+
+# need a real check for root permissions here
+ROOT=1
+
+if [ $ROOT -ne 1 ] ; then
+  echo "$0: Must be root to execute"
+  exit 1
+fi
+
+for f in /sys/class/scsi_host/* ; do
+  connect_discovery_servers_on_host $f
+done
-- 
2.13.1
