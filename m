From: hare@suse.de (Hannes Reinecke)
Date: Tue, 23 Apr 2019 14:29:50 +0200
Subject: [PATCH 4/5] blk-mq: Set hctx pointer to NULL in
 blk_mq_exit_hw_queues()
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Message-ID: <20190423122951.134531-5-hare@suse.de>

When clearing the hardware context we should be setting the pointer
to NULL, too, to avoid accesses to invalid hctx entries.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3da453b11deb..f620462dc4d1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2275,6 +2275,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
+		q->queue_hw_ctx[i] = NULL;
 	}
 }
 
-- 
2.16.4
