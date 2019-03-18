From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 18 Mar 2019 11:29:49 +0800
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190318032950.17770-1-ming.lei@redhat.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
Message-ID: <20190318032950.17770-2-ming.lei@redhat.com>

In NVMe's error handler, follows the typical steps for tearing down
hardware:

1) stop blk_mq hw queues
2) stop the real hw queues
3) cancel in-flight requests via
	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
cancel_request():
	mark the request as abort
	blk_mq_complete_request(req);
4) destroy real hw queues

However, there may be race between #3 and #4, because blk_mq_complete_request()
actually completes the request asynchronously.

This patch introduces blk_mq_complete_request_sync() for fixing the
above race.

Cc: Christoph Hellwig <hch at lst.de>
Cc: linux-nvme at lists.infradead.org
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c         | 20 ++++++++++++++++----
 include/linux/blk-mq.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c181603cbd..8f925ac0b26d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -569,7 +569,7 @@ static void __blk_mq_complete_request_remote(void *data)
 	q->mq_ops->complete(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+static void __blk_mq_complete_request(struct request *rq, bool sync)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
@@ -586,7 +586,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	 * So complete IO reqeust in softirq context in case of single queue
 	 * for not degrading IO performance by irqsoff latency.
 	 */
-	if (q->nr_hw_queues == 1) {
+	if (q->nr_hw_queues == 1 && !sync) {
 		__blk_complete_request(rq);
 		return;
 	}
@@ -594,8 +594,11 @@ static void __blk_mq_complete_request(struct request *rq)
 	/*
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
+	 *
+	 * If driver requires to complete the request synchronously,
+	 * complete it locally, and it is usually done in error handler.
 	 */
-	if ((rq->cmd_flags & REQ_HIPRI) ||
+	if ((rq->cmd_flags & REQ_HIPRI) || sync ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
 		q->mq_ops->complete(rq);
 		return;
@@ -648,11 +651,20 @@ bool blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return false;
-	__blk_mq_complete_request(rq);
+	__blk_mq_complete_request(rq, false);
 	return true;
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+bool blk_mq_complete_request_sync(struct request *rq)
+{
+	if (unlikely(blk_should_fake_timeout(rq->q)))
+		return false;
+	__blk_mq_complete_request(rq, true);
+	return true;
+}
+EXPORT_SYMBOL(blk_mq_complete_request_sync);
+
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814bcc7e3..6a514e5136f4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -305,6 +305,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+bool blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.9.5
