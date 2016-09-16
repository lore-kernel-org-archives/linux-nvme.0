From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:27 +0200
Subject: [PATCH 16/21] blk-mq: Set flush_start_tag to BLK_MQ_MAX_DEPTH
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <fbb562dc442b4dbf9203750468b54ec1922341cb.1474014910.git.agordeev@redhat.com>

We need flush tags unique across hardware contexts and do
not overlap with normal tags. BLK_MQ_MAX_DEPTH as a base
number seems better choise than a queue's depth.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e14f7e8..c27e64e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1661,14 +1661,12 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
-	unsigned flush_start_tag = set->queue_depth;
-
 	blk_mq_tag_idle(hctx);
 
 	if (set->ops->exit_request)
 		set->ops->exit_request(set->driver_data,
 				       hctx->fq->flush_rq, hctx_idx,
-				       flush_start_tag + hctx_idx);
+				       BLK_MQ_MAX_DEPTH + hctx_idx);
 
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -1697,7 +1695,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set, unsigned hctx_idx)
 {
-	unsigned flush_start_tag = set->queue_depth;
 	struct blk_mq_hw_ctx *hctx;
 	int node;
 
@@ -1751,7 +1748,7 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	if (set->ops->init_request &&
 	    set->ops->init_request(set->driver_data,
 				   hctx->fq->flush_rq, hctx_idx,
-				   flush_start_tag + hctx_idx, node))
+				   BLK_MQ_MAX_DEPTH + hctx_idx, node))
 		goto exit_hctx;
 
 	return hctx;
-- 
1.8.3.1
