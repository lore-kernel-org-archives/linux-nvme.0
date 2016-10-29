From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 28 Oct 2016 17:18:48 -0700
Subject: [PATCH v5 01/14] blk-mq: Do not invoke .queue_rq() for a stopped queue
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Message-ID: <cacf3f5d-b8dd-3e3f-68da-c0ab6592b4a8@sandisk.com>

The meaning of the BLK_MQ_S_STOPPED flag is "do not call
.queue_rq()". Hence modify blk_mq_make_request() such that requests
are queued instead of issued if a queue has been stopped.

Reported-by: Ming Lei <tom.leiming at gmail.com>
Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Ming Lei <tom.leiming at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Cc: <stable at vger.kernel.org>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3d27a6..ad459e4 100644
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
