From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 26 Oct 2016 15:56:04 -0700
Subject: [PATCH 11/12] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
Message-ID: <805e1911-cd10-0563-c76b-256d76054b08@sandisk.com>

Make nvme_requeue_req() check BLK_MQ_S_STOPPED instead of
QUEUE_FLAG_STOPPED. Remove the QUEUE_FLAG_STOPPED manipulations
that became superfluous because of this change. Change
blk_queue_stopped() tests into blk_mq_queue_stopped().

This patch fixes a race condition: using queue_flag_clear_unlocked()
is not safe if any other function that manipulates the queue flags
can be called concurrently, e.g. blk_cleanup_queue().

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bb73ba..b662416 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -205,7 +205,7 @@ void nvme_requeue_req(struct request *req)
 
 	blk_mq_requeue_request(req, false);
 	spin_lock_irqsave(req->q->queue_lock, flags);
-	if (!blk_queue_stopped(req->q))
+	if (!blk_mq_queue_stopped(req->q))
 		blk_mq_kick_requeue_list(req->q);
 	spin_unlock_irqrestore(req->q->queue_lock, flags);
 }
@@ -2079,10 +2079,6 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		spin_lock_irq(ns->queue->queue_lock);
-		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
-		spin_unlock_irq(ns->queue->queue_lock);
-
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
@@ -2096,7 +2092,6 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
-- 
2.10.1
