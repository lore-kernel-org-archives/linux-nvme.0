From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:26 -0600
Subject: [RFC PATCH 14/28] block: Support splitting dma-direct bios
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-15-logang@deltatee.com>

If the bio is a dma-direct bio, loop through the dma_vecs instead
of the bio_vecs when calling vec_should_split().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 block/blk-merge.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 32653fca53ce..c4c016f994f6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -257,14 +257,44 @@ static bool vec_should_split(struct request_queue *q, unsigned offset,
 	return false;
 }
 
+static bool bio_should_split(struct request_queue *q, struct bio *bio,
+			     struct blk_segment_split_ctx *ctx)
+{
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	bool ret;
+
+	bio_for_each_bvec(bv, bio, iter) {
+		ret = vec_should_split(q, bv.bv_offset, bv.bv_len, ctx);
+		if (ret)
+			return true;
+	}
+
+	return false;
+}
+
+static bool bio_dma_should_split(struct request_queue *q, struct bio *bio,
+				 struct blk_segment_split_ctx *ctx)
+{
+	struct bvec_iter iter;
+	struct dma_vec dv;
+	bool ret;
+
+	bio_for_each_dvec(dv, bio, iter) {
+		ret = vec_should_split(q, dv.dv_addr, dv.dv_len, ctx);
+		if (ret)
+			return true;
+	}
+
+	return false;
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
 					 unsigned *segs)
 {
-	struct bio_vec bv;
-	struct bvec_iter iter;
-	bool do_split = false;
+	bool do_split;
 	struct bio *new = NULL;
 
 	struct blk_segment_split_ctx ctx = {
@@ -272,11 +302,10 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		.max_segs = queue_max_segments(q),
 	};
 
-	bio_for_each_bvec(bv, bio, iter) {
-		do_split = vec_should_split(q, bv.bv_offset, bv.bv_len, &ctx);
-		if (do_split)
-			break;
-	}
+	if (bio_is_dma_direct(bio))
+		do_split = bio_dma_should_split(q, bio, &ctx);
+	else
+		do_split = bio_should_split(q, bio, &ctx);
 
 	*segs = ctx.nsegs;
 
-- 
2.20.1
