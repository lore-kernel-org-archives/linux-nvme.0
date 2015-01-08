From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:47 -0700
Subject: [PATCHv3 06/12] blk-mq: End unstarted requests on a dying queue
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-7-git-send-email-keith.busch@intel.com>

Requests that haven't been started prior to a queue dying can be ended
in error without waiting for them to start and time out.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c02a8c2..96d4356 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -619,8 +619,13 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 {
 	struct blk_mq_timeout_data *data = priv;
 
-	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
+	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
+		if (unlikely(blk_queue_dying(rq->q))) {
+			rq->errors = -EIO;
+			blk_mq_complete_request(rq);
+		}
 		return;
+	}
 	if (rq->cmd_flags & REQ_NO_TIMEOUT)
 		return;
 
-- 
1.7.10.4
