From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Nov 2018 20:13:09 +0100
Subject: [PATCH 12/13] block: only allow polling if a poll queue_map exists
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
Message-ID: <20181129191310.9795-13-hch@lst.de>

This avoids having to have differnet mq_ops for different setups
with or without poll queues.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-sysfs.c       |  2 +-
 drivers/nvme/host/pci.c | 29 +++++++++--------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f0cb370b39b..bb7c642ffefa 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -402,7 +402,7 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	unsigned long poll_on;
 	ssize_t ret;
 
-	if (!q->mq_ops || !q->mq_ops->poll)
+	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL)
 		return -EINVAL;
 
 	ret = queue_var_store(&poll_on, page, count);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d43925fba560..3ecc0bf75a62 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1600,22 +1600,15 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.timeout	= nvme_timeout,
 };
 
-#define NVME_SHARED_MQ_OPS					\
-	.queue_rq		= nvme_queue_rq,		\
-	.commit_rqs		= nvme_commit_rqs,		\
-	.complete		= nvme_pci_complete_rq,		\
-	.init_hctx		= nvme_init_hctx,		\
-	.init_request		= nvme_init_request,		\
-	.map_queues		= nvme_pci_map_queues,		\
-	.timeout		= nvme_timeout			\
-
 static const struct blk_mq_ops nvme_mq_ops = {
-	NVME_SHARED_MQ_OPS,
-};
-
-static const struct blk_mq_ops nvme_mq_poll_ops = {
-	NVME_SHARED_MQ_OPS,
-	.poll			= nvme_poll,
+	.queue_rq	= nvme_queue_rq,
+	.complete	= nvme_pci_complete_rq,
+	.commit_rqs	= nvme_commit_rqs,
+	.init_hctx	= nvme_init_hctx,
+	.init_request	= nvme_init_request,
+	.map_queues	= nvme_pci_map_queues,
+	.timeout	= nvme_timeout,
+	.poll		= nvme_poll,
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
@@ -2302,11 +2295,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	int ret;
 
 	if (!dev->ctrl.tagset) {
-		if (dev->io_queues[HCTX_TYPE_POLL])
-			dev->tagset.ops = &nvme_mq_poll_ops;
-		else
-			dev->tagset.ops = &nvme_mq_ops;
-
+		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
 		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
-- 
2.19.1
