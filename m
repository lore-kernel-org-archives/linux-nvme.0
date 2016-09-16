From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:18 +0200
Subject: [PATCH 07/21] blk-mq: Remove a redundant assignment
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <0922f8f4c395a1df22e21aea98ff446e1ac643a9.1474014910.git.agordeev@redhat.com>

blk_mq_hw_ctx::queue_num is initialized in blk_mq_init_hctx()
function.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 738e109..657e748 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2013,7 +2013,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		atomic_set(&hctxs[i]->nr_active, 0);
 		hctxs[i]->numa_node = node;
-		hctxs[i]->queue_num = i;
 
 		if (blk_mq_init_hctx(q, set, hctxs[i], i)) {
 			free_cpumask_var(hctxs[i]->cpumask);
-- 
1.8.3.1
