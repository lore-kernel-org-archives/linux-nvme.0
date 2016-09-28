From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 28 Sep 2016 16:57:55 -0700
Subject: [PATCH v2 1/7] blk-mq: Introduce blk_mq_queue_stopped()
In-Reply-To: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
Message-ID: <26c7db22-bac8-6d8c-ba6e-3cbf0cec3368@sandisk.com>

The function blk_queue_stopped() allows to test whether or not a
traditional request queue has been stopped. Introduce a helper
function that allows block drivers to query easily whether or not
one or more hardware contexts of a blk-mq queue have been stopped.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Cc: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c         | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index dc5f47f..d8c45de 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -950,6 +950,26 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queues);
 
+/**
+ * blk_mq_queue_stopped() - check whether one or more hctxs have been stopped
+ * @q: request queue.
+ *
+ * The caller is responsible for serializing this function against
+ * blk_mq_{start,stop}_hw_queue().
+ */
+bool blk_mq_queue_stopped(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		if (test_bit(BLK_MQ_S_STOPPED, &hctx->state))
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(blk_mq_queue_stopped);
+
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	cancel_work(&hctx->run_work);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5daa0ef..368c460d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -233,6 +233,7 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs
 void blk_mq_abort_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq, int error);
 
+bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_stop_hw_queues(struct request_queue *q);
-- 
2.10.0
