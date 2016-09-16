From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:24 +0200
Subject: [PATCH 13/21] blk-mq: Move hardware context init code into
 blk_mq_init_hctx()
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <6cef6a4af167d191e00b730484dda7ea8ac81da7.1474014910.git.agordeev@redhat.com>

Move scattered hardware context initialization code into
a single function destined to do that, blk_mq_init_hctx()

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 81 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2bae1a..b77e73b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1694,17 +1694,30 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	q->nr_hw_queues = 0;
 }
 
-static int blk_mq_init_hctx(struct request_queue *q,
-		struct blk_mq_tag_set *set,
-		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
+static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
+		struct blk_mq_tag_set *set, unsigned hctx_idx)
 {
-	int node = hctx->numa_node;
 	unsigned flush_start_tag = set->queue_depth;
+	struct blk_mq_hw_ctx *hctx;
+	int node;
+
+	node = blk_mq_hw_queue_to_node(q->mq_map, hctx_idx);
+	if (node == NUMA_NO_NODE)
+		node = set->numa_node;
+
+	hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
+	if (!hctx)
+		return NULL;
+
+	if (!zalloc_cpumask_var_node(&hctx->cpumask, GFP_KERNEL, node))
+		goto free_hctx;
 
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
+	atomic_set(&hctx->nr_active, 0);
+	hctx->numa_node = node;
 	hctx->queue = q;
 	hctx->queue_num = hctx_idx;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
@@ -1743,7 +1756,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 				   flush_start_tag + hctx_idx, node))
 		goto free_fq;
 
-	return 0;
+	return hctx;
 
  free_fq:
 	kfree(hctx->fq);
@@ -1756,8 +1769,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	kfree(hctx->ctxs);
  unregister_cpu_notifier:
 	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
-
-	return -1;
+	free_cpumask_var(hctx->cpumask);
+ free_hctx:
+	kfree(hctx);
+	
+	return NULL;
 }
 
 static void blk_mq_init_cpu_queues(struct request_queue *q,
@@ -1971,57 +1987,40 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
 	int i, j;
+	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
 	for (i = 0; i < set->nr_hw_queues; i++) {
-		int node;
-
 		if (hctxs[i])
 			continue;
 		if (!set->tags[i])
 			break;
 
-		node = blk_mq_hw_queue_to_node(q->mq_map, i);
-		if (node == NUMA_NO_NODE)
-			node = set->numa_node;
-
-		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
-					GFP_KERNEL, node);
-		if (!hctxs[i])
-			break;
-
-		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask, GFP_KERNEL,
-						node)) {
-			kfree(hctxs[i]);
-			hctxs[i] = NULL;
+		hctx = blk_mq_init_hctx(q, set, i);
+		if (!hctx)
 			break;
-		}
 
-		atomic_set(&hctxs[i]->nr_active, 0);
-		hctxs[i]->numa_node = node;
+		blk_mq_hctx_kobj_init(hctx);
 
-		if (blk_mq_init_hctx(q, set, hctxs[i], i)) {
-			free_cpumask_var(hctxs[i]->cpumask);
-			kfree(hctxs[i]);
-			hctxs[i] = NULL;
-			break;
-		}
-		blk_mq_hctx_kobj_init(hctxs[i]);
+		hctxs[i] = hctx;
 	}
 	for (j = i; j < q->nr_hw_queues; j++) {
-		struct blk_mq_hw_ctx *hctx = hctxs[j];
+		hctx = hctxs[j];
 
-		if (hctx) {
-			kobject_put(&hctx->kobj);
+		if (!hctx)
+			continue;
 
-			if (hctx->tags) {
-				blk_mq_free_rq_map(set, hctx->tags, j);
-				set->tags[j] = NULL;
-			}
-			blk_mq_exit_hctx(q, set, hctx, j);
-			hctxs[j] = NULL;
+		kobject_put(&hctx->kobj);
+
+		if (hctx->tags) {
+			blk_mq_free_rq_map(set, hctx->tags, j);
+			set->tags[j] = NULL;
 		}
+
+		blk_mq_exit_hctx(q, set, hctx, j);
+
+		hctxs[j] = NULL;
 	}
 	q->nr_hw_queues = i;
 	blk_mq_sysfs_register(q);
-- 
1.8.3.1
