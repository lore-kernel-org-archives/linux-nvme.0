From: hch@lst.de (Christoph Hellwig)
Date: Thu,  7 May 2015 09:38:13 +0200
Subject: [PATCH 1/2] block: use an atomic_t for mq_freeze_depth
In-Reply-To: <1430984294-25859-1-git-send-email-hch@lst.de>
References: <1430984294-25859-1-git-send-email-hch@lst.de>
Message-ID: <1430984294-25859-2-git-send-email-hch@lst.de>

lockdep gets unhappy about the not disabling irqs when using the queue_lock
around it.  Instead of trying to fix that up just switch to an atomic_t
and get rid of the lock.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c         | 24 ++++++++++--------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ade8a2d..9f554bb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -89,7 +89,8 @@ static int blk_mq_queue_enter(struct request_queue *q, gfp_t gfp)
 			return -EBUSY;
 
 		ret = wait_event_interruptible(q->mq_freeze_wq,
-				!q->mq_freeze_depth || blk_queue_dying(q));
+				!atomic_read(&q->mq_freeze_depth) ||
+				blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
 		if (ret)
@@ -112,13 +113,10 @@ static void blk_mq_usage_counter_release(struct percpu_ref *ref)
 
 void blk_mq_freeze_queue_start(struct request_queue *q)
 {
-	bool freeze;
+	int freeze_depth;
 
-	spin_lock_irq(q->queue_lock);
-	freeze = !q->mq_freeze_depth++;
-	spin_unlock_irq(q->queue_lock);
-
-	if (freeze) {
+	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
+	if (freeze_depth == 1) {
 		percpu_ref_kill(&q->mq_usage_counter);
 		blk_mq_run_hw_queues(q, false);
 	}
@@ -143,13 +141,11 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
-	bool wake;
+	int freeze_depth;
 
-	spin_lock_irq(q->queue_lock);
-	wake = !--q->mq_freeze_depth;
-	WARN_ON_ONCE(q->mq_freeze_depth < 0);
-	spin_unlock_irq(q->queue_lock);
-	if (wake) {
+	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
+	WARN_ON_ONCE(freeze_depth < 0);
+	if (!freeze_depth) {
 		percpu_ref_reinit(&q->mq_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
@@ -2047,7 +2043,7 @@ void blk_mq_free_queue(struct request_queue *q)
 /* Basically redo blk_mq_init_queue with queue frozen */
 static void blk_mq_queue_reinit(struct request_queue *q)
 {
-	WARN_ON_ONCE(!q->mq_freeze_depth);
+	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
 
 	blk_mq_sysfs_unregister(q);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a7f7c23..a10bed8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -443,7 +443,7 @@ struct request_queue {
 	struct mutex		sysfs_lock;
 
 	int			bypass_depth;
-	int			mq_freeze_depth;
+	atomic_t		mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
 	bsg_job_fn		*bsg_job_fn;
-- 
1.9.1
