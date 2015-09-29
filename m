From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 29 Sep 2015 11:20:57 +0800
Subject: [PATCH 3/3] blk-mq: remove cpumask from 'struct blk_mq_tags'
In-Reply-To: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <1443496857-26887-4-git-send-email-tom.leiming@gmail.com>

The 'cpumask' of 'struct blk_mq_tags' is introduced to set
the irq affinity of NVMe queue, but now we have introduced
.map_changed callback which can cover the use case and looks
more flexible.

Signed-off-by: Ming Lei <tom.leiming at gmail.com>
---
 block/blk-mq-tag.c     |  5 -----
 block/blk-mq-tag.h     |  1 -
 block/blk-mq.c         | 11 +----------
 include/linux/blk-mq.h |  1 -
 4 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9115c6d..931b62d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -613,11 +613,6 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	if (!tags)
 		return NULL;
 
-	if (!zalloc_cpumask_var(&tags->cpumask, GFP_KERNEL)) {
-		kfree(tags);
-		return NULL;
-	}
-
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 9eb2cf4..d5a9612 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -44,7 +44,6 @@ struct blk_mq_tags {
 	struct list_head page_list;
 
 	int alloc_policy;
-	cpumask_var_t cpumask;
 };
 
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 181e438..8196011 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1811,7 +1811,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		hctx = q->mq_ops->map_queue(q, i);
 		cpumask_set_cpu(i, hctx->cpumask);
-		cpumask_set_cpu(i, hctx->tags->cpumask);
 		ctx->index_hw = hctx->nr_ctx;
 		hctx->ctxs[hctx->nr_ctx++] = ctx;
 	}
@@ -2198,12 +2197,6 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags)
-{
-	return tags->cpumask;
-}
-EXPORT_SYMBOL_GPL(blk_mq_tags_cpumask);
-
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -2265,10 +2258,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 	int i;
 
 	for (i = 0; i < set->nr_hw_queues; i++) {
-		if (set->tags[i]) {
+		if (set->tags[i])
 			blk_mq_free_rq_map(set, set->tags[i], i);
-			free_cpumask_var(set->tags[i]->cpumask);
-		}
 	}
 
 	kfree(set->tags);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a4a7433..79d4aaf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -190,7 +190,6 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		gfp_t gfp, bool reserved);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
-struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags);
 
 enum {
 	BLK_MQ_UNIQUE_TAG_BITS = 16,
-- 
1.9.1
