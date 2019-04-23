From: hare@suse.de (Hannes Reinecke)
Date: Tue, 23 Apr 2019 14:29:49 +0200
Subject: [PATCH 3/5] blk-mq: remove 'nr_queue' argument in
 blk_mq_exit_hw_queues()
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Message-ID: <20190423122951.134531-4-hare@suse.de>

Unused.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 block/blk-mq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d16672bfa97d..3da453b11deb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2267,14 +2267,12 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set, int nr_queue)
+		struct blk_mq_tag_set *set)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (i == nr_queue)
-			break;
 		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
@@ -2930,7 +2928,7 @@ void blk_mq_exit_queue(struct request_queue *q)
 	struct blk_mq_tag_set	*set = q->tag_set;
 
 	blk_mq_del_queue_tag_set(q);
-	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
+	blk_mq_exit_hw_queues(q, set);
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
-- 
2.16.4
