From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 15 Apr 2015 14:34:40 +0200
Subject: [PATCH 1/5 v2] blk-mq: Add prep/unprep support
In-Reply-To: <1429101284-19490-1-git-send-email-m@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
Message-ID: <1429101284-19490-2-git-send-email-m@bjorling.me>

Allow users to hook into prep/unprep functions just before an IO is
dispatched to the device driver. This is necessary for request-based
logic to take place at upper layers.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 block/blk-mq.c         | 28 ++++++++++++++++++++++++++--
 include/linux/blk-mq.h |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33c4285..f3dd028 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -338,6 +338,11 @@ EXPORT_SYMBOL(__blk_mq_end_request);
 
 void blk_mq_end_request(struct request *rq, int error)
 {
+	struct request_queue *q = rq->q;
+
+	if (q->unprep_rq_fn)
+		q->unprep_rq_fn(q, rq);
+
 	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
 		BUG();
 	__blk_mq_end_request(rq, error);
@@ -753,6 +758,17 @@ static void flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 	}
 }
 
+static int blk_mq_prep_rq(struct request_queue *q, struct request *rq)
+{
+	if (!q->prep_rq_fn)
+		return 0;
+
+	if (rq->cmd_flags & REQ_DONTPREP)
+		return 0;
+
+	return q->prep_rq_fn(q, rq);
+}
+
 /*
  * Run this hardware queue, pulling any software queues mapped to it in.
  * Note that this function currently has various problems around ordering
@@ -812,11 +828,15 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 		bd.list = dptr;
 		bd.last = list_empty(&rq_list);
 
-		ret = q->mq_ops->queue_rq(hctx, &bd);
+		ret = blk_mq_prep_rq(q, rq);
+		if (likely(!ret))
+			ret = q->mq_ops->queue_rq(hctx, &bd);
 		switch (ret) {
 		case BLK_MQ_RQ_QUEUE_OK:
 			queued++;
 			continue;
+		case BLK_MQ_RQ_QUEUE_DONE:
+			continue;
 		case BLK_MQ_RQ_QUEUE_BUSY:
 			list_add(&rq->queuelist, &rq_list);
 			__blk_mq_requeue_request(rq);
@@ -1270,10 +1290,14 @@ static void blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		 * error (busy), just add it to our list as we previously
 		 * would have done
 		 */
-		ret = q->mq_ops->queue_rq(data.hctx, &bd);
+		ret = blk_mq_prep_rq(q, rq);
+		if (likely(!ret))
+			ret = q->mq_ops->queue_rq(data.hctx, &bd);
 		if (ret == BLK_MQ_RQ_QUEUE_OK)
 			goto done;
 		else {
+			if (ret == BLK_MQ_RQ_QUEUE_DONE)
+				goto done;
 			__blk_mq_requeue_request(rq);
 
 			if (ret == BLK_MQ_RQ_QUEUE_ERROR) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7aec861..d7b39af 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,6 +140,7 @@ enum {
 	BLK_MQ_RQ_QUEUE_OK	= 0,	/* queued fine */
 	BLK_MQ_RQ_QUEUE_BUSY	= 1,	/* requeue IO for later */
 	BLK_MQ_RQ_QUEUE_ERROR	= 2,	/* end IO with error */
+	BLK_MQ_RQ_QUEUE_DONE	= 3,	/* IO is already handled */
 
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
-- 
1.9.1
