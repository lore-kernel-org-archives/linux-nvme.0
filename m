From: keith.busch@intel.com (Keith Busch)
Date: Mon,  8 Jun 2015 10:08:13 -0600
Subject: [PATCH 1/3] NVMe: Fix device cleanup on initialization failure
In-Reply-To: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
Message-ID: <1433779695-15866-2-git-send-email-keith.busch@intel.com>

Don't release block queue and tagging resoureces if the driver never
got them in the first place. This can happen if the controller fails to
become ready, if memory wasn't available to allocate a tagset or admin
queue, or if the resources were released as part of error recovery.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 2072ae8..8513321 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -193,6 +193,13 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
+static void nvme_admin_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	nvmeq->tags = NULL;
+}
+
 static int nvme_admin_init_request(void *data, struct request *req,
 				unsigned int hctx_idx, unsigned int rq_idx,
 				unsigned int numa_node)
@@ -1605,6 +1612,7 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
+	.exit_hctx      = nvme_admin_exit_hctx,
 	.init_request	= nvme_admin_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -1647,6 +1655,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		}
 		if (!blk_get_queue(dev->admin_q)) {
 			nvme_dev_remove_admin(dev);
+			dev->admin_q = NULL;
 			return -ENODEV;
 		}
 	} else
@@ -2733,8 +2742,10 @@ static void nvme_free_dev(struct kref *kref)
 	put_device(dev->device);
 	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
-	blk_mq_free_tag_set(&dev->tagset);
-	blk_put_queue(dev->admin_q);
+	if (dev->tagset.tags)
+		blk_mq_free_tag_set(&dev->tagset);
+	if (dev->admin_q)
+		blk_put_queue(dev->admin_q);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2865,6 +2876,9 @@ static int nvme_dev_start(struct nvme_dev *dev)
 
  free_tags:
 	nvme_dev_remove_admin(dev);
+	blk_put_queue(dev->admin_q);
+	dev->admin_q = NULL;
+	dev->queues[0]->tags = NULL;
  disable:
 	nvme_disable_queue(dev, 0);
 	nvme_dev_list_remove(dev);
-- 
1.7.10.4
