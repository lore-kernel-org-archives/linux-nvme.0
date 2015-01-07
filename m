From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:57:59 -0700
Subject: [PATCHv2 05/10] blk-mq: Allow requests to never expire
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420599484-21582-6-git-send-email-keith.busch@intel.com>

Some requests may be started but have no gaurantee they'll ever
complete. This defines a special timeout value that a driver can use so
the request will never be timed out.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         |    8 +++++---
 include/linux/blkdev.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6e1225..5dbd315b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -414,7 +414,8 @@ void blk_mq_start_request(struct request *rq)
 	if (unlikely(blk_bidi_rq(rq)))
 		rq->next_rq->resid_len = blk_rq_bytes(rq->next_rq);
 
-	blk_add_timer(rq);
+	if (rq->timeout != REQ_NO_TIMEOUT)
+		blk_add_timer(rq);
 
 	/*
 	 * Ensure that ->deadline is visible before set the started
@@ -613,13 +614,14 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		break;
 	}
 }
-		
+
 static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
 	struct blk_mq_timeout_data *data = priv;
 
-	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
+	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags)  ||
+				rq->timeout == REQ_NO_TIMEOUT)
 		return;
 
 	if (time_after_eq(jiffies, rq->deadline)) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 92f4b4b..096b4f7f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -198,6 +198,7 @@ struct request {
 
 	unsigned long deadline;
 	struct list_head timeout_list;
+#define REQ_NO_TIMEOUT UINT_MAX
 	unsigned int timeout;
 	int retries;
 
-- 
1.7.10.4
