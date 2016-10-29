From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 28 Oct 2016 17:20:49 -0700
Subject: [PATCH v5 06/14] blk-mq: Remove blk_mq_cancel_requeue_work()
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Message-ID: <7207b8ad-aec9-b7d8-e36b-8c360bf32f06@sandisk.com>

Since blk_mq_requeue_work() no longer restarts stopped queues
canceling requeue work is no longer needed to prevent that a
stopped queue would be restarted. Hence remove this function.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Mike Snitzer <snitzer at redhat.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Hannes Reinecke <hare at suse.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Johannes Thumshirn <jthumshirn at suse.de>
---
 block/blk-mq.c           | 6 ------
 drivers/md/dm-rq.c       | 2 --
 drivers/nvme/host/core.c | 1 -
 include/linux/blk-mq.h   | 1 -
 4 files changed, 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fe367b5..534128a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -528,12 +528,6 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
 }
 EXPORT_SYMBOL(blk_mq_add_to_requeue_list);
 
-void blk_mq_cancel_requeue_work(struct request_queue *q)
-{
-	cancel_delayed_work_sync(&q->requeue_work);
-}
-EXPORT_SYMBOL_GPL(blk_mq_cancel_requeue_work);
-
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
 	kblockd_schedule_delayed_work(&q->requeue_work, 0);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 1794de5..2b82496 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -116,8 +116,6 @@ static void dm_mq_stop_queue(struct request_queue *q)
 	queue_flag_set(QUEUE_FLAG_STOPPED, q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	/* Avoid that requeuing could restart the queue. */
-	blk_mq_cancel_requeue_work(q);
 	blk_mq_stop_hw_queues(q);
 }
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79e679d..ab5f59e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2083,7 +2083,6 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
 
-		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index aa93000..a85a20f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -217,7 +217,6 @@ void __blk_mq_end_request(struct request *rq, int error);
 
 void blk_mq_requeue_request(struct request *rq);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
-void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_abort_requeue_list(struct request_queue *q);
-- 
2.10.1
