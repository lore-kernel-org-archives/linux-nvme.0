From: hare@suse.de (Hannes Reinecke)
Date: Tue, 23 Apr 2019 14:29:48 +0200
Subject: [PATCH 2/5] blk-mq: drop 'hctx_idx' argument from blk_mq_alloc_hctx()
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Message-ID: <20190423122951.134531-3-hare@suse.de>

Unused.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 block/blk-mq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6f016d0cc69b..d16672bfa97d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2324,8 +2324,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
 static struct blk_mq_hw_ctx *
 blk_mq_alloc_hctx(struct request_queue *q,
-		  struct blk_mq_tag_set *set,
-		  unsigned hctx_idx, int node)
+		  struct blk_mq_tag_set *set, int node)
 {
 	struct blk_mq_hw_ctx *hctx;
 
@@ -2753,7 +2752,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 	spin_unlock(&q->unused_hctx_lock);
 
 	if (!hctx)
-		hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
+		hctx = blk_mq_alloc_hctx(q, set, node);
 	if (!hctx)
 		goto fail;
 
-- 
2.16.4
