From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Dec 2015 17:08:14 -0700
Subject: [PATCH 1/2] blk-mq: dynamic h/w context count
Message-ID: <1450397295-24031-1-git-send-email-keith.busch@intel.com>

The hardware's provided queue count may change at runtime with resource
provisioning. This patch allows a block driver to alter the number of
h/w queues available when its resource count changes.

The main part is a new blk-mq API to request a new number of h/w queues
for a given live tag set. The new API freezes all queues using that set,
then adjusts the allocated count prior to remapping these to CPUs.

The bulk of the rest just shifts where h/w contexts and all their
artifacts are allocated and freed.

The number of max h/w contexts is capped to the number of possible cpus
since there is no use for more than that. As such, all pre-allocated
memory for pointers need to account for the max possible rather than
the initial number of queues.

A side effect of this is that the blk-mq will proceed successfully as
long as it can allocate at least one h/w context. Previously it would
fail request queue initialization if less than the requested number
was allocated.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq-sysfs.c   |   9 +--
 block/blk-mq.c         | 173 +++++++++++++++++++++++++++++--------------------
 block/blk-mq.h         |   1 +
 include/linux/blk-mq.h |   2 +
 4 files changed, 112 insertions(+), 73 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 1cf1878..431fdda 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -408,17 +408,18 @@ void blk_mq_unregister_disk(struct gendisk *disk)
 	blk_mq_enable_hotplug();
 }
 
+void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
+{
+	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
+}
+
 static void blk_mq_sysfs_init(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	int i;
 
 	kobject_init(&q->mq_kobj, &blk_mq_ktype);
 
-	queue_for_each_hw_ctx(q, hctx, i)
-		kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
-
 	queue_for_each_ctx(q, ctx, i)
 		kobject_init(&ctx->kobj, &blk_mq_ctx_ktype);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8f812b4..b3d9e09 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1742,31 +1742,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	return -1;
 }
 
-static int blk_mq_init_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-
-	/*
-	 * Initialize hardware queues
-	 */
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (blk_mq_init_hctx(q, set, hctx, i))
-			break;
-	}
-
-	if (i == q->nr_hw_queues)
-		return 0;
-
-	/*
-	 * Init failed
-	 */
-	blk_mq_exit_hw_queues(q, set, i);
-
-	return 1;
-}
-
 static void blk_mq_init_cpu_queues(struct request_queue *q,
 				   unsigned int nr_hw_queues)
 {
@@ -1824,6 +1799,7 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 			continue;
 
 		hctx = q->mq_ops->map_queue(q, i);
+
 		cpumask_set_cpu(i, hctx->cpumask);
 		ctx->index_hw = hctx->nr_ctx;
 		hctx->ctxs[hctx->nr_ctx++] = ctx;
@@ -1979,54 +1955,89 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
-struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
-						  struct request_queue *q)
+static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+						struct request_queue *q)
 {
-	struct blk_mq_hw_ctx **hctxs;
-	struct blk_mq_ctx __percpu *ctx;
-	unsigned int *map;
-	int i;
-
-	ctx = alloc_percpu(struct blk_mq_ctx);
-	if (!ctx)
-		return ERR_PTR(-ENOMEM);
-
-	hctxs = kmalloc_node(set->nr_hw_queues * sizeof(*hctxs), GFP_KERNEL,
-			set->numa_node);
-
-	if (!hctxs)
-		goto err_percpu;
-
-	map = blk_mq_make_queue_map(set);
-	if (!map)
-		goto err_map;
+	int i, j;
+	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
+	blk_mq_sysfs_unregister(q);
 	for (i = 0; i < set->nr_hw_queues; i++) {
-		int node = blk_mq_hw_queue_to_node(map, i);
+		int node;
 
+		if (hctxs[i])
+			continue;
+
+		node = blk_mq_hw_queue_to_node(q->mq_map, i);
 		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
 					GFP_KERNEL, node);
 		if (!hctxs[i])
-			goto err_hctxs;
+			break;
 
 		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask, GFP_KERNEL,
-						node))
-			goto err_hctxs;
+						node)) {
+			kfree(hctxs[i]);
+			hctxs[i] = NULL;
+			break;
+		}
 
 		atomic_set(&hctxs[i]->nr_active, 0);
 		hctxs[i]->numa_node = node;
 		hctxs[i]->queue_num = i;
+
+		if (blk_mq_init_hctx(q, set, hctxs[i], i)) {
+			free_cpumask_var(hctxs[i]->cpumask);
+			kfree(hctxs[i]);
+			hctxs[i] = NULL;
+			break;
+		}
+		blk_mq_hctx_kobj_init(hctxs[i]);
 	}
+	for (j = i; j < q->nr_hw_queues; j++) {
+		struct blk_mq_hw_ctx *hctx = hctxs[j];
+
+		if (hctx) {
+			if (hctx->tags) {
+				blk_mq_free_rq_map(set, hctx->tags, j);
+				set->tags[j] = NULL;
+			}
+			blk_mq_exit_hctx(q, set, hctx, j);
+			free_cpumask_var(hctx->cpumask);
+			kobject_put(&hctx->kobj);
+			kfree(hctx->ctxs);
+			kfree(hctx);
+			hctxs[j] = NULL;
+
+		}
+	}
+	q->nr_hw_queues = i;
+	blk_mq_sysfs_register(q);
+}
+
+struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
+						  struct request_queue *q)
+{
+	q->queue_ctx = alloc_percpu(struct blk_mq_ctx);
+	if (!q->queue_ctx)
+		return ERR_PTR(-ENOMEM);
+
+	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
+						GFP_KERNEL, set->numa_node);
+	if (!q->queue_hw_ctx)
+		goto err_percpu;
+
+	q->mq_map = blk_mq_make_queue_map(set);
+	if (!q->mq_map)
+		goto err_map;
+
+	blk_mq_realloc_hw_ctxs(set, q);
+	if (!q->nr_hw_queues)
+		goto err_hctxs;
 
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
 	q->nr_queues = nr_cpu_ids;
-	q->nr_hw_queues = set->nr_hw_queues;
-	q->mq_map = map;
-
-	q->queue_ctx = ctx;
-	q->queue_hw_ctx = hctxs;
 
 	q->mq_ops = set->ops;
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
@@ -2055,9 +2066,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 
-	if (blk_mq_init_hw_queues(q, set))
-		goto err_hctxs;
-
 	get_online_cpus();
 	mutex_lock(&all_q_mutex);
 
@@ -2071,17 +2079,11 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return q;
 
 err_hctxs:
-	kfree(map);
-	for (i = 0; i < set->nr_hw_queues; i++) {
-		if (!hctxs[i])
-			break;
-		free_cpumask_var(hctxs[i]->cpumask);
-		kfree(hctxs[i]);
-	}
+	kfree(q->mq_map);
 err_map:
-	kfree(hctxs);
+	kfree(q->queue_hw_ctx);
 err_percpu:
-	free_percpu(ctx);
+	free_percpu(q->queue_ctx);
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(blk_mq_init_allocated_queue);
@@ -2289,9 +2291,13 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		set->nr_hw_queues = 1;
 		set->queue_depth = min(64U, set->queue_depth);
 	}
+	/*
+	 * There is no use for more h/w queues than cpus.
+	 */
+	if (set->nr_hw_queues > nr_cpu_ids)
+		set->nr_hw_queues = nr_cpu_ids;
 
-	set->tags = kmalloc_node(set->nr_hw_queues *
-				 sizeof(struct blk_mq_tags *),
+	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
 		return -ENOMEM;
@@ -2314,7 +2320,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < set->nr_hw_queues; i++) {
+	for (i = 0; i < nr_cpu_ids; i++) {
 		if (set->tags[i])
 			blk_mq_free_rq_map(set, set->tags[i], i);
 	}
@@ -2346,6 +2352,35 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
+{
+	struct request_queue *q;
+
+	if (nr_hw_queues > nr_cpu_ids)
+		nr_hw_queues = nr_cpu_ids;
+	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
+		return;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue(q);
+
+	set->nr_hw_queues = nr_hw_queues;
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_realloc_hw_ctxs(set, q);
+
+		if (q->nr_hw_queues > 1)
+			blk_queue_make_request(q, blk_mq_make_request);
+		else
+			blk_queue_make_request(q, blk_sq_make_request);
+
+		blk_mq_queue_reinit(q, cpu_online_mask);
+	}
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unfreeze_queue(q);
+}
+EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
+
 void blk_mq_disable_hotplug(void)
 {
 	mutex_lock(&all_q_mutex);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaede8e..9087b11 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -57,6 +57,7 @@ extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
  */
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
+extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7fc9296..15a73d4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -244,6 +244,8 @@ void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
 
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
+
 /*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
-- 
2.6.2.307.g37023ba
