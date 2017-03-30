From: hch@lst.de (Christoph Hellwig)
Date: Thu, 30 Mar 2017 13:41:32 +0200
Subject: [PATCH 2/2] nvme: factor request completion code into a common helper
In-Reply-To: <20170330114132.27292-1-hch@lst.de>
References: <20170330114132.27292-1-hch@lst.de>
Message-ID: <20170330114132.27292-2-hch@lst.de>

This avoids duplicating the logic four times, and it also allows to keep
some helpers static in core.c or just opencode them.

Note that this loses printing the aborted status on completions in the
PCI driver as that uses a data structure not available any more.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c   | 35 +++++++++++++++++++++++++++++------
 drivers/nvme/host/fc.c     | 20 ++------------------
 drivers/nvme/host/nvme.h   |  9 +--------
 drivers/nvme/host/pci.c    | 32 +++++---------------------------
 drivers/nvme/host/rdma.c   | 20 ++------------------
 drivers/nvme/target/loop.c | 17 +----------------
 6 files changed, 40 insertions(+), 93 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b3b57fef446..ce70bb6af707 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -67,6 +67,35 @@ static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
+static inline bool nvme_req_needs_retry(struct request *req, u16 status)
+{
+	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
+		(jiffies - req->start_time) < req->timeout &&
+		req->retries < nvme_max_retries;
+}
+
+void nvme_complete_rq(struct request *req)
+{
+	int error = 0;
+
+	if (unlikely(req->errors)) {
+		if (nvme_req_needs_retry(req, req->errors)) {
+			req->retries++;
+			blk_mq_requeue_request(req,
+					!blk_mq_queue_stopped(req->q));
+			return;
+		}
+
+		if (blk_rq_is_passthrough(req))
+			error = req->errors;
+		else
+			error = nvme_error_status(req->errors);
+	}
+
+	blk_mq_end_request(req, error);
+}
+EXPORT_SYMBOL_GPL(nvme_complete_rq);
+
 void nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
 	int status;
@@ -205,12 +234,6 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 	return NULL;
 }
 
-void nvme_requeue_req(struct request *req)
-{
-	blk_mq_requeue_request(req, !blk_mq_queue_stopped(req->q));
-}
-EXPORT_SYMBOL_GPL(nvme_requeue_req);
-
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags, int qid)
 {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48a5557028e2..f00969e4b4ef 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1925,29 +1925,13 @@ nvme_fc_complete_rq(struct request *rq)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
-	int error = 0, state;
+	int state;
 
 	state = atomic_xchg(&op->state, FCPOP_STATE_IDLE);
 
 	nvme_cleanup_cmd(rq);
-
 	nvme_fc_unmap_data(ctrl, rq, op);
-
-	if (unlikely(rq->errors)) {
-		if (nvme_req_needs_retry(rq, rq->errors)) {
-			rq->retries++;
-			nvme_requeue_req(rq);
-			goto put_ctrl;
-		}
-
-		if (blk_rq_is_passthrough(rq))
-			error = rq->errors;
-		else
-			error = nvme_error_status(rq->errors);
-	}
-
-	blk_mq_end_request(rq, error);
-put_ctrl:
+	nvme_complete_rq(rq);
 	nvme_fc_ctrl_put(ctrl);
 
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2aa20e3e5675..227f281482db 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -261,13 +261,7 @@ static inline int nvme_error_status(u16 status)
 	}
 }
 
-static inline bool nvme_req_needs_retry(struct request *req, u16 status)
-{
-	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
-		(jiffies - req->start_time) < req->timeout &&
-		req->retries < nvme_max_retries;
-}
-
+void nvme_complete_rq(struct request *req);
 void nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
@@ -302,7 +296,6 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags, int qid);
-void nvme_requeue_req(struct request *req);
 int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd05fe88..72b9e8aa0027 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -628,34 +628,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static void nvme_complete_rq(struct request *req)
+static void nvme_pci_complete_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_dev *dev = iod->nvmeq->dev;
-	int error = 0;
 
-	nvme_unmap_data(dev, req);
-
-	if (unlikely(req->errors)) {
-		if (nvme_req_needs_retry(req, req->errors)) {
-			req->retries++;
-			nvme_requeue_req(req);
-			return;
-		}
-
-		if (blk_rq_is_passthrough(req))
-			error = req->errors;
-		else
-			error = nvme_error_status(req->errors);
-	}
-
-	if (unlikely(iod->aborted)) {
-		dev_warn(dev->ctrl.device,
-			"completing aborted command with status: %04x\n",
-			req->errors);
-	}
-
-	blk_mq_end_request(req, error);
+	nvme_unmap_data(iod->nvmeq->dev, req);
+	nvme_complete_rq(req);
 }
 
 /* We read the CQE phase first to check if the rest of the entry is valid */
@@ -1131,7 +1109,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 
 static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
-	.complete	= nvme_complete_rq,
+	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_admin_init_hctx,
 	.exit_hctx      = nvme_admin_exit_hctx,
 	.init_request	= nvme_admin_init_request,
@@ -1140,7 +1118,7 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 
 static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
-	.complete	= nvme_complete_rq,
+	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
 	.map_queues	= nvme_pci_map_queues,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index db406ddd259c..963939ab4f61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1518,25 +1518,9 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_rdma_queue *queue = req->queue;
-	int error = 0;
 
-	nvme_rdma_unmap_data(queue, rq);
-
-	if (unlikely(rq->errors)) {
-		if (nvme_req_needs_retry(rq, rq->errors)) {
-			rq->retries++;
-			nvme_requeue_req(rq);
-			return;
-		}
-
-		if (blk_rq_is_passthrough(rq))
-			error = rq->errors;
-		else
-			error = nvme_error_status(rq->errors);
-	}
-
-	blk_mq_end_request(rq, error);
+	nvme_rdma_unmap_data(req->queue, rq);
+	nvme_complete_rq(rq);
 }
 
 static struct blk_mq_ops nvme_rdma_mq_ops = {
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 6a54e387379e..0d326d481d35 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -91,25 +91,10 @@ static inline int nvme_loop_queue_idx(struct nvme_loop_queue *queue)
 static void nvme_loop_complete_rq(struct request *req)
 {
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
-	int error = 0;
 
 	nvme_cleanup_cmd(req);
 	sg_free_table_chained(&iod->sg_table, true);
-
-	if (unlikely(req->errors)) {
-		if (nvme_req_needs_retry(req, req->errors)) {
-			req->retries++;
-			nvme_requeue_req(req);
-			return;
-		}
-
-		if (blk_rq_is_passthrough(req))
-			error = req->errors;
-		else
-			error = nvme_error_status(req->errors);
-	}
-
-	blk_mq_end_request(req, error);
+	nvme_complete_rq(req);
 }
 
 static struct blk_mq_tags *nvme_loop_tagset(struct nvme_loop_queue *queue)
-- 
2.11.0
