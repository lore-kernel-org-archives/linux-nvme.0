From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Tue,  8 Oct 2013 11:34:21 +0200
Subject: [PATCH RFC 1/2] blk-mq: call exit_hctx on hw queue teardown
In-Reply-To: <1381224862-5299-1-git-send-email-m@bjorling.me>
References: <1381224862-5299-1-git-send-email-m@bjorling.me>
Message-ID: <1381224862-5299-2-git-send-email-m@bjorling.me>

The driver initialize itself using init_hctx and reverts using exit_hctx if
unsucessful. exit_hctx is missing on normal hw queue teardown.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
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
