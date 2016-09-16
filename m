From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:20 +0200
Subject: [PATCH 09/21] blk-mq: Cleanup a loop exit condition
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <aef4bf736941c5105318f1a517a8d5b613d1b1dd.1474014910.git.agordeev@redhat.com>

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d40013c..de700c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1679,16 +1679,13 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set, int nr_queue)
+		struct blk_mq_tag_set *set)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (i == nr_queue)
-			break;
+	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_exit_hctx(q, set, hctx, i);
-	}
 }
 
 static void blk_mq_free_hw_queues(struct request_queue *q,
@@ -2134,7 +2131,7 @@ void blk_mq_free_queue(struct request_queue *q)
 
 	blk_mq_del_queue_tag_set(q);
 
-	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
+	blk_mq_exit_hw_queues(q, set);
 	blk_mq_free_hw_queues(q, set);
 }
 
-- 
1.8.3.1
