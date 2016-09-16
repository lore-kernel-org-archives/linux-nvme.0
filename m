From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:25 +0200
Subject: [PATCH 14/21] blk-mq: Rework blk_mq_init_hctx() function
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <dcc69362846491d2e7102158929998b10787d2b2.1474014910.git.agordeev@redhat.com>

Rework blk_mq_init_hctx() function so all reaquired memory
allocations are done before data initialization and callbacks
invocation.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b77e73b..9e5cd1f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1712,6 +1712,22 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, GFP_KERNEL, node))
 		goto free_hctx;
 
+	/*
+	 * Allocate space for all possible cpus to avoid allocation at
+	 * runtime
+	 */
+	hctx->ctxs = kmalloc_node(nr_cpu_ids * sizeof(void *),
+					GFP_KERNEL, node);
+	if (!hctx->ctxs)
+		goto free_cpumask;
+
+	if (blk_mq_alloc_bitmap(&hctx->ctx_map, node))
+		goto free_ctxs;
+
+	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
+	if (!hctx->fq)
+		goto free_bitmap;
+
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
 	spin_lock_init(&hctx->lock);
@@ -1720,55 +1736,37 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	hctx->numa_node = node;
 	hctx->queue = q;
 	hctx->queue_num = hctx_idx;
+	hctx->nr_ctx = 0;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
+	hctx->tags = set->tags[hctx_idx];
 
 	blk_mq_init_cpu_notifier(&hctx->cpu_notifier,
 					blk_mq_hctx_notify, hctx);
 	blk_mq_register_cpu_notifier(&hctx->cpu_notifier);
 
-	hctx->tags = set->tags[hctx_idx];
-
-	/*
-	 * Allocate space for all possible cpus to avoid allocation at
-	 * runtime
-	 */
-	hctx->ctxs = kmalloc_node(nr_cpu_ids * sizeof(void *),
-					GFP_KERNEL, node);
-	if (!hctx->ctxs)
-		goto unregister_cpu_notifier;
-
-	if (blk_mq_alloc_bitmap(&hctx->ctx_map, node))
-		goto free_ctxs;
-
-	hctx->nr_ctx = 0;
-
 	if (set->ops->init_hctx &&
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto free_bitmap;
-
-	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
-	if (!hctx->fq)
-		goto exit_hctx;
+		goto unregister_cpu_notifier;
 
 	if (set->ops->init_request &&
 	    set->ops->init_request(set->driver_data,
 				   hctx->fq->flush_rq, hctx_idx,
 				   flush_start_tag + hctx_idx, node))
-		goto free_fq;
+		goto exit_hctx;
 
 	return hctx;
 
- free_fq:
-	kfree(hctx->fq);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
+ unregister_cpu_notifier:
+	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
+	kfree(hctx->fq);
  free_bitmap:
 	blk_mq_free_bitmap(&hctx->ctx_map);
  free_ctxs:
 	kfree(hctx->ctxs);
- unregister_cpu_notifier:
-	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
+ free_cpumask:
 	free_cpumask_var(hctx->cpumask);
  free_hctx:
 	kfree(hctx);
-- 
1.8.3.1
