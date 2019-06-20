From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:18 -0600
Subject: [RFC PATCH 06/28] block: Support dma-direct bios in bio_advance_iter()
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-7-logang@deltatee.com>

Dma-direct bio iterators need to be advanced using a similar
dvec_iter_advance helper.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 include/linux/bio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8180309123d7..e212e5958a75 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -134,6 +134,8 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -= bytes;
+	else if (op_is_dma_direct(bio->bi_opf))
+		dvec_iter_advance(bio->bi_dma_vec, iter, bytes);
 	else
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
-- 
2.20.1
