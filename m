From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:26 -0700
Subject: [PATCH 04/15] block: add dma_map_bvec helper
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-5-hch@lst.de>

Provide a nice little shortcut for mapping a single bvec.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/blkdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5279104527ad..322ff969659c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -641,6 +641,10 @@ static inline bool blk_account_rq(struct request *rq)
 #define rq_dma_dir(rq) \
 	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
 
+#define dma_map_bvec(dev, bv, dir, attrs) \
+	dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, (bv)->bv_len, \
+	(dir), (attrs))
+
 static inline bool queue_is_mq(struct request_queue *q)
 {
 	return q->mq_ops;
-- 
2.20.1
