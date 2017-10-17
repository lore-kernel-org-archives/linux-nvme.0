From: jsmart2021@gmail.com (James Smart)
Date: Tue, 17 Oct 2017 16:32:47 -0700
Subject: [PATCH v3 4/5] nvme_fc: check connectivity before initiating
 reconnects
In-Reply-To: <20171017233248.6769-1-jsmart2021@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
Message-ID: <20171017233248.6769-5-jsmart2021@gmail.com>

check remoteport connectivity before initiating reconnects

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v3:
  removed inline with lock around 1 line read of state.
  replaced calls with explicit checks of read state
---
 drivers/nvme/host/fc.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3ac49e670c38..61da2f92f71a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -810,7 +810,6 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		dma_unmap_sg(dev, sg, nents, dir);
 }
 
-
 /* *********************** FC-NVME LS Handling **************************** */
 
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
@@ -2454,6 +2453,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.nr_reconnects;
 
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
+		return -ENODEV;
+
 	/*
 	 * Create the admin queue
 	 */
@@ -2730,6 +2732,10 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		ctrl->cnum, status);
 
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
+		/* Only schedule the reconnect if the remote port is online */
+		if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
+			return;
+
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: Reconnect attempt in %d seconds.\n",
 			ctrl->cnum, ctrl->ctrl.opts->reconnect_delay);
@@ -2763,12 +2769,15 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	ret = nvme_fc_create_association(ctrl);
-	if (ret)
-		nvme_fc_reconnect_or_delete(ctrl, ret);
-	else
-		dev_info(ctrl->ctrl.device,
-			"NVME-FC{%d}: controller reset complete\n", ctrl->cnum);
+	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
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
