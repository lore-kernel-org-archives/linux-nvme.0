From: axboe@fb.com (Jens Axboe)
Date: Thu, 11 Dec 2014 13:33:59 -0700
Subject: [PATCH] NVMe: fix retry/error logic in nvme_queue_rq()
Message-ID: <20141211203359.GA14132@kernel.dk>

Hi,

The logic around retrying and erroring IO in nvme_queue_rq() is broken
in a few ways:

- If we fail allocating dma memory for a discard, we return retry. We
  have the 'iod' stored in ->special, but we free the 'iod'.

- For a normal request, if we fail dma mapping of setting up prps, we
  have the same iod situation. Additionally, we haven't set the callback
  for the request yet, so we also potentially leak IOMMU resources.

Get rid of the ->special 'iod' store. The retry is uncommon enough that
it's not worth optimizing for or holding on to resources to attempt to
speed it up. Additionally, it's usually best practice to free any
request related resources when doing retries.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 95f2310255ce..e92bdf4c68fc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -621,24 +621,15 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
 	struct nvme_iod *iod;
 	int psegs = req->nr_phys_segments;
-	int result = BLK_MQ_RQ_QUEUE_BUSY;
 	enum dma_data_direction dma_dir;
 	unsigned size = !(req->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(req) :
 						sizeof(struct nvme_dsm_range);
 
-	/*
-	 * Requeued IO has already been prepped
-	 */
-	iod = req->special;
-	if (iod)
-		goto submit_iod;
-
 	iod = nvme_alloc_iod(psegs, size, ns->dev, GFP_ATOMIC);
 	if (!iod)
-		return result;
+		return BLK_MQ_RQ_QUEUE_BUSY;
 
 	iod->private = req;
-	req->special = iod;
 
 	if (req->cmd_flags & REQ_DISCARD) {
 		void *range;
@@ -651,7 +642,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 						GFP_ATOMIC,
 						&iod->first_dma);
 		if (!range)
-			goto finish_cmd;
+			goto retry_cmd;
 		iod_list(iod)[0] = (__le64 *)range;
 		iod->npages = 0;
 	} else if (psegs) {
@@ -659,22 +650,22 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 		sg_init_table(iod->sg, psegs);
 		iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
-		if (!iod->nents) {
-			result = BLK_MQ_RQ_QUEUE_ERROR;
-			goto finish_cmd;
-		}
+		if (!iod->nents)
+			goto error_cmd;
 
 		if (!dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir))
-			goto finish_cmd;
+			goto retry_cmd;
 
-		if (blk_rq_bytes(req) != nvme_setup_prps(nvmeq->dev, iod,
-						blk_rq_bytes(req), GFP_ATOMIC))
-			goto finish_cmd;
+		if (blk_rq_bytes(req) !=
+                    nvme_setup_prps(nvmeq->dev, iod, blk_rq_bytes(req), GFP_ATOMIC)) {
+			dma_unmap_sg(&nvmeq->dev->pci_dev->dev, iod->sg,
+					iod->nents, dma_dir);
+			goto retry_cmd;
+		}
 	}
 
 	blk_mq_start_request(req);
 
- submit_iod:
 	nvme_set_info(cmd, iod, req_completion);
 	spin_lock_irq(&nvmeq->q_lock);
 	if (req->cmd_flags & REQ_DISCARD)
@@ -688,10 +679,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_MQ_RQ_QUEUE_OK;
 
- finish_cmd:
-	nvme_finish_cmd(nvmeq, req->tag, NULL);
+ error_cmd:
 	nvme_free_iod(nvmeq->dev, iod);
-	return result;
+	return BLK_MQ_RQ_QUEUE_ERROR;
+ retry_cmd:
+	nvme_free_iod(nvmeq->dev, iod);
+	return BLK_MQ_RQ_QUEUE_BUSY;
 }
 
 static int nvme_process_cq(struct nvme_queue *nvmeq)

Signed-off-by: Jens Axboe <axboe at fb.com>

-- 
Jens Axboe
