From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 14 Dec 2018 11:06:06 -0800
Subject: [PATCH v4 2/6] block: make request_to_qc_t public
In-Reply-To: <20181214190610.20086-1-sagi@grimberg.me>
References: <20181214190610.20086-1-sagi@grimberg.me>
Message-ID: <20181214190610.20086-3-sagi@grimberg.me>

block consumers will need it for polling requests that
are sent with blk_execute_rq_nowait. Also, get rid of
blk_tag_to_qc_t and open-code it instead.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 block/blk-mq.c            |  8 --------
 include/linux/blk-mq.h    | 10 ++++++++++
 include/linux/blk_types.h | 11 -----------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eff52c33e434..fb4a09b096d5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1745,14 +1745,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
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
index 57eda7b20243..2dd84feaf1ef 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -357,4 +357,14 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
 	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
 
+static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
+		struct request *rq)
+{
+	if (rq->tag != -1)
+		return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
+
+	return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
+			BLK_QC_T_INTERNAL;
+}
+
 #endif
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 46c005d601ac..ee1ce9058302 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -424,17 +424,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
 	return cookie != BLK_QC_T_NONE;
 }
 
-static inline blk_qc_t blk_tag_to_qc_t(unsigned int tag, unsigned int queue_num,
-				       bool internal)
-{
-	blk_qc_t ret = tag | (queue_num << BLK_QC_T_SHIFT);
-
-	if (internal)
-		ret |= BLK_QC_T_INTERNAL;
-
-	return ret;
-}
-
 static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
 {
 	return (cookie & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT;
-- 
2.17.1
