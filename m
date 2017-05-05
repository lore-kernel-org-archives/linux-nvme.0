From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri,  5 May 2017 16:13:35 -0700
Subject: [PATCH 2/2] nvme_fc: add uevent for auto-connect
In-Reply-To: <20170505231335.31726-1-jsmart2021@gmail.com>
References: <20170505231335.31726-1-jsmart2021@gmail.com>
Message-ID: <20170505231335.31726-3-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

To support auto-connecting to FC-NVME devices upon their dynamic
appearance, add a uevent that can kick off connection scripts.
uevent is posted against the nvme_fc transport device.

Added checking to stop the "feature" of connecting to the same
subsystem multiple times on FC devices.

Tested with the following rule to kick an nvme-cli connect-all for the
FC initiator and FC target ports. This is just an example for testing
and not intended for real life use.

ACTION=="change", SUBSYSTEM=="fc", ENV{NVMEFC_DISCVRY}=="*", \
	RUN+="/bin/sh -c '/usr/local/sbin/nvme connect-all --transport=fc $env{NVMEFC_DISCVRY} >> /tmp/nvme_fc.log'"

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 50dbe0b2f1fd..512d3c521dcd 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -392,6 +392,24 @@ nvme_fc_unregister_localport(struct nvme_fc_local_port *portptr)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_unregister_localport);
 
+static void
+nvme_fc_signal_discovery_scan(struct nvme_fc_lport *lport,
+		struct nvme_fc_rport *rport)
+{
+	char buffer[128];	/* NVMEFC_DISCVRY=...*/
+	char *envp[2] = {buffer, NULL};
+
+	if (!(rport->remoteport.port_role & FC_PORT_ROLE_NVME_DISCOVERY))
+		return;
+
+	snprintf(buffer, sizeof(buffer),
+		"NVMEFC_DISCVRY=--host-traddr=nn-0x%016llx:pn-0x%016llx"
+		" --traddr=nn-0x%016llx:pn-0x%016llx",
+		lport->localport.node_name, lport->localport.port_name,
+		rport->remoteport.node_name, rport->remoteport.port_name);
+	kobject_uevent_env(&nvmefc_device->kobj, KOBJ_CHANGE, envp);
+}
+
 /**
  * nvme_fc_register_remoteport - transport entry point called by an
  *                              LLDD to register the existence of a NVME
@@ -456,6 +474,8 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	list_add_tail(&newrec->endp_list, &lport->endp_list);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
+	nvme_fc_signal_discovery_scan(lport, newrec);
+
 	*portptr = &newrec->remoteport;
 	return 0;
 
@@ -2707,6 +2727,19 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
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
@@ -2714,6 +2747,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_ctrl *ctrl;
 	unsigned long flags;
 	int ret, idx;
+	bool found = false;
 
 	if (!(rport->remoteport.port_role &
 		(FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -2721,6 +2755,20 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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
-- 
2.11.0
