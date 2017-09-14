From: jsmart2021@gmail.com (James Smart)
Date: Thu, 14 Sep 2017 10:38:43 -0700
Subject: [PATCH v3 3/3] nvme_fc: Avoid duplicate associations between same
 port pairs
In-Reply-To: <20170914173843.3195-1-jsmart2021@gmail.com>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
Message-ID: <20170914173843.3195-4-jsmart2021@gmail.com>

Rescans can occur due to subsystem list changes on an FC remoteport.
Rescans may attempt to reconnect to subsystems where there is already
an association in place. There should only be 1 association in place
at a time for the following tuple:
  <hostnqn, hostid, host FC port, target FC port, subnqn>

Catch connection attempts to associations that already exist and
fail the attempts.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v3:
  this patch created by content movement
  slight mod for uuid type

 drivers/nvme/host/fc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index cb0cd4f5c4b5..e7c1d767fb4c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2783,6 +2783,19 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
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
 static struct nvme_ctrl *
 nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
@@ -2790,6 +2803,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_ctrl *ctrl;
 	unsigned long flags;
 	int ret, idx;
+	bool found = false;
 
 	if (!(rport->remoteport.port_role &
 	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -2797,6 +2811,20 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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
2.13.1
