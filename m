From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 28 Oct 2016 17:19:37 -0700
Subject: [PATCH v5 03/14] blk-mq: Introduce blk_mq_queue_stopped()
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Message-ID: <53234c01-f3f1-27cc-a21a-85486cff24c7@sandisk.com>

The function blk_queue_stopped() allows to test whether or not a
traditional request queue has been stopped. Introduce a helper
function that allows block drivers to query easily whether or not
one or more hardware contexts of a blk-mq queue have been stopped.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c         | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc1f462..283e0eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -946,6 +946,26 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
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
+		if (blk_mq_hctx_stopped(hctx))
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
index 535ab2e..aa93000 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -223,6 +223,7 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs
 void blk_mq_abort_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq, int error);
 
+bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_stop_hw_queues(struct request_queue *q);
-- 
2.10.1
