From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Nov 2018 20:13:01 +0100
Subject: [PATCH 04/13] nvme-pci: only allow polling with separate poll queues
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
Message-ID: <20181129191310.9795-5-hch@lst.de>

This will allow us to simplify both the regular NVMe interrupt handler
and the upcoming aio poll code.  In addition to that the separate
queues are generally a good idea for performance reasons.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b820dd0351cb..d42bb76e5e78 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1089,13 +1089,6 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx)
-{
-	struct nvme_queue *nvmeq = hctx->driver_data;
-
-	return __nvme_poll(nvmeq, -1);
-}
-
-static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	u16 start, end;
@@ -1605,12 +1598,11 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	NVME_SHARED_MQ_OPS,
-	.poll			= nvme_poll,
 };
 
-static const struct blk_mq_ops nvme_mq_poll_noirq_ops = {
+static const struct blk_mq_ops nvme_mq_poll_ops = {
 	NVME_SHARED_MQ_OPS,
-	.poll			= nvme_poll_noirq,
+	.poll			= nvme_poll,
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
@@ -2298,10 +2290,10 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	int ret;
 
 	if (!dev->ctrl.tagset) {
-		if (!dev->io_queues[HCTX_TYPE_POLL])
-			dev->tagset.ops = &nvme_mq_ops;
+		if (dev->io_queues[HCTX_TYPE_POLL])
+			dev->tagset.ops = &nvme_mq_poll_ops;
 		else
-			dev->tagset.ops = &nvme_mq_poll_noirq_ops;
+			dev->tagset.ops = &nvme_mq_ops;
 
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
 		dev->tagset.nr_maps = HCTX_MAX_TYPES;
-- 
2.19.1
