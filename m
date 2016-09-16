From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:22 +0200
Subject: [PATCH 11/21] blk-mq: Move duplicating code to blk_mq_exit_hctx()
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <fa69d010306494eef83ab65a922bc1e778f2b752.1474014910.git.agordeev@redhat.com>

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 639b90d..9b1b6dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1676,6 +1676,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
 	blk_free_flush_queue(hctx->fq);
 	blk_mq_free_bitmap(&hctx->ctx_map);
+
+	free_cpumask_var(hctx->cpumask);
+	kfree(hctx->ctxs);
+	kfree(hctx);
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
@@ -1684,12 +1688,8 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
+	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_exit_hctx(q, set, hctx, i);
-		free_cpumask_var(hctx->cpumask);
-		kfree(hctx->ctxs);
-		kfree(hctx);
-	}
 
 	q->nr_hw_queues = 0;
 }
@@ -2018,12 +2018,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 				set->tags[j] = NULL;
 			}
 			blk_mq_exit_hctx(q, set, hctx, j);
-			free_cpumask_var(hctx->cpumask);
 			kobject_put(&hctx->kobj);
-			kfree(hctx->ctxs);
-			kfree(hctx);
 			hctxs[j] = NULL;
-
 		}
 	}
 	q->nr_hw_queues = i;
-- 
1.8.3.1
