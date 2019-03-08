From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:40:02 -0700
Subject: [PATCH 1/5] blk-mq: Export reading mq request state
Message-ID: <20190308174006.5032-1-keith.busch@intel.com>

Drivers may need to know the state of their requets.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.h         | 9 ---------
 include/linux/blkdev.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index c11353a3749d..99ab7e472e62 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -128,15 +128,6 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
-/**
- * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
- * @rq: target request.
- */
-static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
-{
-	return READ_ONCE(rq->state);
-}
-
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index faed9d9eb84c..db113aee48bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -241,6 +241,15 @@ struct request {
 	struct request *next_rq;
 };
 
+/**
+ * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
+ * @rq: target request.
+ */
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
+{
+	return READ_ONCE(rq->state);
+}
+
 static inline bool blk_op_is_scsi(unsigned int op)
 {
 	return op == REQ_OP_SCSI_IN || op == REQ_OP_SCSI_OUT;
-- 
2.14.4
