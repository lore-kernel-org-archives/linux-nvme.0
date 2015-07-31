From: sunad.s@samsung.com (Sunad Bhandary)
Date: Fri, 31 Jul 2015 18:56:58 +0530
Subject: [PATCH] NVMe:Remove unreachable code in nvme_abort_req
Message-ID: <1438349218-8907-1-git-send-email-sunad.s@samsung.com>

Removing unreachable code from nvme_abort_req as nvme_submit_cmd has no
failure status to return.

Signed-off-by: Sunad Bhandary <sunad.s at samsung.com>
---
 drivers/block/nvme-core.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..d0bb311 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -379,7 +379,8 @@ static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
  *
  * Safe to use from interrupt context
  */
-static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
+static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
+						struct nvme_command *cmd)
 {
 	u16 tail = nvmeq->sq_tail;
 
@@ -388,18 +389,14 @@ static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
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
 	spin_lock_irqsave(&nvmeq->q_lock, flags);
-	ret = __nvme_submit_cmd(nvmeq, cmd);
+	__nvme_submit_cmd(nvmeq, cmd);
 	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
-	return ret;
 }
 
 static __le64 **iod_list(struct nvme_iod *iod)
@@ -1080,7 +1077,8 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	c.common.command_id = req->tag;
 
 	blk_mq_free_request(req);
-	return __nvme_submit_cmd(nvmeq, &c);
+	__nvme_submit_cmd(nvmeq, &c);
+	return 0;
 }
 
 static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
@@ -1103,7 +1101,8 @@ static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
 
 	cmd->common.command_id = req->tag;
 
-	return nvme_submit_cmd(nvmeq, cmd);
+	nvme_submit_cmd(nvmeq, cmd);
+	return 0;
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1315,12 +1314,7 @@ static void nvme_abort_req(struct request *req)
 
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
 
 static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
-- 
1.9.1
