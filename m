From: sagig@mellanox.com (Sagi Grimberg)
Date: Wed, 15 Jul 2015 16:19:14 +0300
Subject: [PATCH 1/3] block: copy multi iovec user mappings if
 QUEUE_FLAG_SG_GAPS is set
In-Reply-To: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
Message-ID: <1436966356-8979-2-git-send-email-sagig@mellanox.com>

From: Christoph Hellwig <hch@lst.de>

For drivers that don't support gaps in the SG lists handed to them we must
not create bios from multiple iovecs as they can be (and usually are)
discontiguous.  This doesn't matter for any current user, but will help
to allow iSER which can't handle gaps to use the QUEUE_FLAG_SG_GAPS flag
instead of using driver-local bounce buffering.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index da310a1..86962eb 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -85,7 +85,9 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 			unaligned = 1;
 	}
 
-	if (unaligned || (q->dma_pad_mask & iter->count) || map_data)
+	if (unaligned || map_data ||
+	    (q->dma_pad_mask & iter->count) ||
+	    ((q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) && iter->nr_segs > 1)))
 		bio = bio_copy_user_iov(q, map_data, iter, gfp_mask);
 	else
 		bio = bio_map_user_iov(q, iter, gfp_mask);
-- 
1.8.4.3
