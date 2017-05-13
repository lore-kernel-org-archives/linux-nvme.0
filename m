From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:07:19 -0700
Subject: [PATCH 5/8] nvme_fc: check connectivity before initiating reconnects
In-Reply-To: <20170513190722.25536-1-jsmart2021@gmail.com>
References: <20170513190722.25536-1-jsmart2021@gmail.com>
Message-ID: <20170513190722.25536-6-jsmart2021@gmail.com>

check remoteport connectivity before initiating reconnects

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 13c18966fadc..930c9bfa0aca 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -628,6 +628,19 @@ nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_rescan_remoteport);
 
+static inline bool
+nvme_fc_rport_is_online(struct nvme_fc_rport *rport)
+{
+	unsigned long flags;
+	bool online;
+
+	spin_lock_irqsave(&rport->lock, flags);
+	online = (rport->remoteport.port_state == FC_OBJSTATE_ONLINE);
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	return online;
+}
+
 
 /* *********************** FC-NVME DMA Handling **************************** */
 
@@ -2358,6 +2371,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.opts->nr_reconnects;
 
+	if (!nvme_fc_rport_is_online(ctrl->rport))
+		return -ENODEV;
+
 	/*
 	 * Create the admin queue
 	 */
@@ -2653,6 +2669,12 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		ctrl->cnum, status);
 
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
+		/*
+		 * Only schedule the reconnect if the remote port is online
+		 */
+		if (!nvme_fc_rport_is_online(ctrl->rport))
+			return;
+
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: Reconnect attempt in %d seconds.\n",
 			ctrl->cnum, ctrl->ctrl.opts->reconnect_delay);
@@ -2684,12 +2706,15 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	ret = nvme_fc_create_association(ctrl);
-	if (ret)
-		nvme_fc_reconnect_or_delete(ctrl, ret);
-	else
-		dev_info(ctrl->ctrl.device,
-			"NVME-FC{%d}: controller reset complete\n", ctrl->cnum);
+	if (nvme_fc_rport_is_online(ctrl->rport)) {
+		ret = nvme_fc_create_association(ctrl);
+		if (ret)
+			nvme_fc_reconnect_or_delete(ctrl, ret);
+		else
+			dev_info(ctrl->ctrl.device,
+				"NVME-FC{%d}: controller reset complete\n",
+				ctrl->cnum);
+	}
 }
 
 /*
-- 
2.11.0
