From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:57 +0200
Subject: [PATCH 09/10] nvme: properly free resources for cancelled command
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-10-git-send-email-hch@lst.de>

We need to move freeing of resources to the ->complete handler to ensure
they are also freed when we cancel the command.

Clear the QUEUE_FLAG_SAME_COMP flag to ensure we don't try to bounce to
another CPU because we now have a ->complete handler.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 57 +++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 94c1ec2..e882915 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -471,8 +471,6 @@ static void nvme_finish_cmd(struct nvme_queue *nvmeq,
 		struct nvme_completion *cqe)
 {
 	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
-	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
-	struct nvme_iod *iod = cmd_rq->iod;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 
 	if (unlikely(status)) {
@@ -497,23 +495,6 @@ static void nvme_finish_cmd(struct nvme_queue *nvmeq,
 		req->special = (void *)(uintptr_t)result;
 	}
 
-	if (cmd_rq->aborted)
-		dev_warn(nvmeq->dev->dev,
-			"completing aborted command with status:%04x\n",
-			status);
-
-	if (iod->nents) {
-		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
-			rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		if (blk_integrity_rq(req)) {
-			if (!rq_data_dir(req))
-				nvme_dif_remap(req, nvme_dif_complete);
-			dma_unmap_sg(nvmeq->dev->dev, iod->meta_sg, 1,
-				rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		}
-	}
-	nvme_free_iod(nvmeq->dev, iod);
-
 	blk_mq_complete_request(req, status);
 }
 
@@ -808,6 +789,34 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_BUSY;
 }
 
+static void nvme_complete_rq(struct request *req)
+{
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = cmd->nvmeq;
+	struct nvme_iod *iod = cmd->iod;
+
+	if (cmd->aborted) {
+		dev_warn(nvmeq->dev->dev,
+			"completing aborted command with status:%04x\n",
+			req->errors);
+	}
+
+	if (iod->nents) {
+		enum dma_data_direction dir = rq_data_dir(req) ?
+					DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
+		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents, dir);
+		if (blk_integrity_rq(req)) {
+			if (!rq_data_dir(req))
+				nvme_dif_remap(req, nvme_dif_complete);
+			dma_unmap_sg(nvmeq->dev->dev, iod->meta_sg, 1, dir);
+		}
+	}
+
+	nvme_free_iod(nvmeq->dev, iod);
+	blk_mq_end_request(req, req->errors);
+}
+
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
 	u16 head, phase;
@@ -1549,6 +1558,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 
 static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.complete	= nvme_complete_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
 	.exit_hctx      = nvme_admin_exit_hctx,
@@ -1558,6 +1568,7 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 
 static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.complete	= nvme_complete_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
@@ -1597,6 +1608,10 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			dev->admin_q = NULL;
 			return -ENODEV;
 		}
+
+		/* we assume that we always have a local completion queue */
+		queue_flag_clear_unlocked(QUEUE_FLAG_SAME_COMP, dev->admin_q);
+
 		dev->admin_q->queuedata = dev;
 	} else
 		blk_mq_unfreeze_queue(dev->admin_q);
@@ -2023,6 +2038,10 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 		goto out_free_ns;
 	queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
+
+	/* we assume that we always have a local completion queue */
+	queue_flag_clear_unlocked(QUEUE_FLAG_SAME_COMP, ns->queue);
+
 	ns->dev = dev;
 	ns->queue->queuedata = ns;
 
-- 
1.9.1
