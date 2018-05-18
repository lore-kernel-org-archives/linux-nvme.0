From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 08:52:32 -0600
Subject: [PATCH 4/7] nvme-pci: move ->cq_vector == -1 check outside of ->q_lock
In-Reply-To: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526655155-4006-5-git-send-email-axboe@kernel.dk>

We only clear it dynamically in nvme_suspend_queue(). When we do, ensure
to do a full flush so that any nvme_queue_rq() invocation will see it.

Ideally we'd kill this check completely, but we're using it to flush
requests on a dying queue.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9b32a67982e8..bfd7023877a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -871,6 +871,13 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	blk_status_t ret;
 
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(nvmeq->cq_vector < 0))
+		return BLK_STS_IOERR;
+
 	ret = nvme_setup_cmd(ns, req, &cmnd);
 	if (ret)
 		return ret;
@@ -888,11 +895,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(req);
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (unlikely(nvmeq->cq_vector < 0)) {
-		ret = BLK_STS_IOERR;
-		spin_unlock_irq(&nvmeq->q_lock);
-		goto out_cleanup_iod;
-	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_STS_OK;
@@ -1329,6 +1331,12 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
 
+	/*
+	 * Ensure that nvme_queue_rq() sees it ->cq_vector == -1 without
+	 * having to grab the lock.
+	 */
+	mb();
+
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
 
-- 
2.7.4
