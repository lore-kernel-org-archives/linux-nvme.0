From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:15 +0200
Subject: [PATCH 04/21] blk-mq: Do not limit number of queues to 'nr_cpu_ids'
 in allocations
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <4d6909298a94c3d7e7c7ab87eaec097d7ffdc8bd.1474014910.git.agordeev@redhat.com>

Currently maximum number of used hardware queues is limited to
number of CPUs in the system. However, using 'nr_cpu_ids' as
the limit for (de-)allocations of data structures instead of
existing data structures' counters (a) worsens readability and
(b) leads to unused memory when number of hardware queues is
less than number of CPUs.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b6a7dee..0f0a01a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2064,8 +2064,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_ctx)
 		goto err_exit;
 
-	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
-						GFP_KERNEL, set->numa_node);
+	q->queue_hw_ctx = kzalloc_node(set->nr_hw_queues *
+			sizeof(*(q->queue_hw_ctx)), GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
@@ -2339,7 +2339,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
-	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
+	set->tags = kzalloc_node(set->nr_hw_queues * sizeof(*set->tags),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
 		return -ENOMEM;
@@ -2362,7 +2362,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < nr_cpu_ids; i++) {
+	for (i = 0; i < set->nr_hw_queues; i++) {
 		if (set->tags[i])
 			blk_mq_free_rq_map(set, set->tags[i], i);
 	}
-- 
1.8.3.1
