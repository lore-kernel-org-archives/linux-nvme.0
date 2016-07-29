From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 29 Jul 2016 22:57:18 +0300
Subject: [PATCH 1/5] nvme-rdma: Fix device removal handling
In-Reply-To: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
Message-ID: <1469822242-3477-2-git-send-email-sagi@grimberg.me>

Device removal sequence may have crashed because the
controller (and admin queue space) was freed before
we destroyed the admin queue resources. Thus we
want to destroy the admin queue and only then queue
controller deletion and wait for it to complete.

More specifically we:
1. own the controller deletion (make sure we are not
   competing with another deletion).
2. get rid of inflight reconnects if exists (which
   also destroy and create queues).
3. destroy the queue.
4. safely queue controller deletion (and wait for it
   to complete).

Reported-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 21ecbf3f3603..f391d67e4ee0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -169,7 +169,6 @@ MODULE_PARM_DESC(register_always,
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event);
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
-static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl);
 
 /* XXX: really should move to a generic header sooner or later.. */
 static inline void put_unaligned_le24(u32 val, u8 *p)
@@ -1318,37 +1317,39 @@ out_destroy_queue_ib:
  * that caught the event. Since we hold the callout until the controller
  * deletion is completed, we'll deadlock if the controller deletion will
  * call rdma_destroy_id on this queue's cm_id. Thus, we claim ownership
- * of destroying this queue before-hand, destroy the queue resources
- * after the controller deletion completed with the exception of destroying
- * the cm_id implicitely by returning a non-zero rc to the callout.
+ * of destroying this queue before-hand, destroy the queue resources,
+ * then queue the controller deletion which won't destroy this queue and
+ * we destroy the cm_id implicitely by returning a non-zero rc to the callout.
  */
 static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-	int ret, ctrl_deleted = 0;
+	int ret;
 
-	/* First disable the queue so ctrl delete won't free it */
-	if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
-		goto out;
+	/* Own the controller deletion */
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
+		return 0;
 
-	/* delete the controller */
-	ret = __nvme_rdma_del_ctrl(ctrl);
-	if (!ret) {
-		dev_warn(ctrl->ctrl.device,
-			"Got rdma device removal event, deleting ctrl\n");
-		flush_work(&ctrl->delete_work);
+	dev_warn(ctrl->ctrl.device,
+		"Got rdma device removal event, deleting ctrl\n");
 
-		/* Return non-zero so the cm_id will destroy implicitly */
-		ctrl_deleted = 1;
+	/* Get rid of reconnect work if its running */
+	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
+	/* Disable the queue so ctrl delete won't free it */
+	if (test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags)) {
 		/* Free this queue ourselves */
-		rdma_disconnect(queue->cm_id);
-		ib_drain_qp(queue->qp);
+		nvme_rdma_stop_queue(queue);
 		nvme_rdma_destroy_queue_ib(queue);
+
+		/* Return non-zero so the cm_id will destroy implicitly */
+		ret = 1;
 	}
 
-out:
-	return ctrl_deleted;
+	/* Queue controller deletion */
+	queue_work(nvme_rdma_wq, &ctrl->delete_work);
+	flush_work(&ctrl->delete_work);
+	return ret;
 }
 
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
-- 
1.9.1
