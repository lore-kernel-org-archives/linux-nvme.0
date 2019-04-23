From: hare@suse.de (Hannes Reinecke)
Date: Tue, 23 Apr 2019 14:29:51 +0200
Subject: [PATCH 5/5] blk-mq: free q->queue_hw_ctx in blk_mq_exit_queue()
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Message-ID: <20190423122951.134531-6-hare@suse.de>

blk_mq_exit_queue() already frees up all hardware contexts, so it should
be freeing up the holding array, too.

Signed-off-by: Hannes Reinecke <hare at suse.com.
---
 block/blk-mq.c | 11 +++++++++--
 block/blk-mq.h |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f620462dc4d1..ae873d333f5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -462,7 +462,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
-	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
+	if (q->queue_hw_ctx)
+		alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
 		blk_queue_exit(q);
 		return ERR_PTR(-EXDEV);
@@ -2673,7 +2674,8 @@ void blk_mq_release(struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
-	kfree(q->queue_hw_ctx);
+	/* Ensure that blk_mq_exit_queue() has been called */
+	WARN_ON(q->queue_hw_ctx);
 
 	/*
 	 * release .mq_kobj and sw queue's kobject now because
@@ -2930,6 +2932,8 @@ void blk_mq_exit_queue(struct request_queue *q)
 
 	blk_mq_del_queue_tag_set(q);
 	blk_mq_exit_hw_queues(q, set);
+	kfree(q->queue_hw_ctx);
+	q->queue_hw_ctx = NULL;
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
@@ -3477,6 +3481,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
+	if (!q->queue_hw_ctx)
+		return 0;
+
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 
 	/*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index c421e3a16e36..14589b9fca84 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -188,7 +188,7 @@ static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 {
-	return hctx->nr_ctx && hctx->tags;
+	return hctx && hctx->nr_ctx && hctx->tags;
 }
 
 unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
-- 
2.16.4
