From: keith.busch@intel.com (Keith Busch)
Date: Mon,  1 Jun 2015 09:29:54 -0600
Subject: [PATCHv2 2/2] NVMe: Remove hctx reliance for multi-namespace
In-Reply-To: <1433172594-32127-1-git-send-email-keith.busch@intel.com>
References: <1433172594-32127-1-git-send-email-keith.busch@intel.com>
Message-ID: <1433172594-32127-2-git-send-email-keith.busch@intel.com>

The driver needs to track shared tags to support multiple namespaces
that may be dynamically allocated or deleted. Relying on the first
request_queue's hctx's is not appropriate as we cannot clear outstanding
tags for all namespaces using this handle, nor can the driver easily track
all request_queue's hctx as namespaces are attached/detached. Instead,
this patch uses the nvme_dev's tagset to get the shared tag resources
instead of through a request_queue hctx.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

  Obtain reference to blk_mq_tags through the device's tagset instead
  of requiring additional blk-mq ops.

 drivers/block/nvme-core.c |   52 +++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c42bc53..4899c45 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -102,6 +102,7 @@ struct nvme_queue {
 	spinlock_t q_lock;
 	struct nvme_command *sq_cmds;
 	volatile struct nvme_completion *cqes;
+	struct blk_mq_tags **tags;
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
@@ -114,7 +115,6 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 	struct async_cmd_info cmdinfo;
-	struct blk_mq_hw_ctx *hctx;
 };
 
 /*
@@ -182,9 +182,12 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	struct nvme_dev *dev = data;
 	struct nvme_queue *nvmeq = dev->queues[0];
 
-	WARN_ON(nvmeq->hctx);
-	nvmeq->hctx = hctx;
+	WARN_ON(hctx_idx != 0);
+	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
+	WARN_ON(nvmeq->tags);
+
 	hctx->driver_data = nvmeq;
+	nvmeq->tags = &dev->admin_tagset.tags[0];
 	return 0;
 }
 
@@ -201,27 +204,16 @@ static int nvme_admin_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
-{
-	struct nvme_queue *nvmeq = hctx->driver_data;
-
-	nvmeq->hctx = NULL;
-}
-
 static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 			  unsigned int hctx_idx)
 {
 	struct nvme_dev *dev = data;
-	struct nvme_queue *nvmeq = dev->queues[
-					(hctx_idx % dev->queue_count) + 1];
-
-	if (!nvmeq->hctx)
-		nvmeq->hctx = hctx;
+	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
 
-	/* nvmeq queues are shared between namespaces. We assume here that
-	 * blk-mq map the tags so they match up with the nvme queue tags. */
-	WARN_ON(nvmeq->hctx->tags != hctx->tags);
+	if (!nvmeq->tags)
+		nvmeq->tags = &dev->tagset.tags[hctx_idx];
 
+	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
 	hctx->driver_data = nvmeq;
 	return 0;
 }
@@ -320,7 +312,7 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 	u32 result = le32_to_cpup(&cqe->result);
 
-	blk_mq_free_hctx_request(nvmeq->hctx, req);
+	blk_mq_free_request(req);
 
 	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
 	++nvmeq->dev->abort_limit;
@@ -333,14 +325,13 @@ static void async_completion(struct nvme_queue *nvmeq, void *ctx,
 	cmdinfo->result = le32_to_cpup(&cqe->result);
 	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
 	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
-	blk_mq_free_hctx_request(nvmeq->hctx, cmdinfo->req);
+	blk_mq_free_request(cmdinfo->req);
 }
 
 static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
 				  unsigned int tag)
 {
-	struct blk_mq_hw_ctx *hctx = nvmeq->hctx;
-	struct request *req = blk_mq_tag_to_rq(hctx->tags, tag);
+	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, tag);
 
 	return blk_mq_rq_to_pdu(req);
 }
@@ -1067,7 +1058,7 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = req->tag;
 
-	blk_mq_free_hctx_request(nvmeq->hctx, req);
+	blk_mq_free_request(req);
 	return __nvme_submit_cmd(nvmeq, &c);
 }
 
@@ -1309,8 +1300,7 @@ static void nvme_abort_req(struct request *req)
 	}
 }
 
-static void nvme_cancel_queue_ios(struct blk_mq_hw_ctx *hctx,
-				struct request *req, void *data, bool reserved)
+static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
 {
 	struct nvme_queue *nvmeq = data;
 	void *ctx;
@@ -1407,11 +1397,9 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 
 static void nvme_clear_queue(struct nvme_queue *nvmeq)
 {
-	struct blk_mq_hw_ctx *hctx = nvmeq->hctx;
-
 	spin_lock_irq(&nvmeq->q_lock);
-	if (hctx && hctx->tags)
-		blk_mq_tag_busy_iter(hctx, nvme_cancel_queue_ios, nvmeq);
+	if (nvmeq->tags && *nvmeq->tags)
+		blk_mq_all_tag_busy_iter(*nvmeq->tags, nvme_cancel_queue_ios, nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
@@ -1604,7 +1592,6 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
-	.exit_hctx	= nvme_exit_hctx,
 	.init_request	= nvme_admin_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -1613,7 +1600,6 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
-	.exit_hctx	= nvme_exit_hctx,
 	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -2723,11 +2709,11 @@ static void nvme_set_irq_hints(struct nvme_dev *dev)
 	for (i = 0; i < dev->online_queues; i++) {
 		nvmeq = dev->queues[i];
 
-		if (!nvmeq->hctx)
+		if (!nvmeq->tags || !(*nvmeq->tags))
 			continue;
 
 		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-							nvmeq->hctx->cpumask);
+					blk_mq_tags_cpumask(*nvmeq->tags));
 	}
 }
 
-- 
1.7.10.4
