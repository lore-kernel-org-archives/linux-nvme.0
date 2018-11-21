From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:45 +0100
Subject: [PATCH 11/13] block: remove ->poll_fn
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
Message-ID: <20181121162347.17430-12-hch@lst.de>

This was intended to support users like nvme multipath, but is just
getting in the way and adding another indirect call.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-core.c       | 11 -----------
 block/blk-mq.c         | 12 +++++++-----
 include/linux/blkdev.h |  2 --
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f7ffc43ada14..b641175d50c2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1273,17 +1273,6 @@ blk_qc_t submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
-{
-	if (!q->poll_fn || !blk_qc_t_valid(cookie))
-		return false;
-
-	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
-	return q->poll_fn(q, cookie, spin);
-}
-EXPORT_SYMBOL_GPL(blk_poll);
-
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for new the queue limits
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cda698804422..32e43bea36e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -38,7 +38,6 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -2794,8 +2793,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	blk_queue_make_request(q, blk_mq_make_request);
-	if (q->mq_ops->poll)
-		q->poll_fn = blk_mq_poll;
 
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
@@ -3356,14 +3353,18 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
 }
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
 	long state;
 
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!blk_qc_t_valid(cookie) ||
+	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
+	if (current->plug)
+		blk_flush_plug_list(current->plug, false);
+
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 
 	/*
@@ -3404,6 +3405,7 @@ static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	__set_current_state(TASK_RUNNING);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blk_poll);
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e3c0a8ec16a7..cf95e0e7e182 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -283,7 +283,6 @@ static inline unsigned short req_get_ioprio(struct request *req)
 struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
-typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t, bool spin);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
@@ -401,7 +400,6 @@ struct request_queue {
 	struct rq_qos		*rq_qos;
 
 	make_request_fn		*make_request_fn;
-	poll_q_fn		*poll_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 
 	const struct blk_mq_ops	*mq_ops;
-- 
2.19.1
