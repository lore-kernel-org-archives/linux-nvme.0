From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:19 -0600
Subject: [RFC PATCH 07/28] block: Use dma_vec length in bio_cur_bytes() for
 dma-direct bios
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-8-logang@deltatee.com>

For dma-direct bios, use the dv_len of the current vector
seeing the bio_vec's are not valid in such a context.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 include/linux/bio.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index e212e5958a75..df7973932525 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -91,10 +91,12 @@ static inline bool bio_mergeable(struct bio *bio)
 
 static inline unsigned int bio_cur_bytes(struct bio *bio)
 {
-	if (bio_has_data(bio))
-		return bio_iovec(bio).bv_len;
-	else /* dataless requests such as discard */
+	if (!bio_has_data(bio)) /* dataless requests such as discard */
 		return bio->bi_iter.bi_size;
+	else if (op_is_dma_direct(bio->bi_opf))
+		return bio_dma_vec(bio).dv_len;
+	else
+		return bio_iovec(bio).bv_len;
 }
 
 static inline void *bio_data(struct bio *bio)
-- 
2.20.1
