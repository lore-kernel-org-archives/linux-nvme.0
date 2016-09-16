From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:19 +0200
Subject: [PATCH 08/21] blk-mq: Cleanup hardware context data node selection
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <72421ea88f3bbebe37673a57b50da5638d88fe67.1474014910.git.agordeev@redhat.com>

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 657e748..d40013c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1710,13 +1710,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
-	int node;
+	int node = hctx->numa_node;
 	unsigned flush_start_tag = set->queue_depth;
 
-	node = hctx->numa_node;
-	if (node == NUMA_NO_NODE)
-		node = hctx->numa_node = set->numa_node;
-
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
 	spin_lock_init(&hctx->lock);
@@ -1999,6 +1995,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			break;
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
+		if (node == NUMA_NO_NODE)
+			node = set->numa_node;
+
 		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
 					GFP_KERNEL, node);
 		if (!hctxs[i])
-- 
1.8.3.1
