From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 16:17:08 -0700
Subject: [PATCH v2 3/4] nvme_fc: add support for duplicate_connect option
In-Reply-To: <20171020231709.3183-1-jsmart2021@gmail.com>
References: <20171020231709.3183-1-jsmart2021@gmail.com>
Message-ID: <20171020231709.3183-4-jsmart2021@gmail.com>

Adds support for the duplicate_connect option. When set to true,
checks whether there's an existing controller via the same host port
and target port for the same host (hostnqn, hostid) to the same
subsystem. Fails the connection request if an existing controller.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0d0e898912ad..90dd01811dfb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2785,6 +2785,33 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 };
 
 
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
+		found = nvmf_ctlr_matches_baseopts(&ctrl->ctrl, opts);
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
@@ -2799,6 +2826,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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
