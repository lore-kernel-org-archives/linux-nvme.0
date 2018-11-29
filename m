From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Nov 2018 20:13:10 +0100
Subject: [PATCH 13/13] block: enable polling by default if a poll map is
 initalized
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
Message-ID: <20181129191310.9795-14-hch@lst.de>

If the user did setup polling in the driver we should not require
another know in the block layer to enable it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c90c5038d07..a550a00ac00c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2811,6 +2811,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
+	if (set->nr_maps > HCTX_TYPE_POLL)
+		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
 		blk_queue_flag_set(QUEUE_FLAG_NO_SG_MERGE, q);
-- 
2.19.1
