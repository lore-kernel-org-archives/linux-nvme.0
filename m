From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 26 Nov 2018 09:35:50 -0700
Subject: [PATCH 2/8] block: improve logic around when to sort a plug list
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Message-ID: <20181126163556.5181-3-axboe@kernel.dk>

Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
case if we have requests for multiple devices in the plug.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-core.c       | 1 +
 block/blk-mq.c         | 7 +++++--
 include/linux/blkdev.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index be9233400314..c9758d185357 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
 	INIT_LIST_HEAD(&plug->mq_list);
 	INIT_LIST_HEAD(&plug->cb_list);
 	plug->rq_count = 0;
+	plug->do_sort = false;
 
 	/*
 	 * Store ordering should not be needed here, since a potential
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 99c66823d52f..6a249bf6ed00 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	list_splice_init(&plug->mq_list, &list);
 	plug->rq_count = 0;
 
-	list_sort(NULL, &list, plug_rq_cmp);
+	if (plug->do_sort)
+		list_sort(NULL, &list, plug_rq_cmp);
 
 	this_q = NULL;
 	this_hctx = NULL;
@@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 		plug->rq_count++;
+		plug->do_sort = true;
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
@@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			data.hctx = same_queue_rq->mq_hctx;
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
-		}
+		} else if (plug->rq_count > 1)
+			plug->do_sort = true;
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02732cae6080..b6d0b33feee7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1131,6 +1131,7 @@ struct blk_plug {
 	struct list_head mq_list; /* blk-mq requests */
 	struct list_head cb_list; /* md requires an unplug callback */
 	unsigned short rq_count;
+	bool do_sort;
 };
 #define BLK_MAX_REQUEST_COUNT 16
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
-- 
2.17.1
