From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Jun 2017 09:15:18 +0200
Subject: [PATCH 1/4] nvme-pci: merge init_request methods
Message-ID: <20170613071521.5191-1-hch@lst.de>

Now that we get the tagset passed we can have a single implementation for
the I/O and admin queues.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 788bb2c479d0..94504fbc404e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -348,19 +348,6 @@ static void nvme_admin_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_i
 	nvmeq->tags = NULL;
 }
 
-static int nvme_admin_init_request(struct blk_mq_tag_set *set,
-		struct request *req, unsigned int hctx_idx,
-		unsigned int numa_node)
-{
-	struct nvme_dev *dev = set->driver_data;
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = dev->queues[0];
-
-	BUG_ON(!nvmeq);
-	iod->nvmeq = nvmeq;
-	return 0;
-}
-
 static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 			  unsigned int hctx_idx)
 {
@@ -380,7 +367,8 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 {
 	struct nvme_dev *dev = set->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
+	int queue_idx = (set == &dev->tagset) ? hctx_idx + 1 : 0;
+	struct nvme_queue *nvmeq = dev->queues[queue_idx];
 
 	BUG_ON(!nvmeq);
 	iod->nvmeq = nvmeq;
@@ -1299,7 +1287,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_admin_init_hctx,
 	.exit_hctx      = nvme_admin_exit_hctx,
-	.init_request	= nvme_admin_init_request,
+	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
 };
 
-- 
2.11.0
