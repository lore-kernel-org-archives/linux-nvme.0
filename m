From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 May 2015 12:37:02 -0600
Subject: [PATCH 2/2] NVMe: Remove hctx reliance for multi-namespace
In-Reply-To: <1432838222-4076-1-git-send-email-keith.busch@intel.com>
References: <1432838222-4076-1-git-send-email-keith.busch@intel.com>
Message-ID: <1432838222-4076-2-git-send-email-keith.busch@intel.com>

The driver needs to track shared tags to support multiple namespaces
that may be dynamically allocated or deleted. Previously relying on
the first request_queue's hctx's is not appropriate as we cannot clear
the outstanding tags for all namespaces on controller failure using
this handle, nor can we readily track each request_queue's hctx's as
namespaces are allocated and deleted. Instead, use the tags directly
instead of through the unshared h/w contetxts.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c |   58 +++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c42bc53..851dc9a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -114,7 +114,7 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 	struct async_cmd_info cmdinfo;
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_tags *tags;
 };
 
 /*
@@ -182,8 +182,8 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	struct nvme_dev *dev = data;
 	struct nvme_queue *nvmeq = dev->queues[0];
 
-	WARN_ON(nvmeq->hctx);
-	nvmeq->hctx = hctx;
+	WARN_ON(nvmeq->tags);
+	nvmeq->tags = hctx->tags;
 	hctx->driver_data = nvmeq;
 	return 0;
 }
@@ -201,11 +201,23 @@ static int nvme_admin_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+static void nvme_exit_tags(void *data, unsigned int hctx_idx)
 {
-	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_dev *dev = data;
+	struct nvme_queue *nvmeq = dev->queues[
+					(hctx_idx % dev->queue_count) + 1];
+	nvmeq->tags = NULL;
+}
 
-	nvmeq->hctx = NULL;
+static int nvme_init_tags(struct blk_mq_tags *tags, void *data,
+			  unsigned int hctx_idx)
+{
+	struct nvme_dev *dev = data;
+	struct nvme_queue *nvmeq = dev->queues[
+					(hctx_idx % dev->queue_count) + 1];
+	WARN_ON(nvmeq->tags);
+	nvmeq->tags = tags;
+	return 0;
 }
 
 static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -215,12 +227,9 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	struct nvme_queue *nvmeq = dev->queues[
 					(hctx_idx % dev->queue_count) + 1];
 
-	if (!nvmeq->hctx)
-		nvmeq->hctx = hctx;
-
 	/* nvmeq queues are shared between namespaces. We assume here that
 	 * blk-mq map the tags so they match up with the nvme queue tags. */
-	WARN_ON(nvmeq->hctx->tags != hctx->tags);
+	WARN_ON(nvmeq->tags != hctx->tags);
 
 	hctx->driver_data = nvmeq;
 	return 0;
@@ -320,7 +329,7 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 	u32 result = le32_to_cpup(&cqe->result);
 
-	blk_mq_free_hctx_request(nvmeq->hctx, req);
+	blk_mq_free_request(req);
 
 	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
 	++nvmeq->dev->abort_limit;
@@ -333,14 +342,13 @@ static void async_completion(struct nvme_queue *nvmeq, void *ctx,
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
+	struct request *req = blk_mq_tag_to_rq(nvmeq->tags, tag);
 
 	return blk_mq_rq_to_pdu(req);
 }
@@ -1067,7 +1075,7 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = req->tag;
 
-	blk_mq_free_hctx_request(nvmeq->hctx, req);
+	blk_mq_free_request(req);
 	return __nvme_submit_cmd(nvmeq, &c);
 }
 
@@ -1309,8 +1317,7 @@ static void nvme_abort_req(struct request *req)
 	}
 }
 
-static void nvme_cancel_queue_ios(struct blk_mq_hw_ctx *hctx,
-				struct request *req, void *data, bool reserved)
+static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
 {
 	struct nvme_queue *nvmeq = data;
 	void *ctx;
@@ -1407,11 +1414,10 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 
 static void nvme_clear_queue(struct nvme_queue *nvmeq)
 {
-	struct blk_mq_hw_ctx *hctx = nvmeq->hctx;
-
 	spin_lock_irq(&nvmeq->q_lock);
-	if (hctx && hctx->tags)
-		blk_mq_tag_busy_iter(hctx, nvme_cancel_queue_ios, nvmeq);
+	if (nvmeq->tags)
+		blk_mq_all_tag_busy_iter(nvmeq->tags, nvme_cancel_queue_ios,
+								nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
@@ -1604,7 +1610,6 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
-	.exit_hctx	= nvme_exit_hctx,
 	.init_request	= nvme_admin_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -1613,7 +1618,8 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
-	.exit_hctx	= nvme_exit_hctx,
+	.init_tags	= nvme_init_tags,
+	.exit_tags	= nvme_exit_tags,
 	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -2652,6 +2658,7 @@ static void nvme_free_dev(struct kref *kref)
 	nvme_release_instance(dev);
 	blk_mq_free_tag_set(&dev->tagset);
 	blk_put_queue(dev->admin_q);
+	nvme_free_queues(dev, 0);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2723,11 +2730,11 @@ static void nvme_set_irq_hints(struct nvme_dev *dev)
 	for (i = 0; i < dev->online_queues; i++) {
 		nvmeq = dev->queues[i];
 
-		if (!nvmeq->hctx)
+		if (!nvmeq->tags)
 			continue;
 
 		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-							nvmeq->hctx->cpumask);
+					blk_mq_tags_cpumask(nvmeq->tags));
 	}
 }
 
@@ -2969,7 +2976,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
 	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
-	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.7.10.4
