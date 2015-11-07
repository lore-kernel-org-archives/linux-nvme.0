From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:45:02 +0100
Subject: [PATCH 08/12] nvme: simplify completion handling
In-Reply-To: <1446885906-20967-1-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
Message-ID: <1446885906-20967-9-git-send-email-hch@lst.de>

Now that all commands are executed as block layer requests we can remove the
internal completion in the NVMe driver.  Note that we can simply call
blk_mq_complete_request to abort commands as the block layer will protect
against double copletions internally.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 140 ++++++++++--------------------------------------
 1 file changed, 28 insertions(+), 112 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 344aa6e..03b8a3c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -193,15 +193,11 @@ static inline void _nvme_check_size(void)
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
+	struct nvme_iod __iod;
 };
 
 /*
@@ -295,15 +291,6 @@ static int nvme_init_request(void *data, struct request *req,
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
@@ -317,44 +304,6 @@ static bool iod_should_kfree(struct nvme_iod *iod)
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
 static void nvme_finish_aen_cmd(struct nvme_dev *dev, struct nvme_completion *cqe)
 {
 	u16 status = le16_to_cpu(cqe->status) >> 1;
@@ -374,34 +323,6 @@ static void nvme_finish_aen_cmd(struct nvme_dev *dev, struct nvme_completion *cq
 	}
 }
 
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
@@ -465,7 +386,7 @@ static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
 	    size <= NVME_INT_BYTES(dev)) {
 		struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(rq);
 
-		iod = cmd->iod;
+		iod = &cmd->__iod;
 		iod_init(iod, size, rq->nr_phys_segments,
 				(unsigned long) rq | NVME_INT_MASK);
 		return iod;
@@ -562,12 +483,11 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
-static void req_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
+static void req_completion(struct nvme_queue *nvmeq, struct nvme_completion *cqe)
 {
-	struct nvme_iod *iod = ctx;
-	struct request *req = iod_get_private(iod);
+	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
+	struct nvme_iod *iod = cmd_rq->iod;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 	int error = 0;
 
@@ -579,10 +499,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 		}
 
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
-				error = -EINTR;
-			else
-				error = status;
+			error = status;
 		} else {
 			error = nvme_error_status(status);
 		}
@@ -828,8 +745,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto out;
 
+	cmd->iod = iod;
+	cmd->aborted = 0;
 	cmnd.common.command_id = req->tag;
-	nvme_set_info(cmd, iod, req_completion);
+	blk_mq_start_request(req);
 
 	spin_lock_irq(&nvmeq->q_lock);
 	__nvme_submit_cmd(nvmeq, &cmnd);
@@ -849,8 +768,6 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	phase = nvmeq->cq_phase;
 
 	for (;;) {
-		void *ctx;
-		nvme_completion_fn fn;
 		struct nvme_completion cqe = nvmeq->cqes[head];
 		u16 status = le16_to_cpu(cqe.status);
 
@@ -862,6 +779,13 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 			phase = !phase;
 		}
 
+		if (unlikely(cqe.command_id >= nvmeq->q_depth)) {
+			dev_warn(nvmeq->q_dmadev,
+				"invalid id %d completed on queue %d\n",
+				cqe.command_id, le16_to_cpu(cqe.sq_id));
+			continue;
+		}
+
 		/*
 		 * AEN requests are special as they don't time out and can
 		 * survive any kind of queue freeze and often don't respond to
@@ -874,8 +798,7 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 			continue;
 		}
 
-		ctx = nvme_finish_cmd(nvmeq, cqe.command_id, &fn);
-		fn(nvmeq, ctx, &cqe);
+		req_completion(nvmeq, &cqe);
 	}
 
 	/* If the controller ignores the cq head doorbell and continuously
@@ -1069,29 +992,22 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
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
+	if (blk_queue_dying(req->q)) {
+		/*
+		 * Use a negative Linux errno here so that the submitter can
+		 * distinguish between hardware and driver errors.
+		 */
+		blk_mq_complete_request(req, -EINTR);
+	} else {
+		blk_mq_complete_request(req, NVME_SC_ABORT_REQ);
+	}
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
-- 
1.9.1
