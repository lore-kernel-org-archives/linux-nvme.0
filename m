From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:21 +0200
Subject: [PATCH 10/21] blk-mq: Get rid of unnecessary blk_mq_free_hw_queues()
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <6869d7cd7b399be88e4f7d4b159cf3f2b67e00d1.1474014910.git.agordeev@redhat.com>

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index de700c8..639b90d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1684,17 +1684,8 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_exit_hctx(q, set, hctx, i);
-}
-
-static void blk_mq_free_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-
 	queue_for_each_hw_ctx(q, hctx, i) {
+		blk_mq_exit_hctx(q, set, hctx, i);
 		free_cpumask_var(hctx->cpumask);
 		kfree(hctx->ctxs);
 		kfree(hctx);
@@ -2130,9 +2121,7 @@ void blk_mq_free_queue(struct request_queue *q)
 	mutex_unlock(&all_q_mutex);
 
 	blk_mq_del_queue_tag_set(q);
-
 	blk_mq_exit_hw_queues(q, set);
-	blk_mq_free_hw_queues(q, set);
 }
 
 /* Basically redo blk_mq_init_queue with queue frozen */
-- 
1.8.3.1
