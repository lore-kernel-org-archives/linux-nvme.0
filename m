From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 May 2015 13:30:21 -0600
Subject: [PATCH 2/4] NVMe: Decouple nvmeq hctx from ns request queue
In-Reply-To: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
Message-ID: <1431977423-31587-3-git-send-email-keith.busch@intel.com>

Preparing for namespaces to dynamically attach/detach, we can't tie
the nvmeq's hctx to a namespace request queue: they may be removed at
any time. This patch has the driver create an io request queue that
unaffiliated to any namespace so we always have a valid hctx for the
io queues.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   26 ++++++++++++++++----------
 include/linux/nvme.h      |    1 +
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036..bd36d34 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -201,13 +201,6 @@ static int nvme_admin_init_request(void *data, struct request *req,
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
@@ -1550,7 +1543,6 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_admin_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
-	.exit_hctx	= nvme_exit_hctx,
 	.init_request	= nvme_admin_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -1559,7 +1551,6 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
-	.exit_hctx	= nvme_exit_hctx,
 	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -2337,6 +2328,17 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (blk_mq_alloc_tag_set(&dev->tagset))
 		return 0;
 
+	dev->io_q = blk_mq_init_queue(&dev->tagset);
+	if (IS_ERR(dev->io_q)) {
+		blk_mq_free_tag_set(&dev->tagset);
+		return 0;
+	}
+	if (!blk_get_queue(dev->io_q)) {
+		blk_cleanup_queue(dev->io_q);
+		blk_mq_free_tag_set(&dev->tagset);
+		return 0;
+	}
+
 	for (i = 1; i <= nn; i++)
 		nvme_alloc_ns(dev, i);
 
@@ -2727,7 +2729,11 @@ static void nvme_free_dev(struct kref *kref)
 	put_device(dev->device);
 	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
-	blk_mq_free_tag_set(&dev->tagset);
+	if (!IS_ERR_OR_NULL(dev->io_q)) {
+		blk_cleanup_queue(dev->io_q);
+		blk_mq_free_tag_set(&dev->tagset);
+		blk_put_queue(dev->io_q);
+	}
 	blk_put_queue(dev->admin_q);
 	kfree(dev->queues);
 	kfree(dev->entry);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8dbd05e..013c38f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -71,6 +71,7 @@ struct nvme_dev {
 	struct list_head node;
 	struct nvme_queue **queues;
 	struct request_queue *admin_q;
+	struct request_queue *io_q;
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
-- 
1.7.10.4
