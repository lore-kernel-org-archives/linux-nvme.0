From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:30 +0200
Subject: [PATCH RFC 19/21] blk-mq: Enable combined hardware queues
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <095a01b53b2d4e5e4638f683f963f69a3639e3e1.1474014910.git.agordeev@redhat.com>

This is 3rd step change in a bid to enable mapping of multiple
device hardware queues to a single CPU.

It introduces combined hardware context - the one consisting from
multiple low-level hardware contexts. As result, queue depths deeper
than the device hardware queue depth are made possible (but not
yet allowed).

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq-tag.c     |   4 +-
 block/blk-mq.c         | 150 +++++++++++++++----------------------------------
 include/linux/blk-mq.h |   5 ++
 3 files changed, 51 insertions(+), 108 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1602813..e987a6b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -477,7 +477,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 {
 	int i;
 
-	for (i = 0; i < tagset->nr_hw_queues; i++) {
+	for (i = 0; i < tagset->nr_co_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
 	}
@@ -491,7 +491,7 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set)
 	if (!set->ops->reinit_request)
 		goto out;
 
-	for (i = 0; i < set->nr_hw_queues; i++) {
+	for (i = 0; i < set->nr_co_queues; i++) {
 		struct blk_mq_tags *tags = set->tags[i];
 
 		for (j = 0; j < tags->nr_tags; j++) {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6d055ec..450a3ed 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1499,22 +1499,27 @@ static size_t order_to_size(unsigned int order)
 	return (size_t)PAGE_SIZE << order;
 }
 
+static unsigned int queue_depth(struct blk_mq_tag_set *set)
+{
+	return set->queue_depth * set->co_queue_size;
+}
+
 static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 		unsigned int hctx_idx)
 {
 	struct blk_mq_tags *tags;
 	unsigned int i, j, entries_per_page, max_order = 4;
 	size_t rq_size, left;
+	unsigned int depth = queue_depth(set);
 
-	tags = blk_mq_init_tags(set->queue_depth, set->reserved_tags,
-				set->numa_node,
+	tags = blk_mq_init_tags(depth, set->reserved_tags, set->numa_node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
 		return NULL;
 
 	INIT_LIST_HEAD(&tags->page_list);
 
-	tags->rqs = kzalloc_node(set->queue_depth * sizeof(struct request *),
+	tags->rqs = kzalloc_node(depth * sizeof(struct request *),
 				 GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY,
 				 set->numa_node);
 	if (!tags->rqs) {
@@ -1528,9 +1533,9 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 	 */
 	rq_size = round_up(sizeof(struct request) + set->cmd_size,
 				cache_line_size());
-	left = rq_size * set->queue_depth;
+	left = rq_size * depth;
 
-	for (i = 0; i < set->queue_depth; ) {
+	for (i = 0; i < depth; ) {
 		int this_order = max_order;
 		struct page *page;
 		int to_do;
@@ -1564,7 +1569,7 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 		 */
 		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_KERNEL);
 		entries_per_page = order_to_size(this_order) / rq_size;
-		to_do = min(entries_per_page, set->queue_depth - i);
+		to_do = min(entries_per_page, depth - i);
 		left -= to_do * rq_size;
 		for (j = 0; j < to_do; j++) {
 			tags->rqs[i] = p;
@@ -1703,7 +1708,7 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set, unsigned hctx_idx)
 {
 	struct blk_mq_hw_ctx *hctx;
-	unsigned int nr_llhw_ctx = 1;
+	unsigned int nr_llhw_ctx = set->co_queue_size;
 	int node;
 	int i;
 
@@ -1757,7 +1762,7 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_llhw_ctx *llhw_ctx = &hctx->llhw_ctxs[i];
 
 		llhw_ctx->index = i;
-		llhw_ctx->queue_id = hctx_idx;
+		llhw_ctx->queue_id = (hctx_idx * set->co_queue_size) + i;
 
 		if (set->ops->init_hctx &&
 		    set->ops->init_hctx(llhw_ctx, set->driver_data))
@@ -2005,7 +2010,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
-	for (i = 0; i < set->nr_hw_queues; i++) {
+	for (i = 0; i < set->nr_co_queues; i++) {
 		if (hctxs[i])
 			continue;
 		if (!set->tags[i])
@@ -2050,7 +2055,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_ctx)
 		goto err_exit;
 
-	q->queue_hw_ctx = kzalloc_node(set->nr_hw_queues *
+	q->queue_hw_ctx = kzalloc_node(set->nr_co_queues *
 			sizeof(*(q->queue_hw_ctx)), GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
@@ -2090,12 +2095,12 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
 	 */
-	q->nr_requests = set->queue_depth;
+	q->nr_requests = queue_depth(set);
 
 	if (set->ops->complete)
 		blk_queue_softirq_done(q, set->ops->complete);
 
-	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
+	blk_mq_init_cpu_queues(q, set->nr_co_queues);
 
 	get_online_cpus();
 	mutex_lock(&all_q_mutex);
@@ -2232,7 +2237,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < set->nr_hw_queues; i++) {
+	for (i = 0; i < set->nr_co_queues; i++) {
 		set->tags[i] = blk_mq_init_rq_map(set, i);
 		if (!set->tags[i])
 			goto out_unwind;
@@ -2248,38 +2253,11 @@ out_unwind:
 }
 
 /*
- * Allocate the request maps associated with this tag_set. Note that this
- * may reduce the depth asked for, if memory is tight. set->queue_depth
- * will be updated to reflect the allocated depth.
+ * TODO	Restore original functionality
  */
 static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
-	unsigned int depth;
-	int err;
-
-	depth = set->queue_depth;
-	do {
-		err = __blk_mq_alloc_rq_maps(set);
-		if (!err)
-			break;
-
-		set->queue_depth >>= 1;
-		if (set->queue_depth < set->reserved_tags + BLK_MQ_TAG_MIN) {
-			err = -ENOMEM;
-			break;
-		}
-	} while (set->queue_depth);
-
-	if (!set->queue_depth || err) {
-		pr_err("blk-mq: failed to allocate request map\n");
-		return -ENOMEM;
-	}
-
-	if (depth != set->queue_depth)
-		pr_info("blk-mq: reduced tag depth (%u -> %u)\n",
-						depth, set->queue_depth);
-
-	return 0;
+	return __blk_mq_alloc_rq_maps(set);
 }
 
 struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags)
@@ -2291,8 +2269,7 @@ EXPORT_SYMBOL_GPL(blk_mq_tags_cpumask);
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
- * requested depth down, if if it too large. In that case, the set
- * value will be stored in set->queue_depth.
+ * requested depth down, if if it too large.
  */
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 {
@@ -2302,34 +2279,32 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		return -EINVAL;
 	if (!set->queue_depth)
 		return -EINVAL;
-	if (set->queue_depth < set->reserved_tags + BLK_MQ_TAG_MIN)
-		return -EINVAL;
-
 	if (!set->ops->queue_rq)
 		return -EINVAL;
 
-	if (set->queue_depth > BLK_MQ_MAX_DEPTH) {
-		pr_info("blk-mq: reduced tag depth to %u\n",
-			BLK_MQ_MAX_DEPTH);
-		set->queue_depth = BLK_MQ_MAX_DEPTH;
-	}
+	/*
+	 * TODO	Restore original queue depth and count limits
+	 */
 
 	/*
 	 * If a crashdump is active, then we are potentially in a very
-	 * memory constrained environment. Limit us to 1 queue and
-	 * 64 tags to prevent using too much memory.
+	 * memory constrained environment. Limit us to 1 queue.
 	 */
-	if (is_kdump_kernel()) {
-		set->nr_hw_queues = 1;
-		set->queue_depth = min(64U, set->queue_depth);
-	}
+	set->nr_co_queues = is_kdump_kernel() ? 1 : set->nr_hw_queues;
+	set->co_queue_size = 1;
+
+	if (queue_depth(set) < set->reserved_tags + BLK_MQ_TAG_MIN)
+		return -EINVAL;
+	if (queue_depth(set) > BLK_MQ_MAX_DEPTH)
+		return -EINVAL;
+
 	/*
 	 * There is no use for more h/w queues than cpus.
 	 */
-	if (set->nr_hw_queues > nr_cpu_ids)
-		set->nr_hw_queues = nr_cpu_ids;
+	if (set->nr_co_queues > nr_cpu_ids)
+		set->nr_co_queues = nr_cpu_ids;
 
-	set->tags = kzalloc_node(set->nr_hw_queues * sizeof(*set->tags),
+	set->tags = kzalloc_node(set->nr_co_queues * sizeof(*set->tags),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
 		return -ENOMEM;
@@ -2352,7 +2327,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < set->nr_hw_queues; i++) {
+	for (i = 0; i < set->nr_co_queues; i++) {
 		if (set->tags[i])
 			blk_mq_free_rq_map(set, set->tags[i], i);
 	}
@@ -2362,56 +2337,19 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
+/*
+ * TODO	Restore original functionality
+ */
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
-	struct blk_mq_tag_set *set = q->tag_set;
-	struct blk_mq_hw_ctx *hctx;
-	int i, ret;
-
-	if (!set || nr > set->queue_depth)
-		return -EINVAL;
-
-	ret = 0;
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->tags)
-			continue;
-		ret = blk_mq_tag_update_depth(hctx->tags, nr);
-		if (ret)
-			break;
-	}
-
-	if (!ret)
-		q->nr_requests = nr;
-
-	return ret;
+	return -EINVAL;
 }
 
+/*
+ * TODO	Restore original functionality
+ */
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
-	struct request_queue *q;
-
-	if (nr_hw_queues > nr_cpu_ids)
-		nr_hw_queues = nr_cpu_ids;
-	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
-		return;
-
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue(q);
-
-	set->nr_hw_queues = nr_hw_queues;
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
-
-		if (q->nr_hw_queues > 1)
-			blk_queue_make_request(q, blk_mq_make_request);
-		else
-			blk_queue_make_request(q, blk_sq_make_request);
-
-		blk_mq_queue_reinit(q, cpu_online_mask);
-	}
-
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_unfreeze_queue(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 52a9e7c..579dfaf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -88,8 +88,13 @@ int blk_mq_tag_to_llhw_ctx_idx(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 
 struct blk_mq_tag_set {
 	struct blk_mq_ops	*ops;
+
 	unsigned int		nr_hw_queues;
 	unsigned int		queue_depth;	/* max hw supported */
+
+	unsigned int		nr_co_queues;	/* number of combined queues */
+	unsigned int		co_queue_size;	/* hw queues in one combined */
+
 	unsigned int		reserved_tags;
 	unsigned int		cmd_size;	/* per-request extra data */
 	int			numa_node;
-- 
1.8.3.1
