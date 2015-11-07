From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:45:06 +0100
Subject: [PATCH 12/12] block: remove REQ_NO_TIMEOUT flag
In-Reply-To: <1446885906-20967-1-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
Message-ID: <1446885906-20967-13-git-send-email-hch@lst.de>

This was added for the 'magic' AEN requests in the NVMe driver that never
return.  We now handle them purely inside the driver and don't need this
core hack any more.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c            | 2 --
 block/blk-timeout.c       | 3 ---
 include/linux/blk_types.h | 2 --
 3 files changed, 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3a919ff..09216835 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -606,8 +606,6 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 			blk_mq_complete_request(rq, -EIO);
 		return;
 	}
-	if (rq->cmd_flags & REQ_NO_TIMEOUT)
-		return;
 
 	if (time_after_eq(jiffies, rq->deadline)) {
 		if (!blk_mark_rq_complete(rq))
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index aedd128..f3e3c61 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -193,9 +193,6 @@ void blk_add_timer(struct request *req)
 	struct request_queue *q = req->q;
 	unsigned long expiry;
 
-	if (req->cmd_flags & REQ_NO_TIMEOUT)
-		return;
-
 	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
 	if (!q->mq_ops && !q->rq_timed_out_fn)
 		return;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e813013..47c9d88 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -188,7 +188,6 @@ enum rq_flag_bits {
 	__REQ_PM,		/* runtime pm request */
 	__REQ_HASHED,		/* on IO scheduler merge hash */
 	__REQ_MQ_INFLIGHT,	/* track inflight for MQ */
-	__REQ_NO_TIMEOUT,	/* requests may never expire */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -242,6 +241,5 @@ enum rq_flag_bits {
 #define REQ_PM			(1ULL << __REQ_PM)
 #define REQ_HASHED		(1ULL << __REQ_HASHED)
 #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
-#define REQ_NO_TIMEOUT		(1ULL << __REQ_NO_TIMEOUT)
 
 #endif /* __LINUX_BLK_TYPES_H */
-- 
1.9.1
