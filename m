From: jsmart2021@gmail.com (James Smart)
Date: Thu, 14 Sep 2017 10:38:42 -0700
Subject: [PATCH v3 2/3] nvme_fc: add uevent for auto-connect
In-Reply-To: <20170914173843.3195-1-jsmart2021@gmail.com>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
Message-ID: <20170914173843.3195-3-jsmart2021@gmail.com>

To support auto-connecting to FC-NVME devices upon their dynamic
appearance, add a uevent that can kick off connection scripts.
uevent is posted against the fc_udev device.

patch set tested with the following rule to kick an nvme-cli connect-all
for the FC initiator and FC target ports. This is just an example for
testing and not intended for real life use.

ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
        ENV{NVMEFC_HOST_TRADDR}=="*", ENV{NVMEFC_TRADDR}=="*", \
	RUN+="/bin/sh -c '/usr/local/sbin/nvme connect-all --transport=fc --host-traddr=$env{NVMEFC_HOST_TRADDR} --traddr=$env{NVMEFC_TRADDR} >> /tmp/nvme_fc.log'"

I will post proposed udev/systemd scripts for possible kernel support.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
v2: changed syntax of event to specify a fc event type with FC_EVENT
  variable, and independent variables for host_traddr and traddr.
  Added nvme_fc_rescan_remoteport().
v3:
  Stayed with snprintf over kasprintf. The xxaddr fields, per FC-NVME
    spec, are fixed length, so hardcoding their length is acceptable.
    Also, if allocation was to fail, it potentially causes a
    critical loss in connectivity as the event wouldn't be posted.
    Better to allocate on the stack and ensure the event can be
    posted. Added define and comments on string length.
  Split duplicate connection check into separate patch.

 drivers/nvme/host/fc.c         | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f9e9dddc7e92..cb0cd4f5c4b5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -459,6 +459,36 @@ nvme_fc_unregister_localport(struct nvme_fc_local_port *portptr)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_unregister_localport);
 
+/*
+ * TRADDR strings, per FC-NVME are fixed format:
+ *   "nn-0x<16hexdigits>:pn-0x<16hexdigits>" - 43 characters
+ * udev event will only differ by prefix of what field is
+ * being specified:
+ *    "NVMEFC_HOST_TRADDR=" or "NVMEFC_TRADDR=" - 19 max characters
+ *  19 + 43 + null_fudge = 64 characters
+ */
+#define FCNVME_TRADDR_LENGTH		64
+
+static void
+nvme_fc_signal_discovery_scan(struct nvme_fc_lport *lport,
+		struct nvme_fc_rport *rport)
+{
+	char hostaddr[FCNVME_TRADDR_LENGTH];	/* NVMEFC_HOST_TRADDR=...*/
+	char tgtaddr[FCNVME_TRADDR_LENGTH];	/* NVMEFC_TRADDR=...*/
+	char *envp[4] = { "FC_EVENT=nvmediscovery", hostaddr, tgtaddr, NULL };
+
+	if (!(rport->remoteport.port_role & FC_PORT_ROLE_NVME_DISCOVERY))
+		return;
+
+	snprintf(hostaddr, sizeof(hostaddr),
+		"NVMEFC_HOST_TRADDR=nn-0x%016llx:pn-0x%016llx",
+		lport->localport.node_name, lport->localport.port_name);
+	snprintf(tgtaddr, sizeof(tgtaddr),
+		"NVMEFC_TRADDR=nn-0x%016llx:pn-0x%016llx",
+		rport->remoteport.node_name, rport->remoteport.port_name);
+	kobject_uevent_env(&fc_udev_device->kobj, KOBJ_CHANGE, envp);
+}
+
 /**
  * nvme_fc_register_remoteport - transport entry point called by an
  *                              LLDD to register the existence of a NVME
@@ -523,6 +553,8 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	list_add_tail(&newrec->endp_list, &lport->endp_list);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
+	nvme_fc_signal_discovery_scan(lport, newrec);
+
 	*portptr = &newrec->remoteport;
 	return 0;
 
@@ -641,6 +673,23 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_unregister_remoteport);
 
+/**
+ * nvme_fc_rescan_remoteport - transport entry point called by an
+ *                              LLDD to request a nvme device rescan.
+ * @remoteport: pointer to the (registered) remote port that is to be
+ *              rescanned.
+ *
+ * Returns: N/A
+ */
+void
+nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport)
+{
+	struct nvme_fc_rport *rport = remoteport_to_rport(remoteport);
+
+	nvme_fc_signal_discovery_scan(rport->lport, rport);
+}
+EXPORT_SYMBOL_GPL(nvme_fc_rescan_remoteport);
+
 
 /* *********************** FC-NVME DMA Handling **************************** */
 
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 9c5cb4480806..1af80055053a 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -451,6 +451,8 @@ int nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 
 int nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *remoteport);
 
+void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
+
 
 
 /*
-- 
2.13.1
