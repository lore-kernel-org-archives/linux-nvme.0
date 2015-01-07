From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:57:58 -0700
Subject: [PATCHv2 04/10] blk-mq: Export abort requeue list
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420599484-21582-5-git-send-email-keith.busch@intel.com>

This patch lets a driver abort all requeued requests in case there are
any pending, but the h/w queue will never become available again.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         |   20 ++++++++++++++++++++
 include/linux/blk-mq.h |    1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a976db4..f6e1225 100644
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
index b509ef5..a09728e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -204,6 +204,7 @@ void blk_mq_requeue_request(struct request *rq);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
 void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
+void blk_mq_abort_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq);
 
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
1.7.10.4
