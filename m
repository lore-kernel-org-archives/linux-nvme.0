From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:12 +0200
Subject: [PATCH 01/21] blk-mq: Fix memory leaks on a queue cleanup
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <0afd4f6e8c2b1b4aa109b87940d9db466b60b53e.1474014910.git.agordeev@redhat.com>

Some data are leaked when blk_cleanup_queue() interface
is called.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 13f5a6c..90e3fef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1707,8 +1707,13 @@ static void blk_mq_free_hw_queues(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i)
+	queue_for_each_hw_ctx(q, hctx, i) {
 		free_cpumask_var(hctx->cpumask);
+		kfree(hctx->ctxs);
+		kfree(hctx);
+	}
+
+	q->nr_hw_queues = 0;
 }
 
 static int blk_mq_init_hctx(struct request_queue *q,
-- 
1.8.3.1
