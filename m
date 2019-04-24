From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Apr 2019 19:02:17 +0800
Subject: [PATCH V7 5/9] blk-mq: split blk_mq_alloc_and_init_hctx into two parts
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
Message-ID: <20190424110221.17435-6-ming.lei@redhat.com>

Split blk_mq_alloc_and_init_hctx into two parts, and one is
blk_mq_alloc_hctx() which is for allocating all hctx resources,
another is blk_mq_init_hctx() which is for initializing hctx, and
serves as counter-part of blk_mq_exit_hctx().

Cc: Dongli Zhang <dongli.zhang at oracle.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Bart Van Assche <bart.vanassche at wdc.com>
Cc: linux-scsi at vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen at oracle.com>,
Cc: Christoph Hellwig <hch at lst.de>,
Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
Reviewed-by: Hannes Reinecke <hare at suse.com>
Tested-by: James Smart <james.smart at broadcom.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c | 76 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fea25363488d..1eceeb26ae7d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2304,10 +2304,38 @@ static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 	return hw_ctx_size;
 }
 
+static int blk_mq_init_hctx(struct request_queue *q,
+			    struct blk_mq_tag_set *set,
+			    struct blk_mq_hw_ctx *hctx,
+			    unsigned hctx_idx)
+{
+	hctx->queue_num = hctx_idx;
+
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
+	hctx->tags = set->tags[hctx_idx];
+
+	if (set->ops->init_hctx &&
+	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
+		goto unregister_cpu_notifier;
+
+	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
+				hctx->numa_node))
+		goto exit_hctx;
+	return 0;
+
+ exit_hctx:
+	if (set->ops->exit_hctx)
+		set->ops->exit_hctx(hctx, hctx_idx);
+ unregister_cpu_notifier:
+	blk_mq_remove_cpuhp(hctx);
+	return -1;
+}
+
 static struct blk_mq_hw_ctx *
-__blk_mq_alloc_and_init_hctx(struct request_queue *q,
-			     struct blk_mq_tag_set *set,
-			     unsigned hctx_idx, int node)
+blk_mq_alloc_hctx(struct request_queue *q,
+		  struct blk_mq_tag_set *set,
+		  unsigned hctx_idx, int node)
 {
 	struct blk_mq_hw_ctx *hctx;
 
@@ -2324,8 +2352,6 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 
 	atomic_set(&hctx->nr_active, 0);
 	hctx->numa_node = node;
-	hctx->queue_num = hctx_idx;
-
 	if (node == NUMA_NO_NODE)
 		hctx->numa_node = set->numa_node;
 	node = hctx->numa_node;
@@ -2336,10 +2362,6 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
-	hctx->tags = set->tags[hctx_idx];
-
 	/*
 	 * Allocate space for all possible cpus to avoid allocation at
 	 * runtime
@@ -2347,29 +2369,21 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 	hctx->ctxs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
 			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node);
 	if (!hctx->ctxs)
-		goto unregister_cpu_notifier;
+		goto free_cpumask;
 
 	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
 				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node))
 		goto free_ctxs;
-
 	hctx->nr_ctx = 0;
 
 	spin_lock_init(&hctx->dispatch_wait_lock);
 	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
 	INIT_LIST_HEAD(&hctx->dispatch_wait.entry);
 
-	if (set->ops->init_hctx &&
-	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto free_bitmap;
-
 	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size,
 			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!hctx->fq)
-		goto exit_hctx;
-
-	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
-		goto free_fq;
+		goto free_bitmap;
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
@@ -2377,17 +2391,11 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 
 	return hctx;
 
- free_fq:
-	blk_free_flush_queue(hctx->fq);
- exit_hctx:
-	if (set->ops->exit_hctx)
-		set->ops->exit_hctx(hctx, hctx_idx);
  free_bitmap:
 	sbitmap_free(&hctx->ctx_map);
  free_ctxs:
 	kfree(hctx->ctxs);
- unregister_cpu_notifier:
-	blk_mq_remove_cpuhp(hctx);
+ free_cpumask:
 	free_cpumask_var(hctx->cpumask);
  free_hctx:
 	kfree(hctx);
@@ -2742,7 +2750,21 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
 {
-	return __blk_mq_alloc_and_init_hctx(q, set, hctx_idx, node);
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
+	if (!hctx)
+		goto fail;
+
+	if (blk_mq_init_hctx(q, set, hctx, hctx_idx))
+		goto free_hctx;
+
+	return hctx;
+
+ free_hctx:
+	kobject_put(&hctx->kobj);
+ fail:
+	return NULL;
 }
 
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-- 
2.9.5
