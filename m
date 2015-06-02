From: Parav.pandit@avagotech.com (Parav Pandit)
Date: Tue,  2 Jun 2015 19:44:04 +0530
Subject: [PATCH] NVMe: code simplification and reuse.
Message-ID: <1433254444-11421-1-git-send-email-Parav.pandit@avagotech.com>

From: Parav Pandit <parav.pandit@avagotech.com>

Moved SQ doorbell pressing code to smaller function to avoid
code duplication at 3 places.
nvme_submit_cmd is low level posting function which never fails. Removed
checks around its return status which was always success.

Signed-off-by: Parav Pandit <Parav.pandit at avagotech.com>
---
 drivers/block/nvme-core.c |   50 +++++++++++++++++++-------------------------
 1 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 58041c7..5961ed7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -372,7 +372,8 @@ static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
  *
  * Safe to use from interrupt context
  */
-static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
+static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
+			      struct nvme_command *cmd)
 {
 	u16 tail = nvmeq->sq_tail;
 
@@ -381,18 +382,15 @@ static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 		tail = 0;
 	writel(tail, nvmeq->q_db);
 	nvmeq->sq_tail = tail;
-
-	return 0;
 }
 
-static int nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
+static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 {
 	unsigned long flags;
-	int ret;
+
 	spin_lock_irqsave(&nvmeq->q_lock, flags);
-	ret = __nvme_submit_cmd(nvmeq, cmd);
+	__nvme_submit_cmd(nvmeq, cmd);
 	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
-	return ret;
 }
 
 static __le64 **iod_list(struct nvme_iod *iod)
@@ -709,6 +707,13 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
 	return total_len;
 }
 
+static inline void nvme_update_sq_tail_db(struct nvme_queue *nvmeq)
+{
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	writel(nvmeq->sq_tail, nvmeq->q_db);
+}
+
 /*
  * We reuse the small pool to allocate the 16-byte range here as it is not
  * worth having a special pool for these or additional cases to handle freeing
@@ -733,9 +738,7 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->dsm.nr = 0;
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	nvme_update_sq_tail_db(nvmeq);
 }
 
 static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
@@ -748,13 +751,11 @@ static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->common.command_id = cmdid;
 	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	nvme_update_sq_tail_db(nvmeq);
 }
 
-static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
-							struct nvme_ns *ns)
+static void nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
+			    struct nvme_ns *ns)
 {
 	struct request *req = iod_get_private(iod);
 	struct nvme_command *cmnd;
@@ -800,11 +801,7 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
-
-	return 0;
+	nvme_update_sq_tail_db(nvmeq);
 }
 
 static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -1034,7 +1031,8 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	c.common.command_id = req->tag;
 
 	blk_mq_free_hctx_request(nvmeq->hctx, req);
-	return __nvme_submit_cmd(nvmeq, &c);
+	__nvme_submit_cmd(nvmeq, &c);
+	return 0;
 }
 
 static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
@@ -1057,7 +1055,8 @@ static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
 
 	cmd->common.command_id = req->tag;
 
-	return nvme_submit_cmd(nvmeq, cmd);
+	nvme_submit_cmd(nvmeq, cmd);
+	return 0;
 }
 
 static int __nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
@@ -1246,12 +1245,7 @@ static void nvme_abort_req(struct request *req)
 
 	dev_warn(nvmeq->q_dmadev, "Aborting I/O %d QID %d\n", req->tag,
 							nvmeq->qid);
-	if (nvme_submit_cmd(dev->queues[0], &cmd) < 0) {
-		dev_warn(nvmeq->q_dmadev,
-				"Could not abort I/O %d QID %d",
-				req->tag, nvmeq->qid);
-		blk_mq_free_request(abort_req);
-	}
+	nvme_submit_cmd(dev->queues[0], &cmd);
 }
 
 static void nvme_cancel_queue_ios(struct blk_mq_hw_ctx *hctx,
-- 
1.7.1
