From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:45 -0700
Subject: [PATCHv3 04/12] blk-mq: Add helper to abort requeued requests
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-5-git-send-email-keith.busch@intel.com>

From: Jens Axboe <axboe@fb.com>

Adds a helper function a driver can use to abort requeued requests in
case any are pending when h/w queues are being removed.

Signed-off-by: Jens Axboe <axboe at fb.com>
---
 block/blk-mq.c         |   20 ++++++++++++++++++++
 include/linux/blk-mq.h |    1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0812965..a661c4f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -533,6 +533,26 @@ void blk_mq_kick_requeue_list(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
+void blk_mq_abort_requeue_list(struct request_queue *q)
+{
+	unsigned long flags;
+	LIST_HEAD(rq_list);
+
+	spin_lock_irqsave(&q->requeue_lock, flags);
+	list_splice_init(&q->requeue_list, &rq_list);
+	spin_unlock_irqrestore(&q->requeue_lock, flags);
+
+	while (!list_empty(&rq_list)) {
+		struct request *rq;
+
+		rq = list_first_entry(&rq_list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		rq->errors = -EIO;
+		blk_mq_end_request(rq, rq->errors);
+	}
+}
+EXPORT_SYMBOL(blk_mq_abort_requeue_list);
+
 static inline bool is_flush_request(struct request *rq,
 		struct blk_flush_queue *fq, unsigned int tag)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18684e0..5735e71 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -203,6 +203,7 @@ void blk_mq_requeue_request(struct request *rq);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
 void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
+void blk_mq_abort_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq);
 
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
1.7.10.4
