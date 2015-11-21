From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:28:25 +0100
Subject: [PATCH 07/16] nvme: factor out a nvme_unmap_data helper
In-Reply-To: <1448090914-13121-1-git-send-email-hch@lst.de>
References: <1448090914-13121-1-git-send-email-hch@lst.de>
Message-ID: <1448090914-13121-8-git-send-email-hch@lst.de>

This is the counter part to nvme_map_data.  The forward declaration will
go away later in the series.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cc91938..1a9966d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -75,10 +75,12 @@ static wait_queue_head_t nvme_kthread_wait;
 
 struct nvme_dev;
 struct nvme_queue;
+struct nvme_iod;
 
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
+static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_iod *iod);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -601,7 +603,6 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	struct request *req = iod_get_private(iod);
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
-	bool requeue = false;
 	int error = 0;
 
 	if (unlikely(status)) {
@@ -609,13 +610,14 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 		    && (jiffies - req->start_time) < req->timeout) {
 			unsigned long flags;
 
-			requeue = true;
+			nvme_unmap_data(nvmeq->dev, iod);
+
 			blk_mq_requeue_request(req);
 			spin_lock_irqsave(req->q->queue_lock, flags);
 			if (!blk_queue_stopped(req->q))
 				blk_mq_kick_requeue_list(req->q);
 			spin_unlock_irqrestore(req->q->queue_lock, flags);
-			goto release_iod;
+			return;
 		}
 
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
@@ -638,21 +640,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 			"completing aborted command with status:%04x\n",
 			error);
 
-release_iod:
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
-	if (likely(!requeue))
-		blk_mq_complete_request(req, error);
+	nvme_unmap_data(nvmeq->dev, iod);
+	blk_mq_complete_request(req, error);
 }
 
 static bool nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
@@ -783,6 +772,24 @@ out:
 	return ret;
 }
 
+static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_iod *iod)
+{
+	struct request *req = iod_get_private(iod);
+	enum dma_data_direction dma_dir = rq_data_dir(req) ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
+	if (iod->nents) {
+		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+		if (blk_integrity_rq(req)) {
+			if (!rq_data_dir(req))
+				nvme_dif_remap(req, nvme_dif_complete);
+			dma_unmap_sg(dev->dev, iod->meta_sg, 1, dma_dir);
+		}
+	}
+
+	nvme_free_iod(dev, iod);
+}
+
 /*
  * We reuse the small pool to allocate the 16-byte range here as it is not
  * worth having a special pool for these or additional cases to handle freeing
-- 
1.9.1
