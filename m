From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 31 Mar 2016 14:19:13 -0600
Subject: [PATCH 1/2] block: add queue flag to always poll
In-Reply-To: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1459455554-2794-2-git-send-email-jonathan.derrick@intel.com>

This patch adds poll-by-default functionality back for 4.6 by adding a
queue flag which specifies that it should always try polling, rather
than only if the io specifies it.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 block/blk-core.c       | 8 ++++++++
 fs/direct-io.c         | 7 ++++++-
 include/linux/blkdev.h | 2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 827f8ba..d85f913 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3335,6 +3335,14 @@ void blk_finish_plug(struct blk_plug *plug)
 }
 EXPORT_SYMBOL(blk_finish_plug);
 
+bool blk_force_poll(struct request_queue *q)
+{
+	if (!q->mq_ops || !q->mq_ops->poll ||
+	    !test_bit(QUEUE_FLAG_POLL_FORCE, &q->queue_flags))
+		return false;
+	return true;
+}
+
 bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	struct blk_plug *plug;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 476f1ec..2775552 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -450,7 +450,12 @@ static struct bio *dio_await_one(struct dio *dio)
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		dio->waiter = current;
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
-		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
+		/*
+		 * Polling must be enabled explicitly on a per-IO basis,
+		 * or through the queue's sysfs io_poll_force control
+		 */
+		if (!((dio->iocb->ki_flags & IOCB_HIPRI) ||
+		      (blk_force_poll(bdev_get_queue(dio->bio_bdev)))) ||
 		    !blk_poll(bdev_get_queue(dio->bio_bdev), dio->bio_cookie))
 			io_schedule();
 		/* wake up sets us TASK_RUNNING */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7e5d7e0..e87ef17 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -491,6 +491,7 @@ struct request_queue {
 #define QUEUE_FLAG_INIT_DONE   20	/* queue is initialized */
 #define QUEUE_FLAG_NO_SG_MERGE 21	/* don't attempt to merge SG segments*/
 #define QUEUE_FLAG_POLL	       22	/* IO polling enabled if set */
+#define QUEUE_FLAG_POLL_FORCE  23	/* IO polling forced if set */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -824,6 +825,7 @@ extern int blk_execute_rq(struct request_queue *, struct gendisk *,
 extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
+bool blk_force_poll(struct request_queue *q);
 bool blk_poll(struct request_queue *q, blk_qc_t cookie);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-- 
2.5.0
