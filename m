From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:57:55 -0700
Subject: [PATCHv2 01/10] blk-mq: Wake tasks entering queue on dying
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420599484-21582-2-git-send-email-keith.busch@intel.com>

When the queue is set to dying, wake up tasks that are waiting on frozen
queue so they realize it is dying and abandon their request.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1a41d7a..6d83ee6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -160,6 +160,7 @@ void blk_mq_wake_waiters(struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i)
 		if (blk_mq_hw_queue_mapped(hctx))
 			blk_mq_tag_wakeup_all(hctx->tags, true);
+	wake_up_all(&q->mq_freeze_wq);
 }
 
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
-- 
1.7.10.4
