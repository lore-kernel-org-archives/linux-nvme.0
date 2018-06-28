From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 14:55:57 -0600
Subject: [PATCH 1/5] blk-mq: add API to get hctx index from request
Message-ID: <20180628205601.13742-1-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d515b568..c6478833464d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -466,6 +466,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq)
+{
+	return blk_mq_map_queue(rq->q, rq->mq_ctx->cpu)->queue_num;
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_hctx_idx);
+
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..af91b2d31a04 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq);
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.14.3
