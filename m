From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:49 +0200
Subject: [PATCH 01/10] blk-mq: avoid setting hctx->tags->cpumask before
 allocation
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-2-git-send-email-hch@lst.de>

From: Akinobu Mita <akinobu.mita@gmail.com>

When unmapped hw queue is remapped after CPU topology is changed,
hctx->tags->cpumask has to be set after hctx->tags is setup in
blk_mq_map_swqueue(), otherwise it causes null pointer dereference.

Fixes: f26cdc8536 ("blk-mq: Shared tag enhancements")
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at kernel.dk>
Cc: Ming Lei <tom.leiming at gmail.com>
---
 block/blk-mq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2d67b4..2fd7283 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1811,7 +1811,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		hctx = q->mq_ops->map_queue(q, i);
 		cpumask_set_cpu(i, hctx->cpumask);
-		cpumask_set_cpu(i, hctx->tags->cpumask);
 		ctx->index_hw = hctx->nr_ctx;
 		hctx->ctxs[hctx->nr_ctx++] = ctx;
 	}
@@ -1851,6 +1850,14 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->next_cpu = cpumask_first(hctx->cpumask);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
+
+	queue_for_each_ctx(q, ctx, i) {
+		if (!cpu_online(i))
+			continue;
+
+		hctx = q->mq_ops->map_queue(q, i);
+		cpumask_set_cpu(i, hctx->tags->cpumask);
+	}
 }
 
 static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set)
-- 
1.9.1
