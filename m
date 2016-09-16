From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:23 +0200
Subject: [PATCH 12/21] blk-mq: Uninit hardware context in order reverse to init
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <7271ebd6abff4732d6eabb39d02e8e1519a6fa86.1474014910.git.agordeev@redhat.com>

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9b1b6dc..f2bae1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2013,12 +2013,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
 		if (hctx) {
+			kobject_put(&hctx->kobj);
+
 			if (hctx->tags) {
 				blk_mq_free_rq_map(set, hctx->tags, j);
 				set->tags[j] = NULL;
 			}
 			blk_mq_exit_hctx(q, set, hctx, j);
-			kobject_put(&hctx->kobj);
 			hctxs[j] = NULL;
 		}
 	}
-- 
1.8.3.1
