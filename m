From: jsmart2021@gmail.com (James Smart)
Date: Tue, 26 Sep 2017 21:50:44 -0700
Subject: [PATCH v2 5/7] nvme_fc: check connectivity before initiating
 reconnects
In-Reply-To: <20170927045046.22238-1-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
Message-ID: <20170927045046.22238-6-jsmart2021@gmail.com>

check remoteport connectivity before initiating reconnects

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 63fb35bb6f1f..740dd471ec7a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -738,6 +738,19 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		dma_unmap_sg(dev, sg, nents, dir);
 }
 
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
 
 /* *********************** FC-NVME LS Handling **************************** */
 
@@ -2382,6 +2395,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.nr_reconnects;
 
+	if (!nvme_fc_rport_is_online(ctrl->rport))
+		return -ENODEV;
+
 	/*
 	 * Create the admin queue
 	 */
@@ -2658,6 +2674,10 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		ctrl->cnum, status);
 
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
+		/* Only schedule the reconnect if the remote port is online */
+		if (!nvme_fc_rport_is_online(ctrl->rport))
+			return;
+
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: Reconnect attempt in %d seconds.\n",
 			ctrl->cnum, ctrl->ctrl.opts->reconnect_delay);
@@ -2691,12 +2711,15 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
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
 
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
-- 
2.13.1
