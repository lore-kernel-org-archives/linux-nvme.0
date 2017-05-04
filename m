From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu,  4 May 2017 11:07:34 -0700
Subject: [RFC 4/7] nvme_fc: check connectivity before initiating reconnects
In-Reply-To: <20170504180737.5472-1-jsmart2021@gmail.com>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
Message-ID: <20170504180737.5472-5-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

check remoteport connectivity before initiating reconnects

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a975a48f00a5..419d4a85218d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -586,6 +586,19 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_unregister_remoteport);
 
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
 
@@ -2318,6 +2331,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.opts->nr_reconnects;
 
+	if (!nvme_fc_rport_is_online(ctrl->rport))
+		return -ENODEV;
+
 	/*
 	 * Create the admin queue
 	 */
@@ -2619,6 +2635,12 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
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
@@ -2650,12 +2672,15 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
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
