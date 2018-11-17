From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 17 Nov 2018 14:43:54 -0700
Subject: [PATCH 7/7] blk-mq: ensure mq_ops ->poll() is entered at least once
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Message-ID: <20181117214354.822-8-axboe@kernel.dk>

Right now we immediately bail if need_resched() is true, but
we need to do at least one loop in case we have entries waiting.
So just invert the need_resched() check, putting it at the
bottom of the loop.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0a2847d9248b..4769c975b8c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3336,7 +3336,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, bool spin)
 	hctx->poll_considered++;
 
 	state = current->state;
-	while (!need_resched()) {
+	do {
 		int ret;
 
 		hctx->poll_invoked++;
@@ -3356,7 +3356,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, bool spin)
 		if (ret < 0 || !spin)
 			break;
 		cpu_relax();
-	}
+	} while (!need_resched());
 
 	__set_current_state(TASK_RUNNING);
 	return 0;
-- 
2.17.1
