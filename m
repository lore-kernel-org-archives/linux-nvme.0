From: hch@lst.de (Christoph Hellwig)
Date: Mon, 21 Sep 2015 11:40:50 -0700
Subject: [PATCH 4/7] nvme: switch abort to blk_execute_rq_nowait
In-Reply-To: <1442860853-26447-1-git-send-email-hch@lst.de>
References: <1442860853-26447-1-git-send-email-hch@lst.de>
Message-ID: <1442860853-26447-5-git-send-email-hch@lst.de>

And remove the new unused nvme_submit_cmd helper.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 52 ++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d15c886..c49f07f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -303,20 +303,6 @@ static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
 	return ctx;
 }
 
-static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
-{
-	struct request *req = ctx;
-
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-	u32 result = le32_to_cpup(&cqe->result);
-
-	blk_mq_free_request(req);
-
-	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
-	++nvmeq->dev->abort_limit;
-}
-
 static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
 				  unsigned int tag)
 {
@@ -346,7 +332,7 @@ static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
 }
 
 /**
- * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
+ * __nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
  * @cmd: The command to send
  *
@@ -368,14 +354,6 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 	nvmeq->sq_tail = tail;
 }
 
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&nvmeq->q_lock, flags);
-	__nvme_submit_cmd(nvmeq, cmd);
-	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
-}
-
 static __le64 **iod_list(struct nvme_iod *iod)
 {
 	return ((void *)iod) + iod->offset;
@@ -1256,6 +1234,19 @@ int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log **log)
 	return error;
 }
 
+static void abort_endio(struct request *req, int error)
+{
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = cmd->nvmeq;
+	u32 result = (u32)(uintptr_t)req->special;
+	u16 status = req->errors;
+
+	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
+	++nvmeq->dev->abort_limit;
+
+	blk_mq_free_request(req);
+}
+
 /**
  * nvme_abort_req - Attempt aborting a request
  *
@@ -1267,8 +1258,6 @@ static void nvme_abort_req(struct request *req)
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = cmd_rq->nvmeq;
 	struct nvme_dev *dev = nvmeq->dev;
-	struct request *abort_req;
-	struct nvme_cmd_info *abort_cmd;
 	struct nvme_command cmd;
 
 	if (!nvmeq->qid || cmd_rq->aborted) {
@@ -1290,26 +1279,19 @@ static void nvme_abort_req(struct request *req)
 	if (!dev->abort_limit)
 		return;
 
-	abort_req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_ATOMIC,
-									false);
-	if (IS_ERR(abort_req))
-		return;
-
-	abort_cmd = blk_mq_rq_to_pdu(abort_req);
-	nvme_set_info(abort_cmd, abort_req, abort_completion);
-
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abort.opcode = nvme_admin_abort_cmd;
 	cmd.abort.cid = req->tag;
 	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
-	cmd.abort.command_id = abort_req->tag;
 
 	--dev->abort_limit;
 	cmd_rq->aborted = 1;
 
 	dev_warn(nvmeq->q_dmadev, "Aborting I/O %d QID %d\n", req->tag,
 							nvmeq->qid);
-	nvme_submit_cmd(dev->queues[0], &cmd);
+
+	nvme_submit_async_cmd(dev->admin_q, &cmd, 0, GFP_ATOMIC, true,
+			abort_endio, NULL);
 }
 
 static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
-- 
1.9.1
