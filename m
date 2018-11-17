From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 17 Nov 2018 14:43:49 -0700
Subject: [PATCH 2/7] block: have ->poll_fn() return number of entries polled
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Message-ID: <20181117214354.822-3-axboe@kernel.dk>

We currently only really support sync poll, ie poll with 1
IO in flight. This prepares us for supporting async poll.

Note that the returned value isn't necessarily 100% accurate.
If poll races with IRQ completion, we assume that the fact
that the task is now runnable means we found at least one
entry. In reality it could be more than 1, or not even 1.
This is fine, the caller will just need to take this into
account.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-mq.c                | 18 +++++++++---------
 drivers/nvme/host/multipath.c |  4 ++--
 include/linux/blkdev.h        |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7fc4abb4cc36..52b1c97cd7c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -38,7 +38,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -3305,7 +3305,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	return true;
 }
 
-static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 {
 	struct request_queue *q = hctx->queue;
 	long state;
@@ -3318,7 +3318,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	 * straight to the busy poll loop.
 	 */
 	if (blk_mq_poll_hybrid_sleep(q, hctx, rq))
-		return true;
+		return 1;
 
 	hctx->poll_considered++;
 
@@ -3332,30 +3332,30 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
-			return true;
+			return ret;
 		}
 
 		if (signal_pending_state(state, current))
 			__set_current_state(TASK_RUNNING);
 
 		if (current->state == TASK_RUNNING)
-			return true;
+			return 1;
 		if (ret < 0)
 			break;
 		cpu_relax();
 	}
 
 	__set_current_state(TASK_RUNNING);
-	return false;
+	return 0;
 }
 
-static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct request *rq;
 
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return false;
+		return 0;
 
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 	if (!blk_qc_t_is_internal(cookie))
@@ -3369,7 +3369,7 @@ static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 		 * so we should be safe with just the NULL check.
 		 */
 		if (!rq)
-			return false;
+			return 0;
 	}
 
 	return __blk_mq_poll(hctx, rq);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b82b0d3ca39a..65539c8df11d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -220,11 +220,11 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 	return ret;
 }
 
-static bool nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
+static int nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
 {
 	struct nvme_ns_head *head = q->queuedata;
 	struct nvme_ns *ns;
-	bool found = false;
+	int found = 0;
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ad6eafc43f2..e97c0a3b2262 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -283,7 +283,7 @@ static inline unsigned short req_get_ioprio(struct request *req)
 struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
-typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
+typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
-- 
2.17.1
