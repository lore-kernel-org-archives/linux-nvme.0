From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:46 -0700
Subject: [PATCHv3 05/12] blk-mq: Allow requests to never expire
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-6-git-send-email-keith.busch@intel.com>

Some types of requests may be started that are not gauranteed to ever
complete. This adds a request flag that a driver can use so mark the
request as such.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c            |    4 +++-
 block/blk-timeout.c       |    3 +++
 include/linux/blk_types.h |    2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a661c4f..c02a8c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -613,7 +613,7 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		break;
 	}
 }
-		
+
 static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
@@ -621,6 +621,8 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 
 	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
 		return;
+	if (rq->cmd_flags & REQ_NO_TIMEOUT)
+		return;
 
 	if (time_after_eq(jiffies, rq->deadline)) {
 		if (!blk_mark_rq_complete(rq))
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 56c0258..246dfb1 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -190,6 +190,9 @@ void blk_add_timer(struct request *req)
 	struct request_queue *q = req->q;
 	unsigned long expiry;
 
+	if (req->cmd_flags & REQ_NO_TIMEOUT)
+		return;
+
 	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
 	if (!q->mq_ops && !q->rq_timed_out_fn)
 		return;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 445d592..c294e3e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -190,6 +190,7 @@ enum rq_flag_bits {
 	__REQ_PM,		/* runtime pm request */
 	__REQ_HASHED,		/* on IO scheduler merge hash */
 	__REQ_MQ_INFLIGHT,	/* track inflight for MQ */
+	__REQ_NO_TIMEOUT,	/* requests may never expire */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -243,5 +244,6 @@ enum rq_flag_bits {
 #define REQ_PM			(1ULL << __REQ_PM)
 #define REQ_HASHED		(1ULL << __REQ_HASHED)
 #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
+#define REQ_NO_TIMEOUT		(1ULL << __REQ_NO_TIMEOUT)
 
 #endif /* __LINUX_BLK_TYPES_H */
-- 
1.7.10.4
