From: m@bjorling.me (Matias Bjorling)
Date: Fri, 18 Oct 2013 15:14:20 +0200
Subject: [PATCH 1/3] blk-mq: call exit_hctx on hw queue teardown
In-Reply-To: <1382102062-22270-1-git-send-email-m@bjorling.me>
References: <1382102062-22270-1-git-send-email-m@bjorling.me>
Message-ID: <1382102062-22270-2-git-send-email-m@bjorling.me>

The driver initializes itself using init_hctx and reverts using exit_hctx if
unsucessful. exit_hctx is missing on normal hw queue teardown.

Signed-off-by: Matias Bjorling <m at bjorling.me>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 923e9e1..5b054b7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1390,6 +1390,8 @@ void blk_mq_free_queue(struct request_queue *q)
 		kfree(hctx->ctxs);
 		blk_mq_free_rq_map(hctx);
 		blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
+		if (q->mq_ops->exit_hctx)
+			q->mq_ops->exit_hctx(hctx, i);
 		q->mq_ops->free_hctx(hctx, i);
 	}
 
-- 
1.8.1.2
