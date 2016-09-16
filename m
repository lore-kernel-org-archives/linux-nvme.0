From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:13 +0200
Subject: [PATCH 02/21] blk-mq: Fix a potential NULL pointer assignment to hctx
 tags
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <68f41dd5411b38b4585d7ae92126e4c668e38390.1474014910.git.agordeev@redhat.com>

If number of used hardware queues is dynamically decreased
then tags corresponding to the newly unused queues are freed.

If previously unused hardware queues are then reused again
they will start referring the previously freed tags.

CC: Jens Axboe <axboe at fb.com>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90e3fef..1cacf83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2005,6 +2005,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		if (hctxs[i])
 			continue;
+		if (!set->tags[i])
+			break;
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
 		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
-- 
1.8.3.1
