From: jsmart2021@gmail.com (James Smart)
Date: Tue, 10 Oct 2017 17:35:11 -0700
Subject: [PATCH 2/3] nvme_fc: add support for duplicate_connect option
In-Reply-To: <20171011003512.5946-1-jsmart2021@gmail.com>
References: <20171011003512.5946-1-jsmart2021@gmail.com>
Message-ID: <20171011003512.5946-3-jsmart2021@gmail.com>

Adds support for the duplicate_connect option. When set to true,
checks whether there's an existing controller via the same host port
and target port for the same host (hostnqn, hostid) to the same
subsystem. Fails the connection request if an existing controller.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 18e036c6833b..48c241620d2b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2784,6 +2784,46 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 };
 
 
+static inline bool
+__nvme_fc_options_match(struct nvmf_ctrl_options *opts,
+			struct nvme_fc_ctrl *ctrl)
+{
+	if (strcmp(opts->subsysnqn, ctrl->ctrl.opts->subsysnqn) ||
+	    strcmp(opts->host->nqn, ctrl->ctrl.opts->host->nqn) ||
+	    memcmp(&opts->host->id, &ctrl->ctrl.opts->host->id,
+				sizeof(uuid_t)))
+		return false;
+
+	return true;
+}
+
+/*
+ * Fails a controller request if it matches an existing controller
+ * (association) with the same tuple:
+ * <Host NQN, Host ID, local FC port, remote FC port, SUBSYS NQN>
+ *
+ * The ports don't need to be compared as they are intrinsically
+ * already matched by the port pointers supplied.
+ */
+static bool
+nvme_fc_existing_controller(struct nvme_fc_rport *rport,
+		struct nvmf_ctrl_options *opts)
+{
+	struct nvme_fc_ctrl *ctrl;
+	unsigned long flags;
+	bool found = false;
+
+	spin_lock_irqsave(&rport->lock, flags);
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+		found = __nvme_fc_options_match(opts, ctrl);
+		if (found)
+			break;
+	}
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	return found;
+}
+
 static struct nvme_ctrl *
 nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
@@ -2798,6 +2838,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
+	if (!opts->duplicate_connect &&
+	    nvme_fc_existing_controller(rport, opts)) {
+		ret = -EALREADY;
+		goto out_fail;
+	}
+
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl) {
 		ret = -ENOMEM;
-- 
2.13.1
