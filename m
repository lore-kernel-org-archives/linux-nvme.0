From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Apr 2019 19:02:16 +0800
Subject: [PATCH V7 4/9] blk-mq: move all hctx alloction & initialization into
 __blk_mq_alloc_and_init_hctx
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
Message-ID: <20190424110221.17435-5-ming.lei@redhat.com>

Move all hctx related allocation and initialization into
__blk_mq_alloc_and_init_hctx, and prepare for splitting blk_mq_alloc_and_init_hctx
into real two functions, one is for allocate everything, and another is for
initializing everyting.

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
 block/blk-mq.c | 93 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 862eb41f24f8..fea25363488d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2290,15 +2290,45 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
-static int blk_mq_init_hctx(struct request_queue *q,
-		struct blk_mq_tag_set *set,
-		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
+static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 {
-	int node;
+	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
+
+	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
+			   __alignof__(struct blk_mq_hw_ctx)) !=
+		     sizeof(struct blk_mq_hw_ctx));
+
+	if (tag_set->flags & BLK_MQ_F_BLOCKING)
+		hw_ctx_size += sizeof(struct srcu_struct);
+
+	return hw_ctx_size;
+}
+
+static struct blk_mq_hw_ctx *
+__blk_mq_alloc_and_init_hctx(struct request_queue *q,
+			     struct blk_mq_tag_set *set,
+			     unsigned hctx_idx, int node)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+			node);
+	if (!hctx)
+		goto fail_alloc_hctx;
+
+	if (!zalloc_cpumask_var_node(&hctx->cpumask,
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+				node))
+		goto free_hctx;
+
+	atomic_set(&hctx->nr_active, 0);
+	hctx->numa_node = node;
+	hctx->queue_num = hctx_idx;
 
-	node = hctx->numa_node;
 	if (node == NUMA_NO_NODE)
-		node = hctx->numa_node = set->numa_node;
+		hctx->numa_node = set->numa_node;
+	node = hctx->numa_node;
 
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	spin_lock_init(&hctx->lock);
@@ -2343,8 +2373,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
+	blk_mq_hctx_kobj_init(hctx);
 
-	return 0;
+	return hctx;
 
  free_fq:
 	blk_free_flush_queue(hctx->fq);
@@ -2357,7 +2388,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	kfree(hctx->ctxs);
  unregister_cpu_notifier:
 	blk_mq_remove_cpuhp(hctx);
-	return -1;
+	free_cpumask_var(hctx->cpumask);
+ free_hctx:
+	kfree(hctx);
+ fail_alloc_hctx:
+	return NULL;
 }
 
 static void blk_mq_init_cpu_queues(struct request_queue *q,
@@ -2703,51 +2738,11 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 }
 EXPORT_SYMBOL(blk_mq_init_sq_queue);
 
-static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
-{
-	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
-
-	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
-			   __alignof__(struct blk_mq_hw_ctx)) !=
-		     sizeof(struct blk_mq_hw_ctx));
-
-	if (tag_set->flags & BLK_MQ_F_BLOCKING)
-		hw_ctx_size += sizeof(struct srcu_struct);
-
-	return hw_ctx_size;
-}
-
 static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
 {
-	struct blk_mq_hw_ctx *hctx;
-
-	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
-			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-			node);
-	if (!hctx)
-		return NULL;
-
-	if (!zalloc_cpumask_var_node(&hctx->cpumask,
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				node)) {
-		kfree(hctx);
-		return NULL;
-	}
-
-	atomic_set(&hctx->nr_active, 0);
-	hctx->numa_node = node;
-	hctx->queue_num = hctx_idx;
-
-	if (blk_mq_init_hctx(q, set, hctx, hctx_idx)) {
-		free_cpumask_var(hctx->cpumask);
-		kfree(hctx);
-		return NULL;
-	}
-	blk_mq_hctx_kobj_init(hctx);
-
-	return hctx;
+	return __blk_mq_alloc_and_init_hctx(q, set, hctx_idx, node);
 }
 
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-- 
2.9.5
