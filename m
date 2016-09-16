From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:29 +0200
Subject: [PATCH RFC 18/21] blk-mq: Enable tag numbers exceed hardware queue
 depth
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <f57dc919bd32f3d385fff1074e877ca8e6345961.1474014910.git.agordeev@redhat.com>

This is 2nd step change in a bid to enable mapping of multiple
device hardware queues to a single CPU.

It enables number of tags assigned to a hardware context to exceed
the device hardware queue depth. As result single hardware context
could be mapped to multiple low-level hardware contexts. This is a
prerequisite to introduce combined hardware contexts.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-core.c       | 4 +++-
 block/blk-mq.c         | 9 +++++++--
 include/linux/blk-mq.h | 7 +++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bf4f196..36ae127 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3312,9 +3312,11 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 
 	state = current->state;
 	while (!need_resched()) {
+		unsigned int tag = blk_qc_t_to_tag(cookie);
 		unsigned int queue_num = blk_qc_t_to_queue_num(cookie);
 		struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[queue_num];
-		struct blk_mq_llhw_ctx *llhw_ctx = &hctx->llhw_ctxs[0];
+		int idx = blk_mq_tag_to_llhw_ctx_idx(hctx, tag);
+		struct blk_mq_llhw_ctx *llhw_ctx = &hctx->llhw_ctxs[idx];
 		int ret;
 
 		hctx->poll_invoked++;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 274eab8..6d055ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -829,6 +829,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	queued = 0;
 	while (!list_empty(&rq_list)) {
 		struct blk_mq_queue_data bd;
+		int llhw_ctx_idx;
 		int ret;
 
 		rq = list_first_entry(&rq_list, struct request, queuelist);
@@ -838,7 +839,9 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 		bd.list = dptr;
 		bd.last = list_empty(&rq_list);
 
-		ret = q->mq_ops->queue_rq(&hctx->llhw_ctxs[0], &bd);
+		llhw_ctx_idx = blk_mq_tag_to_llhw_ctx_idx(hctx, rq->tag);
+
+		ret = q->mq_ops->queue_rq(&hctx->llhw_ctxs[llhw_ctx_idx], &bd);
 		switch (ret) {
 		case BLK_MQ_RQ_QUEUE_OK:
 			queued++;
@@ -1260,13 +1263,14 @@ static int blk_mq_direct_issue_request(struct request *rq, blk_qc_t *cookie)
 		.last = 1
 	};
 	blk_qc_t new_cookie = blk_tag_to_qc_t(rq->tag, hctx->queue_num);
+	int llhw_ctx_idx = blk_mq_tag_to_llhw_ctx_idx(hctx, rq->tag);
 
 	/*
 	 * For OK queue, we are done. For error, kill it. Any other
 	 * error (busy), just add it to our list as we previously
 	 * would have done
 	 */
-	ret = q->mq_ops->queue_rq(&hctx->llhw_ctxs[0], &bd);
+	ret = q->mq_ops->queue_rq(&hctx->llhw_ctxs[llhw_ctx_idx], &bd);
 	if (ret == BLK_MQ_RQ_QUEUE_OK) {
 		*cookie = new_cookie;
 		return 0;
@@ -1741,6 +1745,7 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	hctx->queue_num = hctx_idx;
 	hctx->nr_ctx = 0;
 	hctx->nr_llhw_ctx = nr_llhw_ctx;
+	hctx->llhw_queue_depth = set->queue_depth;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 	hctx->tags = set->tags[hctx_idx];
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c3392b..52a9e7c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -67,6 +67,7 @@ struct blk_mq_hw_ctx {
 	unsigned long		poll_invoked;
 	unsigned long		poll_success;
 
+	unsigned int		llhw_queue_depth;
 	unsigned int		nr_llhw_ctx;
 	struct blk_mq_llhw_ctx	llhw_ctxs[0];
 };
@@ -79,6 +80,12 @@ struct blk_mq_hw_ctx *blk_mq_to_hctx(struct blk_mq_llhw_ctx *llhw_ctx)
 	return (void *)llhw_ctx_0 - offsetof(struct blk_mq_hw_ctx, llhw_ctxs);
 }
 
+static inline
+int blk_mq_tag_to_llhw_ctx_idx(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+{
+	return tag / hctx->llhw_queue_depth;
+}
+
 struct blk_mq_tag_set {
 	struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
-- 
1.8.3.1
