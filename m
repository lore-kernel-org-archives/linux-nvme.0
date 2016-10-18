From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 14:48:43 -0700
Subject: [PATCH v3 01/11] blk-mq: Do not invoke .queue_rq() for a stopped queue
In-Reply-To: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
Message-ID: <595d4b59-3892-ef24-ef91-b7cab6611af7@sandisk.com>

The meaning of the BLK_MQ_S_STOPPED flag is "do not call
.queue_rq()". Hence modify blk_mq_make_request() such that requests
are queued instead of issued if a queue has been stopped.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Hannes Reinecke <hare at suse.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Johannes Thumshirn <jthumshirn at suse.de>
Cc: <stable at vger.kernel.org>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ddc2eed..b5dcafb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1332,9 +1332,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_mq_put_ctx(data.ctx);
 		if (!old_rq)
 			goto done;
-		if (!blk_mq_direct_issue_request(old_rq, &cookie))
-			goto done;
-		blk_mq_insert_request(old_rq, false, true, true);
+		if (test_bit(BLK_MQ_S_STOPPED, &data.hctx->state) ||
+		    blk_mq_direct_issue_request(old_rq, &cookie) != 0)
+			blk_mq_insert_request(old_rq, false, true, true);
 		goto done;
 	}
 
-- 
2.10.1
