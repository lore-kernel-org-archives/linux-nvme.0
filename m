From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 Oct 2015 16:13:36 -0600
Subject: [PATCH] NVMe: Fix memory leak on retried commands
Message-ID: <1444774416-12648-1-git-send-email-keith.busch@intel.com>

Resources are reallocated for requeued commands, so unmap and release
the iod for the failed command.

Cc: Jens Axboe <axboe at fb.com>
Cc: stable at vger.kernel.org
Cc: <stable at vger.kernel.org> # 4.0.x-
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Hi Jens,

If you're okay with this fix, it needs to get to 4.0, 4.1 and 4.2 stable,
and might cause some issues merging with your 'for-next' branch. This
is based on 'for-linus' since this urgently needs to get fixed in 4.3.
The 3.19 kernel is okay because we reused the iod in req->special.

Thanks!
Keith

 drivers/block/nvme-core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3a81df9..d5399fb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -603,6 +603,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	struct nvme_iod *iod = ctx;
 	struct request *req = iod_get_private(iod);
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
+	bool requeue = false;
 
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 
@@ -611,12 +612,13 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 		    && (jiffies - req->start_time) < req->timeout) {
 			unsigned long flags;
 
+			requeue = true;
 			blk_mq_requeue_request(req);
 			spin_lock_irqsave(req->q->queue_lock, flags);
 			if (!blk_queue_stopped(req->q))
 				blk_mq_kick_requeue_list(req->q);
 			spin_unlock_irqrestore(req->q->queue_lock, flags);
-			return;
+			goto release_iod;
 		}
 
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
@@ -637,6 +639,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 			"completing aborted command with status:%04x\n",
 			status);
 
+ release_iod:
 	if (iod->nents) {
 		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
 			rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
@@ -649,7 +652,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	}
 	nvme_free_iod(nvmeq->dev, iod);
 
-	blk_mq_complete_request(req, status);
+	if (likely(!requeue))
+		blk_mq_complete_request(req, status);
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
-- 
1.7.10.4
