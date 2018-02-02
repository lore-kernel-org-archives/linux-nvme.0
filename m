From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri,  2 Feb 2018 15:00:46 +0800
Subject: [PATCH 3/6] blk-mq: make blk_mq_rq_update_aborted_gstate a external
 interface
In-Reply-To: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1517554849-7802-4-git-send-email-jianchao.w.wang@oracle.com>

No functional change, just make blk_mq_rq_update_aborted_gstate a
external interface.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 block/blk-mq.c         | 3 ++-
 include/linux/blk-mq.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 01f271d..a027ca2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -581,7 +581,7 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
 		*srcu_idx = srcu_read_lock(hctx->srcu);
 }
 
-static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
+void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
 {
 	unsigned long flags;
 
@@ -597,6 +597,7 @@ static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
 	u64_stats_update_end(&rq->aborted_gstate_sync);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(blk_mq_rq_update_aborted_gstate);
 
 static u64 blk_mq_rq_aborted_gstate(struct request *rq)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8efcf49..ad54024 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -257,6 +257,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
+void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate);
 
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
2.7.4
