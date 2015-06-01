From: keith.busch@intel.com (Keith Busch)
Date: Mon,  1 Jun 2015 09:29:53 -0600
Subject: [PATCHv2 1/2] blk-mq: Shared tag enhancements
Message-ID: <1433172594-32127-1-git-send-email-keith.busch@intel.com>

Storage controllers may expose multiple block devices that share hardware
resources managed by blk-mq. This patch enhances the shared tags so a
low-level driver can access the shared resources not tied to the unshared
h/w contexts. This way the LLD can dynamically add and delete disks and
request queues without having to track all the request_queue hctx's to
iterate outstanding tags.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

  Removed additional blk-mq ops for tag init/exit. The driver can obtain
  references to these through its tagset instead.

 block/blk-mq-tag.c     |   38 ++++++++++++++++++++++++++++++++++++++
 block/blk-mq-tag.h     |    1 +
 block/blk-mq.c         |   12 ++++++++++--
 include/linux/blk-mq.h |    4 ++++
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index be3290c..9b6e288 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -438,6 +438,39 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
+static void bt_tags_for_each(struct blk_mq_tags *tags,
+		struct blk_mq_bitmap_tags *bt, unsigned int off,
+		busy_tag_iter_fn *fn, void *data, bool reserved)
+{
+	struct request *rq;
+	int bit, i;
+
+	if (!tags->rqs)
+		return;
+	for (i = 0; i < bt->map_nr; i++) {
+		struct blk_align_bitmap *bm = &bt->map[i];
+
+		for (bit = find_first_bit(&bm->word, bm->depth);
+		     bit < bm->depth;
+		     bit = find_next_bit(&bm->word, bm->depth, bit + 1)) {
+			rq = blk_mq_tag_to_rq(tags, off + bit);
+			fn(rq, data, reserved);
+		}
+
+		off += (1 << bt->bits_per_word);
+	}
+}
+
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv)
+{
+	if (tags->nr_reserved_tags)
+		bt_tags_for_each(tags, &tags->breserved_tags, 0, fn, priv, true);
+	bt_tags_for_each(tags, &tags->bitmap_tags, tags->nr_reserved_tags, fn, priv,
+			false);
+}
+EXPORT_SYMBOL(blk_mq_all_tag_busy_iter);
+
 void blk_mq_tag_busy_iter(struct blk_mq_hw_ctx *hctx, busy_iter_fn *fn,
 		void *priv)
 {
@@ -580,6 +613,11 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	if (!tags)
 		return NULL;
 
+	if (!zalloc_cpumask_var(&tags->cpumask, GFP_KERNEL)) {
+		kfree(tags);
+		return NULL;
+	}
+
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 90767b3..75893a3 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -44,6 +44,7 @@ struct blk_mq_tags {
 	struct list_head page_list;
 
 	int alloc_policy;
+	cpumask_var_t cpumask;
 };
 
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c382a34..ef100fd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1525,7 +1525,6 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 			i++;
 		}
 	}
-
 	return tags;
 
 fail:
@@ -1821,6 +1820,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		hctx = q->mq_ops->map_queue(q, i);
 		cpumask_set_cpu(i, hctx->cpumask);
+		cpumask_set_cpu(i, hctx->tags->cpumask);
 		ctx->index_hw = hctx->nr_ctx;
 		hctx->ctxs[hctx->nr_ctx++] = ctx;
 	}
@@ -2187,6 +2187,12 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	return 0;
 }
 
+struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags)
+{
+	return tags->cpumask;
+}
+EXPORT_SYMBOL_GPL(blk_mq_tags_cpumask);
+
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -2248,8 +2254,10 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 	int i;
 
 	for (i = 0; i < set->nr_hw_queues; i++) {
-		if (set->tags[i])
+		if (set->tags[i]) {
 			blk_mq_free_rq_map(set, set->tags[i], i);
+			free_cpumask_var(set->tags[i]->cpumask);
+		}
 	}
 
 	kfree(set->tags);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2056a99..37d1602 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -96,6 +96,7 @@ typedef void (exit_request_fn)(void *, struct request *, unsigned int,
 
 typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
+typedef void (busy_tag_iter_fn)(struct request *, void *, bool);
 
 struct blk_mq_ops {
 	/*
@@ -182,6 +183,7 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		gfp_t gfp, bool reserved);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
+struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags);
 
 enum {
 	BLK_MQ_UNIQUE_TAG_BITS = 16,
@@ -224,6 +226,8 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_tag_busy_iter(struct blk_mq_hw_ctx *hctx, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
-- 
1.7.10.4
