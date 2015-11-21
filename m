From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:19:43 +0100
Subject: [PATCH 03/47] block: defer timeouts to a workqueue
In-Reply-To: <1448090427-18749-1-git-send-email-hch@lst.de>
References: <1448090427-18749-1-git-send-email-hch@lst.de>
Message-ID: <1448090427-18749-4-git-send-email-hch@lst.de>

Timer context is not very useful for drivers to perform any meaningful abort
action from.  So instead of calling the driver from this useless context
defer it to a workqueue as soon as possible.

Note that while a delayed_work item would seem the right thing here I didn't
dare to use it due to the magic in blk_add_timer that pokes deep into timer
internals.  But maybe this encourages Tejun to add a sensible API for that to
the workqueue API and we'll all be fine in the end :)

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-core.c       | 8 ++++++++
 block/blk-mq.c         | 8 +++++---
 block/blk-timeout.c    | 5 +++--
 block/blk.h            | 2 +-
 include/linux/blkdev.h | 1 +
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5131993b..1de0974 100644
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
index 3ae09de..8354601 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -85,6 +85,7 @@ void blk_mq_freeze_queue_start(struct request_queue *q)
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
+		cancel_work_sync(&q->timeout_work);
 		blk_mq_run_hw_queues(q, false);
 	}
 }
@@ -617,9 +618,10 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
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
@@ -2015,7 +2017,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		hctxs[i]->queue_num = i;
 	}
 
-	setup_timer(&q->timeout, blk_mq_rq_timer, (unsigned long) q);
+	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
 	q->nr_queues = nr_cpu_ids;
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index aa40aa9..aedd128 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -127,9 +127,10 @@ static void blk_rq_check_expired(struct request *rq, unsigned long *next_timeout
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
diff --git a/block/blk.h b/block/blk.h
index da722eb..37b9165 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -95,7 +95,7 @@ static inline void blk_flush_integrity(void)
 }
 #endif
 
-void blk_rq_timed_out_timer(unsigned long data);
+void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 void blk_delete_timer(struct request *);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3fe27f8..9a8424a 100644
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
