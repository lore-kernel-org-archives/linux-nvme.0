From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 26 Nov 2018 09:35:56 -0700
Subject: [PATCH 8/8] blk-mq: add plug case for devices that implement
 ->commits_rqs()
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Message-ID: <20181126163556.5181-9-axboe@kernel.dk>

If we have that hook, we know the driver handles bd->last == true in
a smart fashion. If it does, even for multiple hardware queues, it's
a good idea to flush batches of requests to the device, if we have
batches of requests from the submitter.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-mq.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0a12cec0b426..232f4914c8db 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1953,6 +1953,32 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 		plug->rq_count++;
 		plug->do_sort = true;
+	} else if (plug && q->mq_ops->commit_rqs) {
+		/*
+		 * If we have a ->commit_rqs(), then we know the driver can
+		 * batch submission doorbell updates. Add rq to plug list,
+		 * and flush if we exceed the plug count only.
+		 */
+		blk_mq_bio_to_request(rq, bio);
+		blk_mq_put_ctx(data.ctx);
+
+		/*
+		 * If we have requests for more than one queue here, we
+		 * should sort the list when it's flushed.
+		 */
+		if (!plug->do_sort && !list_empty(&plug->mq_list)) {
+			same_queue_rq = list_first_entry(&plug->mq_list,
+						struct request, queuelist);
+			if (same_queue_rq->q != q)
+				plug->do_sort = true;
+		}
+
+		list_add_tail(&rq->queuelist, &plug->mq_list);
+		plug->rq_count++;
+		if (plug->rq_count >= BLK_MAX_REQUEST_COUNT) {
+			blk_flush_plug_list(plug, false);
+			trace_block_plug(q);
+		}
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
-- 
2.17.1
