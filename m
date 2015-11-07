From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:44:55 +0100
Subject: [PATCH 01/12] block: fix blk_abort_request for blk-mq drivers
In-Reply-To: <1446885906-20967-1-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
Message-ID: <1446885906-20967-2-git-send-email-hch@lst.de>

We only added the request to the request list for the !blk-mq case,
so we should only delete it in that case as well.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-timeout.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 246dfb1..aa40aa9 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -158,11 +158,13 @@ void blk_abort_request(struct request *req)
 {
 	if (blk_mark_rq_complete(req))
 		return;
-	blk_delete_timer(req);
-	if (req->q->mq_ops)
+
+	if (req->q->mq_ops) {
 		blk_mq_rq_timed_out(req, false);
-	else
+	} else {
+		blk_delete_timer(req);
 		blk_rq_timed_out(req);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_abort_request);
 
-- 
1.9.1
