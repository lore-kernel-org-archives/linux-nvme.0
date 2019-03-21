From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:25 -0700
Subject: [PATCH 03/15] block: add a rq_dma_dir helper
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-4-hch@lst.de>

In a lot of places we want to know the DMA direction for a given
struct request.  Add a little helper to make it a littler easier.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/blkdev.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f9a072610d28..5279104527ad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -638,6 +638,9 @@ static inline bool blk_account_rq(struct request *rq)
 
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
 
+#define rq_dma_dir(rq) \
+	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
+
 static inline bool queue_is_mq(struct request_queue *q)
 {
 	return q->mq_ops;
-- 
2.20.1
