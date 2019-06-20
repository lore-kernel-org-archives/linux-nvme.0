From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:21 -0600
Subject: [RFC PATCH 09/28] block: Introduce vec_gap_to_prev()
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-10-logang@deltatee.com>

Introduce vec_gap_to_prev() which is a more general
form of bvec_gap_to_prev().

In order to support splitting dma_vecs we will need to do a similar
calcualtion using the DMA address and length.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 block/blk.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 4142383eed7a..c5512fefe703 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -98,11 +98,19 @@ static inline bool dmavec_phys_mergeable(struct request_queue *q,
 				  vec2->dv_addr, vec2->dv_len);
 }
 
+static inline bool __vec_gap_to_prev(struct request_queue *q,
+		unsigned int prv_offset, unsigned int prv_len,
+		unsigned int nxt_offset)
+{
+	return (nxt_offset & queue_virt_boundary(q)) ||
+		((prv_offset + prv_len) & queue_virt_boundary(q));
+}
+
 static inline bool __bvec_gap_to_prev(struct request_queue *q,
 		struct bio_vec *bprv, unsigned int offset)
 {
-	return (offset & queue_virt_boundary(q)) ||
-		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
+	return __vec_gap_to_prev(q, bprv->bv_offset, bprv->bv_len,
+				 offset);
 }
 
 /*
@@ -117,6 +125,15 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
+static inline bool vec_gap_to_prev(struct request_queue *q,
+		unsigned int prv_offset, unsigned int prv_len,
+		unsigned int nxt_offset)
+{
+	if (!queue_virt_boundary(q))
+		return false;
+	return __vec_gap_to_prev(q, prv_offset, prv_len, nxt_offset);
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
-- 
2.20.1
