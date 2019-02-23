From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:32:56 -0800
Subject: [PATCH nvme-cli rfc 5/6] fabrics: systemd and udev support for
 automatic discovery log changes
In-Reply-To: <20190223023257.21227-1-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
Message-ID: <20190223023257.21227-6-sagi@grimberg.me>

Now that a fabrics controller can report discovery log change events,
we add a udev rule to act on a discovery log change event by running
nvme connect-all to an already established discovery controller instance.

The kernel will generate a udev event with parameters:
NVME_EVENT: currently only discovery events.
NVME_TRTYPE: the discovery controller transport type.
NVME_INSTANCE: the discovery controller instance id.
NVME_TRADDR: the discovery controller transport address.
NVME_TRSVCID: the discovery controller transport service-id.
NVME_HOST_TRADDR: the discovery controller host transport address.

udev simply feeds them as-is to nvme connect-all.

Install scripts as part of nvme-cli and apply them in post installation.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 Makefile                       | 10 +++++++++-
 nvme.spec.in                   |  6 ++++++
 systemd/nvmf-connect at .service  | 15 +++++++++++++++
 udev/70-nvmf-autoconnect.rules |  7 +++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 systemd/nvmf-connect at .service
 create mode 100644 udev/70-nvmf-autoconnect.rules

diff --git a/Makefile b/Makefile
index 303f13f256c0..86ff968691a6 100644
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,8 @@ DESTDIR =
 PREFIX ?= /usr/local
 SYSCONFDIR = /etc
 SBINDIR = $(PREFIX)/sbin
+SYSTEMDDIR = /usr/lib/systemd
+UDEVDIR = /lib/udev
 LIB_DEPENDS =
 
 ifeq ($(LIBUUID),0)
@@ -75,6 +77,12 @@ clean:
 clobber: clean
 	$(MAKE) -C Documentation clobber
 
+install-udev:
+	$(INSTALL) -d $(DESTDIR)$(SYSTEMDDIR)/system
+	$(INSTALL) -m 644 ./systemd/*.service $(DESTDIR)$(SYSTEMDDIR)/system
+	$(INSTALL) -d $(DESTDIR)$(UDEVDIR)/rules.d
+	$(INSTALL) -m 644 ./udev/*.rules $(DESTDIR)$(UDEVDIR)/rules.d
+
 install-man:
 	$(MAKE) -C Documentation install-no-build
 
@@ -106,7 +114,7 @@ install-etc:
 		$(INSTALL) -m 644 -T ./etc/discovery.conf.in $(DESTDIR)$(SYSCONFDIR)/nvme/discovery.conf; \
 	fi
 
-install-spec: install-bin install-man install-bash-completion install-zsh-completion install-etc
+install-spec: install-bin install-man install-bash-completion install-zsh-completion install-etc install-udev
 install: install-spec install-hostparams
 
 nvme.spec: nvme.spec.in NVME-VERSION-FILE
diff --git a/nvme.spec.in b/nvme.spec.in
index 6934f8fd605b..7b5b664e63d9 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -35,6 +35,8 @@ make install-spec DESTDIR=%{buildroot} PREFIX=/usr
 %{_sysconfdir}/nvme/hostnqn
 %{_sysconfdir}/nvme/hostid
 %{_sysconfdir}/nvme/discovery.conf
+/usr/lib/udev/rules.d/70-nvmf-autoconnect.rules
+/usr/lib/systemd/system/nvmf-connect at .service
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -47,6 +49,10 @@ if [ $1 -eq 1 ]; then # 1 : This package is being installed for the first time
         if [ ! -s %{_sysconfdir}/nvme/hostid ]; then
                 uuidgen > %{_sysconfdir}/nvme/hostid
         fi
+
+	# apply udev and systemd changes that we did
+	udevadm control --reload-rules && udevadm trigger
+	systemctl daemon-reload
 fi
 
 %changelog
diff --git a/systemd/nvmf-connect at .service b/systemd/nvmf-connect at .service
new file mode 100644
index 000000000000..694b27822f61
--- /dev/null
+++ b/systemd/nvmf-connect at .service
@@ -0,0 +1,15 @@
+#
+# Unit file used by 70-nvmf-autoconnect.rules.
+#
+
+[Unit]
+Description=NVMf automatic scan upon discovery log change events
+After=syslog.target
+
+[Service]
+Type=oneshot
+Environment="CONNECT_ARGS=%i"
+ExecStart=/bin/sh -c "nvme connect-all `/bin/echo -e $CONNECT_ARGS`"
+
+[Install]
+WantedBy=default.target
diff --git a/udev/70-nvmf-autoconnect.rules b/udev/70-nvmf-autoconnect.rules
new file mode 100644
index 000000000000..a149036c3833
--- /dev/null
+++ b/udev/70-nvmf-autoconnect.rules
@@ -0,0 +1,7 @@
+#
+# nvmf: udev event to automatically scan (via discovery controller)
+#   new nvme subsystem ports and auto-connect to the subsystems they report.
+#
+
+SUBSYSTEM=="nvme", ACTION=="change", ENV{NVME_EVENT}=="discovery",\
+  RUN+="/bin/systemctl --no-block start nvmf-connect at --device=nvme$env{NVME_INSTANCE}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
-- 
2.17.1
