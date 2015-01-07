From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:58:00 -0700
Subject: [PATCHv2 06/10] blk-mq: End unstarted requests on a dying queue
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420599484-21582-7-git-send-email-keith.busch@intel.com>

Requests that haven't been started prior to a queue dying can be ended
in error without having to wait for them to time out.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5dbd315b..1443c77 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -621,8 +621,13 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	struct blk_mq_timeout_data *data = priv;
 
 	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags)  ||
-				rq->timeout == REQ_NO_TIMEOUT)
+				rq->timeout == REQ_NO_TIMEOUT) {
+		if (unlikely(blk_queue_dying(rq->q))) {
+			rq->errors = -EIO;
+			blk_mq_complete_request(rq);
+		}
 		return;
+	}
 
 	if (time_after_eq(jiffies, rq->deadline)) {
 		if (!blk_mark_rq_complete(rq))
-- 
1.7.10.4
