From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Apr 2017 21:27:02 +0200
Subject: [PATCH 17/23] blk-mq: simplify __blk_mq_complete_request
In-Reply-To: <20170419192708.22098-1-hch@lst.de>
References: <20170419192708.22098-1-hch@lst.de>
Message-ID: <20170419192708.22098-18-hch@lst.de>

Merge blk_mq_ipi_complete_request and blk_mq_stat_add into their only
caller.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0c19df66f5a0..1f98db082da3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -406,12 +406,19 @@ static void __blk_mq_complete_request_remote(void *data)
 	rq->q->softirq_done_fn(rq);
 }
 
-static void blk_mq_ipi_complete_request(struct request *rq)
+static void __blk_mq_complete_request(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	bool shared = false;
 	int cpu;
 
+	if (rq->internal_tag != -1)
+		blk_mq_sched_completed_request(rq);
+	if (rq->rq_flags & RQF_STATS) {
+		blk_mq_poll_stats_start(rq->q);
+		blk_stat_add(rq);
+	}
+
 	if (!test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags)) {
 		rq->q->softirq_done_fn(rq);
 		return;
@@ -432,22 +439,6 @@ static void blk_mq_ipi_complete_request(struct request *rq)
 	put_cpu();
 }
 
-static void blk_mq_stat_add(struct request *rq)
-{
-	if (rq->rq_flags & RQF_STATS) {
-		blk_mq_poll_stats_start(rq->q);
-		blk_stat_add(rq);
-	}
-}
-
-static void __blk_mq_complete_request(struct request *rq)
-{
-	if (rq->internal_tag != -1)
-		blk_mq_sched_completed_request(rq);
-	blk_mq_stat_add(rq);
-	blk_mq_ipi_complete_request(rq);
-}
-
 /**
  * blk_mq_complete_request - end I/O on a request
  * @rq:		the request being processed
-- 
2.11.0
