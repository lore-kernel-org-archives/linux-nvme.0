From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:56 +0200
Subject: [PATCH 08/10] nvme: simplify completion handling
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-9-git-send-email-hch@lst.de>

Now that all commands are executed as block layer requests we can remove the
internal completion in the NVMe driver.  Note that we can simply call
blk_mq_complete_request to abort commands as the block layer will protect
against double copletions internally.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 143 ++++++++++------------------------------------
 1 file changed, 29 insertions(+), 114 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index fa8a503..94c1ec2 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -141,15 +141,11 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 }
 
-typedef void (*nvme_completion_fn)(struct nvme_queue *, void *,
-						struct nvme_completion *);
-
 struct nvme_cmd_info {
-	nvme_completion_fn fn;
-	void *ctx;
 	int aborted;
 	struct nvme_queue *nvmeq;
-	struct nvme_iod iod[0];
+	struct nvme_iod *iod;
+	struct nvme_iod __iod[0];
 };
 
 /*
@@ -243,15 +239,6 @@ static int nvme_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
-				nvme_completion_fn handler)
-{
-	cmd->fn = handler;
-	cmd->ctx = ctx;
-	cmd->aborted = 0;
-	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
-}
-
 static void *iod_get_private(struct nvme_iod *iod)
 {
 	return (void *) (iod->private & ~0x1UL);
@@ -265,72 +252,6 @@ static bool iod_should_kfree(struct nvme_iod *iod)
 	return (iod->private & NVME_INT_MASK) == 0;
 }
 
-/* Special values must be less than 0x1000 */
-#define CMD_CTX_BASE		((void *)POISON_POINTER_DELTA)
-#define CMD_CTX_CANCELLED	(0x30C + CMD_CTX_BASE)
-#define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
-#define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
-
-static void special_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
-{
-	if (ctx == CMD_CTX_CANCELLED)
-		return;
-	if (ctx == CMD_CTX_COMPLETED) {
-		dev_warn(nvmeq->q_dmadev,
-				"completed id %d twice on queue %d\n",
-				cqe->command_id, le16_to_cpup(&cqe->sq_id));
-		return;
-	}
-	if (ctx == CMD_CTX_INVALID) {
-		dev_warn(nvmeq->q_dmadev,
-				"invalid id %d completed on queue %d\n",
-				cqe->command_id, le16_to_cpup(&cqe->sq_id));
-		return;
-	}
-	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n", ctx);
-}
-
-static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
-{
-	void *ctx;
-
-	if (fn)
-		*fn = cmd->fn;
-	ctx = cmd->ctx;
-	cmd->fn = special_completion;
-	cmd->ctx = CMD_CTX_CANCELLED;
-	return ctx;
-}
-
-static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
-				  unsigned int tag)
-{
-	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, tag);
-
-	return blk_mq_rq_to_pdu(req);
-}
-
-/*
- * Called with local interrupts disabled and the q_lock held.  May not sleep.
- */
-static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
-						nvme_completion_fn *fn)
-{
-	struct nvme_cmd_info *cmd = get_cmd_from_tag(nvmeq, tag);
-	void *ctx;
-	if (tag >= nvmeq->q_depth) {
-		*fn = special_completion;
-		return CMD_CTX_INVALID;
-	}
-	if (fn)
-		*fn = cmd->fn;
-	ctx = cmd->ctx;
-	cmd->fn = special_completion;
-	cmd->ctx = CMD_CTX_COMPLETED;
-	return ctx;
-}
-
 /**
  * __nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -394,7 +315,7 @@ static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
 	    size <= NVME_INT_BYTES(dev)) {
 		struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(rq);
 
-		iod = cmd->iod;
+		iod = cmd->__iod;
 		iod_init(iod, size, rq->nr_phys_segments,
 				(unsigned long) rq | NVME_INT_MASK);
 		return iod;
@@ -543,13 +464,15 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 }
 #endif
 
-static void req_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
+/*
+ * Called with local interrupts disabled and the q_lock held.  May not sleep.
+ */
+static void nvme_finish_cmd(struct nvme_queue *nvmeq,
+		struct nvme_completion *cqe)
 {
-	struct nvme_iod *iod = ctx;
-	struct request *req = iod_get_private(iod);
+	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
-
+	struct nvme_iod *iod = cmd_rq->iod;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 
 	if (unlikely(status)) {
@@ -565,12 +488,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 			return;
 		}
 
-		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
-				status = -EINTR;
-		} else {
+		if (req->cmd_type != REQ_TYPE_DRV_PRIV)
 			status = nvme_error_status(status);
-		}
 	}
 
 	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
@@ -863,7 +782,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 	}
 
-	nvme_set_info(cmd, iod, req_completion);
+	cmd->iod = iod;
+	cmd->aborted = 0;
+	blk_mq_start_request(req);
+
 	spin_lock_irq(&nvmeq->q_lock);
 	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
 		nvme_submit_priv(nvmeq, req, iod);
@@ -894,8 +816,6 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	phase = nvmeq->cq_phase;
 
 	for (;;) {
-		void *ctx;
-		nvme_completion_fn fn;
 		struct nvme_completion cqe = nvmeq->cqes[head];
 		if ((le16_to_cpu(cqe.status) & 1) != phase)
 			break;
@@ -904,8 +824,14 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 			head = 0;
 			phase = !phase;
 		}
-		ctx = nvme_finish_cmd(nvmeq, cqe.command_id, &fn);
-		fn(nvmeq, ctx, &cqe);
+
+		if (unlikely(cqe.command_id >= nvmeq->q_depth)) {
+			dev_warn(nvmeq->q_dmadev,
+				"invalid id %d completed on queue %d\n",
+				cqe.command_id, le16_to_cpu(cqe.sq_id));
+			continue;
+		}
+		nvme_finish_cmd(nvmeq, &cqe);
 	}
 
 	/* If the controller ignores the cq head doorbell and continuously
@@ -1303,29 +1229,18 @@ static void nvme_abort_req(struct request *req)
 static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
 {
 	struct nvme_queue *nvmeq = data;
-	void *ctx;
-	nvme_completion_fn fn;
-	struct nvme_cmd_info *cmd;
-	struct nvme_completion cqe;
 
 	if (!blk_mq_request_started(req))
 		return;
 
-	cmd = blk_mq_rq_to_pdu(req);
-
-	if (cmd->ctx == CMD_CTX_CANCELLED)
-		return;
-
-	if (blk_queue_dying(req->q))
-		cqe.status = cpu_to_le16((NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1);
-	else
-		cqe.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
-
-
 	dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n",
 						req->tag, nvmeq->qid);
-	ctx = cancel_cmd_info(cmd, &fn);
-	fn(nvmeq, ctx, &cqe);
+
+	/*
+	 * Use a negative Linux errno here so that the submitter can
+	 * distinguish between hardware and driver errors.
+	 */
+	blk_mq_complete_request(req, -EINTR);
 }
 
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
-- 
1.9.1
