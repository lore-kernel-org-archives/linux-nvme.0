From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:36 +0100
Subject: [PATCH 01/26] block: defer timeouts to a workqueue
In-Reply-To: <1448995981-11982-1-git-send-email-hch@lst.de>
References: <1448995981-11982-1-git-send-email-hch@lst.de>
Message-ID: <1448995981-11982-2-git-send-email-hch@lst.de>

Timer context is not very useful for drivers to perform any meaningful abort
action from.  So instead of calling the driver from this useless context
defer it to a workqueue as soon as possible.

Note that while a delayed_work item would seem the right thing here I didn't
dare to use it due to the magic in blk_add_timer that pokes deep into timer
internals.  But maybe this encourages Tejun to add a sensible API for that to
the workqueue API and we'll all be fine in the end :)

Contains a major update from Keith Bush:

"This patch removes synchronizing the timeout work so that the timer can
 start a freeze on its own queue. The timer enters the queue, so timer
 context can only start a freeze, but not wait for frozen."

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-core.c       |  8 ++++++++
 block/blk-mq.c         | 11 ++++++++---
 block/blk-timeout.c    |  8 ++++++--
 block/blk.h            |  2 +-
 include/linux/blkdev.h |  1 +
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5ec9960..7e01002 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -664,6 +664,13 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 	wake_up_all(&q->mq_freeze_wq);
 }
 
+static void blk_rq_timed_out_timer(unsigned long data)
+{
+	struct request_queue *q = (struct request_queue *)data;
+
+	kblockd_schedule_work(&q->timeout_work);
+}
+
 struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	struct request_queue *q;
@@ -825,6 +832,7 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
 	if (blk_init_rl(&q->root_rl, q, GFP_KERNEL))
 		goto fail;
 
+	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	q->request_fn		= rfn;
 	q->prep_rq_fn		= NULL;
 	q->unprep_rq_fn		= NULL;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93a4e19..9cb2894 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -615,15 +615,19 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
-static void blk_mq_rq_timer(unsigned long priv)
+static void blk_mq_timeout_work(struct work_struct *work)
 {
-	struct request_queue *q = (struct request_queue *)priv;
+	struct request_queue *q =
+		container_of(work, struct request_queue, timeout_work);
 	struct blk_mq_timeout_data data = {
 		.next		= 0,
 		.next_set	= 0,
 	};
 	int i;
 
+	if (blk_queue_enter(q, true))
+		return;
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.next_set) {
@@ -638,6 +642,7 @@ static void blk_mq_rq_timer(unsigned long priv)
 				blk_mq_tag_idle(hctx);
 		}
 	}
+	blk_queue_exit(q);
 }
 
 /*
@@ -2015,7 +2020,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		hctxs[i]->queue_num = i;
 	}
 
-	setup_timer(&q->timeout, blk_mq_rq_timer, (unsigned long) q);
+	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
 	q->nr_queues = nr_cpu_ids;
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 3610af5..dd4fdfb 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -127,13 +127,16 @@ static void blk_rq_check_expired(struct request *rq, unsigned long *next_timeout
 	}
 }
 
-void blk_rq_timed_out_timer(unsigned long data)
+void blk_timeout_work(struct work_struct *work)
 {
-	struct request_queue *q = (struct request_queue *) data;
+	struct request_queue *q =
+		container_of(work, struct request_queue, timeout_work);
 	unsigned long flags, next = 0;
 	struct request *rq, *tmp;
 	int next_set = 0;
 
+	if (blk_queue_enter(q, true))
+		return;
 	spin_lock_irqsave(q->queue_lock, flags);
 
 	list_for_each_entry_safe(rq, tmp, &q->timeout_list, timeout_list)
@@ -143,6 +146,7 @@ void blk_rq_timed_out_timer(unsigned long data)
 		mod_timer(&q->timeout, round_jiffies_up(next));
 
 	spin_unlock_irqrestore(q->queue_lock, flags);
+	blk_queue_exit(q);
 }
 
 /**
diff --git a/block/blk.h b/block/blk.h
index c43926d..70e4aee 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -93,7 +93,7 @@ static inline void blk_flush_integrity(void)
 }
 #endif
 
-void blk_rq_timed_out_timer(unsigned long data);
+void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 void blk_delete_timer(struct request *);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e711f29..221dc3b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -407,6 +407,7 @@ struct request_queue {
 
 	unsigned int		rq_timeout;
 	struct timer_list	timeout;
+	struct work_struct	timeout_work;
 	struct list_head	timeout_list;
 
 	struct list_head	icq_list;
-- 
1.9.1
