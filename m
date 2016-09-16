From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:16 +0200
Subject: [PATCH 05/21] blk-mq: Update hardware queue map after q->nr_hw_queues
 is set
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <474861c3158be937cba1fbb77e07a6de97499c69.1474014910.git.agordeev@redhat.com>

Initializing of hardware queue map should be done after
hardware context allocations, since we might end up with
less hardware contexts than requested.

Because mapping of hardware context to CPUs depends on
both number of CPUs and number of hardware contexts we
should map after both those numbers are determined.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq-cpumap.c | 17 -----------------
 block/blk-mq.c        |  8 +++++++-
 block/blk-mq.h        |  1 -
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index d0634bc..ee553a4 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -86,23 +86,6 @@ int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
 	return 0;
 }
 
-unsigned int *blk_mq_make_queue_map(struct blk_mq_tag_set *set)
-{
-	unsigned int *map;
-
-	/* If cpus are offline, map them to first hctx */
-	map = kzalloc_node(sizeof(*map) * nr_cpu_ids, GFP_KERNEL,
-				set->numa_node);
-	if (!map)
-		return NULL;
-
-	if (!blk_mq_update_queue_map(map, set->nr_hw_queues, cpu_online_mask))
-		return map;
-
-	kfree(map);
-	return NULL;
-}
-
 /*
  * We have no quick way of doing reverse lookups. This is only used at
  * queue init time, so runtime isn't important.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0f0a01a..401ceea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2069,7 +2069,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
-	q->mq_map = blk_mq_make_queue_map(set);
+	/* If cpus are offline, map them to first hctx */
+	q->mq_map = kzalloc_node(sizeof(*q->mq_map) * nr_cpu_ids, GFP_KERNEL,
+					set->numa_node);
 	if (!q->mq_map)
 		goto err_map;
 
@@ -2077,6 +2079,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
+	if (blk_mq_update_queue_map(q->mq_map, q->nr_hw_queues, cpu_online_mask))
+		goto err_update;
+
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
@@ -2119,6 +2124,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return q;
 
 err_hctxs:
+err_update:
 	kfree(q->mq_map);
 err_map:
 	kfree(q->queue_hw_ctx);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9087b11..97b0051 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,7 +47,6 @@ void blk_mq_disable_hotplug(void);
 /*
  * CPU -> queue mappings
  */
-extern unsigned int *blk_mq_make_queue_map(struct blk_mq_tag_set *set);
 extern int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
 				   const struct cpumask *online_mask);
 extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
-- 
1.8.3.1
