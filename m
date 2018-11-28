From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Nov 2018 06:35:33 -0700
Subject: [PATCH 2/7] blk-mq: add mq_ops->commit_rqs()
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Message-ID: <20181128133538.20329-3-axboe@kernel.dk>

blk-mq passes information to the hardware about any given request being
the last that we will issue in this sequence. The point is that hardware
can defer costly doorbell type writes to the last request. But if we run
into errors issuing a sequence of requests, we may never send the request
with bd->last == true set. For that case, we need a hook that tells the
hardware that nothing else is coming right now.

For failures returned by the drivers ->queue_rq() hook, the driver is
responsible for flushing pending requests, if it uses bd->last to
optimize that part. This works like before, no changes there.

Reviewed-by: Omar Sandoval <osandov at fb.com>
Reviewed-by: Ming Lei <ming.lei at redhat.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-mq.c         | 16 ++++++++++++++++
 include/linux/blk-mq.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0e2663048d95..18ff47a85ad3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1259,6 +1259,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	if (!list_empty(list)) {
 		bool needs_restart;
 
+		/*
+		 * If we didn't flush the entire list, we could have told
+		 * the driver there was more coming, but that turned out to
+		 * be a lie.
+		 */
+		if (q->mq_ops->commit_rqs)
+			q->mq_ops->commit_rqs(hctx);
+
 		spin_lock(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
@@ -1865,6 +1873,14 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			blk_mq_end_request(rq, ret);
 		}
 	}
+
+	/*
+	 * If we didn't flush the entire list, we could have told
+	 * the driver there was more coming, but that turned out to
+	 * be a lie.
+	 */
+	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
+		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
 static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b8de11e0603b..467f1dd21ccf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -117,6 +117,7 @@ struct blk_mq_queue_data {
 
 typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
 		const struct blk_mq_queue_data *);
+typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
 /* takes rq->cmd_flags as input, returns a hardware type index */
 typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
 typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
@@ -144,6 +145,15 @@ struct blk_mq_ops {
 	 */
 	queue_rq_fn		*queue_rq;
 
+	/*
+	 * If a driver uses bd->last to judge when to submit requests to
+	 * hardware, it must define this function. In case of errors that
+	 * make us stop issuing further requests, this hook serves the
+	 * purpose of kicking the hardware (which the last request otherwise
+	 * would have done).
+	 */
+	commit_rqs_fn		*commit_rqs;
+
 	/*
 	 * Return a queue map type for the given request/bio flags
 	 */
-- 
2.17.1
