From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Apr 2019 19:02:20 +0800
Subject: [PATCH V7 8/9] block: don't drain in-progress dispatch in
 blk_cleanup_queue()
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
Message-ID: <20190424110221.17435-9-ming.lei@redhat.com>

Now freeing hw queue resource is moved to hctx's release handler,
we don't need to worry about the race between blk_cleanup_queue and
run queue any more.

So don't drain in-progress dispatch in blk_cleanup_queue().

This is basically revert of c2856ae2f315 ("blk-mq: quiesce queue before
freeing queue").

Cc: Dongli Zhang <dongli.zhang at oracle.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Bart Van Assche <bart.vanassche at wdc.com>
Cc: linux-scsi at vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen at oracle.com>,
Cc: Christoph Hellwig <hch at lst.de>,
Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche at acm.org>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Tested-by: James Smart <james.smart at broadcom.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f5b5f21ae4fd..e24cfcefdc19 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -338,18 +338,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
-	/*
-	 * make sure all in-progress dispatch are completed because
-	 * blk_freeze_queue() can only complete all requests, and
-	 * dispatch may still be in-progress since we dispatch requests
-	 * from more than one contexts.
-	 *
-	 * We rely on driver to deal with the race in case that queue
-	 * initialization isn't done.
-	 */
-	if (queue_is_mq(q) && blk_queue_init_done(q))
-		blk_mq_quiesce_queue(q);
-
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
-- 
2.9.5
