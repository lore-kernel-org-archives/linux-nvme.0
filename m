From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 28 Oct 2016 17:19:15 -0700
Subject: [PATCH v5 02/14] blk-mq: Introduce blk_mq_hctx_stopped()
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Message-ID: <075bab96-4f5f-d68c-843b-f2358319a0a6@sandisk.com>

Multiple functions test the BLK_MQ_S_STOPPED bit so introduce
a helper function that performs this test.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Reviewed-by: Ming Lei <tom.leiming at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c | 12 ++++++------
 block/blk-mq.h |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ad459e4..bc1f462 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -787,7 +787,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	struct list_head *dptr;
 	int queued;
 
-	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
 
 	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
@@ -912,8 +912,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
-	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state) ||
-	    !blk_mq_hw_queue_mapped(hctx)))
+	if (unlikely(blk_mq_hctx_stopped(hctx) ||
+		     !blk_mq_hw_queue_mapped(hctx)))
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
@@ -938,7 +938,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if ((!blk_mq_hctx_has_pending(hctx) &&
 		    list_empty_careful(&hctx->dispatch)) ||
-		    test_bit(BLK_MQ_S_STOPPED, &hctx->state))
+		    blk_mq_hctx_stopped(hctx))
 			continue;
 
 		blk_mq_run_hw_queue(hctx, async);
@@ -988,7 +988,7 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!test_bit(BLK_MQ_S_STOPPED, &hctx->state))
+		if (!blk_mq_hctx_stopped(hctx))
 			continue;
 
 		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
@@ -1332,7 +1332,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_mq_put_ctx(data.ctx);
 		if (!old_rq)
 			goto done;
-		if (test_bit(BLK_MQ_S_STOPPED, &data.hctx->state) ||
+		if (blk_mq_hctx_stopped(data.hctx) ||
 		    blk_mq_direct_issue_request(old_rq, &cookie) != 0)
 			blk_mq_insert_request(old_rq, false, true, true);
 		goto done;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e5d2524..ac772da 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -100,6 +100,11 @@ static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
 	data->hctx = hctx;
 }
 
+static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
+{
+	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
+}
+
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 {
 	return hctx->nr_ctx && hctx->tags;
-- 
2.10.1
