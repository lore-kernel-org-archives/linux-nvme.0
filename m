From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 22:38:13 -0800
Subject: [PATCH v2 1/6] block: introduce blk_execute_rq_polled
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Message-ID: <20181213063819.13614-2-sagi@grimberg.me>

Used forsynchronous requests that needs polling. If we are knowingly
sending a request down to a poll queue, we need a synchronous interface
to poll for its completion.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 block/blk-exec.c       | 29 +++++++++++++++++++++++++++++
 block/blk-mq.c         |  8 --------
 include/linux/blk-mq.h |  8 ++++++++
 include/linux/blkdev.h |  2 ++
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index a34b7d918742..572032d60001 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -90,3 +90,32 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
 		wait_for_completion_io(&wait);
 }
 EXPORT_SYMBOL(blk_execute_rq);
+
+/**
+ * blk_execute_rq_polled - execute a request and poll for its completion
+ * @q:		queue to insert the request in
+ * @bd_disk:	matching gendisk
+ * @rq:		request to insert
+ * @at_head:    insert request at head or tail of queue
+ *
+ * Description:
+ *    Insert a fully prepared request at the back of the I/O scheduler queue
+ *    for execution and wait for completion.
+ */
+void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
+		   struct request *rq, int at_head)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+
+	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
+
+	rq->cmd_flags |= REQ_HIPRI;
+	rq->end_io_data = &wait;
+	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
+
+	while (!completion_done(&wait)) {
+		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
+		cond_resched();
+	}
+}
+EXPORT_SYMBOL(blk_execute_rq_polled);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65770da99159..65d3f3a69c0d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1747,14 +1747,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 	blk_account_io_start(rq, true);
 }
 
-static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
-{
-	if (rq->tag != -1)
-		return blk_tag_to_qc_t(rq->tag, hctx->queue_num, false);
-
-	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
-}
-
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 					    struct request *rq,
 					    blk_qc_t *cookie, bool last)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 57eda7b20243..c77cba1ec0f5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -357,4 +357,12 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
 	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
 
+static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	if (rq->tag != -1)
+		return blk_tag_to_qc_t(rq->tag, hctx->queue_num, false);
+
+	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
+}
+
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 81f1b105946b..9f48d8855916 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -860,6 +860,8 @@ extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 			  struct request *, int);
 extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
+void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
+		   struct request *rq, int at_head);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
-- 
2.17.1
