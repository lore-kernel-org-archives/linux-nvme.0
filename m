From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:05:59 -0700
Subject: [PATCH v2 2/2] nvme_fc: add uevent for auto-connect
In-Reply-To: <20170513190559.25484-1-jsmart2021@gmail.com>
References: <20170513190559.25484-1-jsmart2021@gmail.com>
Message-ID: <20170513190559.25484-3-jsmart2021@gmail.com>

To support auto-connecting to FC-NVME devices upon their dynamic
appearance, add a uevent that can kick off connection scripts.
uevent is posted against the nvme_fc transport device.

Added checking to stop the "feature" of connecting to the same
subsystem multiple times on FC devices.

Added routine nvme_fc_rescan_remoteport() to allow lldd to request
nvme scan. For example, lldd may invoke this after receiving an
RSCN for a logged in device containing a discovery controller.

Tested with the following rule to kick an nvme-cli connect-all for the
FC initiator and FC target ports. This is just an example for testing
and not intended for real life use.

ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
        ENV{NVMEFC_HOST_TRADDR}=="*", ENV{NVMEFC_TRADDR}=="*", \
	RUN+="/bin/sh -c '/usr/local/sbin/nvme connect-all --transport=fc --host-traddr=$env{NVMEFC_HOST_TRADDR} --traddr=$env{NVMEFC_TRADDR} >> /tmp/nvme_fc.log'"

Signed-off-by: James Smart <james.smart at broadcom.com>
---
v2: changed syntax of event to specify a fc event type with FC_EVENT
  variable, and independent variables for host_traddr and traddr.
  Added nvme_fc_rescan_remoteport().

 drivers/nvme/host/fc.c         | 67 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  2 ++
 2 files changed, 69 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 4ae99d546378..9a594ea323e8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -392,6 +392,26 @@ nvme_fc_unregister_localport(struct nvme_fc_local_port *portptr)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_unregister_localport);
 
+static void
+nvme_fc_signal_discovery_scan(struct nvme_fc_lport *lport,
+		struct nvme_fc_rport *rport)
+{
+	char hostaddr[80];	/* NVMEFC_HOST_TRADDR=...*/
+	char tgtaddr[80];	/* NVMEFC_TRADDR=...*/
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
+	kobject_uevent_env(&nvmefc_device->kobj, KOBJ_CHANGE, envp);
+}
+
 /**
  * nvme_fc_register_remoteport - transport entry point called by an
  *                              LLDD to register the existence of a NVME
@@ -456,6 +476,8 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	list_add_tail(&newrec->endp_list, &lport->endp_list);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
+	nvme_fc_signal_discovery_scan(lport, newrec);
+
 	*portptr = &newrec->remoteport;
 	return 0;
 
@@ -574,6 +596,23 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
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
 
@@ -2699,6 +2738,19 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 };
 
 
+static inline bool
+__nvme_fc_options_match(struct nvmf_ctrl_options *opts,
+			struct nvme_fc_ctrl *ctrl)
+{
+	if (strcmp(opts->subsysnqn, ctrl->ctrl.opts->subsysnqn) ||
+	    strcmp(opts->host->nqn, ctrl->ctrl.opts->host->nqn) ||
+	    memcmp(&opts->host->id, &ctrl->ctrl.opts->host->id,
+				sizeof(uuid_be)))
+		return false;
+
+	return true;
+}
+
 static struct nvme_ctrl *
 nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
@@ -2706,6 +2758,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_ctrl *ctrl;
 	unsigned long flags;
 	int ret, idx;
+	bool found = false;
 
 	if (!(rport->remoteport.port_role &
 	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -2713,6 +2766,20 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
+	spin_lock_irqsave(&rport->lock, flags);
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+		if (__nvme_fc_options_match(opts, ctrl)) {
+			found = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	if (found) {
+		ret = -EALREADY;
+		goto out_fail;
+	}
+
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl) {
 		ret = -ENOMEM;
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 492e9f402223..c42313f9a451 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -446,6 +446,8 @@ int nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 
 int nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *remoteport);
 
+void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
+
 
 
 /*
-- 
2.11.0
