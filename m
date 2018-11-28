From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Nov 2018 06:35:38 -0700
Subject: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Message-ID: <20181128133538.20329-8-axboe@kernel.dk>

If we have that hook, we know the driver handles bd->last == true in
a smart fashion. If it does, even for multiple hardware queues, it's
a good idea to flush batches of requests to the device, if we have
batches of requests from the submitter.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9e1045152e45..091557a43d53 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1945,7 +1945,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		/* bypass scheduler for flush rq */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
-	} else if (plug && q->nr_hw_queues == 1) {
+	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs)) {
+		/*
+		 * Use plugging if we have a ->commit_rqs() hook as well,
+		 * as we know the driver uses bd->last in a smart
+		 * fashion.
+		 */
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
-- 
2.17.1
