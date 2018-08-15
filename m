From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:53 -0400
Subject: [PATCH V4 8/9] block: add helper to get the request based cookie
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-9-chaitanya.kulkarni@wdc.com>

This patch adds a helper function to get calculate the cookie based
on the request. This is needed for the drivers which are issuing
request based I/Os such as NVMe Over Fabrics target passthru driver an
using polling.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 block/blk-mq.c         | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e13bdc2707ce..2759eeed0847 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1669,6 +1669,26 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
 }
 
+blk_qc_t blk_mq_req_cookie(struct request *rq)
+{
+	struct blk_mq_ctx *ctx;
+	struct blk_mq_hw_ctx *hctx;
+
+	if (!rq || !rq->q)
+		return BLK_QC_T_NONE;
+
+	ctx = blk_mq_get_ctx(rq->q);
+	if (!ctx)
+		return BLK_QC_T_NONE;
+
+	hctx = blk_mq_map_queue(rq->q, ctx->cpu);
+	if (!hctx)
+		return BLK_QC_T_NONE;
+
+	return request_to_qc_t(hctx, rq);
+}
+EXPORT_SYMBOL(blk_mq_req_cookie);
+
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 					    struct request *rq,
 					    blk_qc_t *cookie)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d710e92874cc..c3dabb2ad177 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -270,6 +270,7 @@ void blk_mq_stop_hw_queues(struct request_queue *q);
 void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
+blk_qc_t blk_mq_req_cookie(struct request *rq);
 void blk_mq_quiesce_queue(struct request_queue *q);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
-- 
2.14.1
