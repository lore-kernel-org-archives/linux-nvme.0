From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:24 -0600
Subject: [RFC PATCH 12/28] block: Create helper for bvec_should_split()
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-13-logang@deltatee.com>

In order to support dma-direct bios, blk_bio_segment_split() will
need to operate on both bio_vecs and dma_vecs. In order to do
this, the code inside bio_for_each_bvec() is moved into a generic
helper called bvec_should_split().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 block/blk-merge.c | 86 +++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 414e61a714bf..d9e89c0ad40d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -212,6 +212,48 @@ struct blk_segment_split_ctx {
 	const unsigned max_segs;
 };
 
+static bool bvec_should_split(struct request_queue *q, struct bio_vec *bv,
+			      struct blk_segment_split_ctx *ctx)
+{
+	/*
+	 * If the queue doesn't support SG gaps and adding this
+	 * offset would create a gap, disallow it.
+	 */
+	if (ctx->prv_valid && bvec_gap_to_prev(q, &ctx->bvprv, bv->bv_offset))
+		return true;
+
+	if (ctx->sectors + (bv->bv_len >> 9) > ctx->max_sectors) {
+		/*
+		 * Consider this a new segment if we're splitting in
+		 * the middle of this vector.
+		 */
+		if (ctx->nsegs < ctx->max_segs &&
+		    ctx->sectors < ctx->max_sectors) {
+			/* split in the middle of bvec */
+			bv->bv_len = (ctx->max_sectors - ctx->sectors) << 9;
+			bvec_split_segs(q, bv, &ctx->nsegs,
+					&ctx->sectors, ctx->max_segs);
+		}
+		return true;
+	}
+
+	if (ctx->nsegs == ctx->max_segs)
+		return true;
+
+	ctx->bvprv = *bv;
+	ctx->prv_valid = true;
+
+	if (bv->bv_offset + bv->bv_len <= PAGE_SIZE) {
+		ctx->nsegs++;
+		ctx->sectors += bv->bv_len >> 9;
+	} else if (bvec_split_segs(q, bv, &ctx->nsegs, &ctx->sectors,
+				   ctx->max_segs)) {
+		return true;
+	}
+
+	return false;
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
@@ -219,7 +261,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 {
 	struct bio_vec bv;
 	struct bvec_iter iter;
-	bool do_split = true;
+	bool do_split = false;
 	struct bio *new = NULL;
 
 	struct blk_segment_split_ctx ctx = {
@@ -228,47 +270,11 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	};
 
 	bio_for_each_bvec(bv, bio, iter) {
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, disallow it.
-		 */
-		if (ctx.prv_valid && bvec_gap_to_prev(q, &ctx.bvprv,
-						      bv.bv_offset))
-			goto split;
-
-		if (ctx.sectors + (bv.bv_len >> 9) > ctx.max_sectors) {
-			/*
-			 * Consider this a new segment if we're splitting in
-			 * the middle of this vector.
-			 */
-			if (ctx.nsegs < ctx.max_segs &&
-			    ctx.sectors < ctx.max_sectors) {
-				/* split in the middle of bvec */
-				bv.bv_len =
-					(ctx.max_sectors - ctx.sectors) << 9;
-				bvec_split_segs(q, &bv, &ctx.nsegs,
-						&ctx.sectors, ctx.max_segs);
-			}
-			goto split;
-		}
-
-		if (ctx.nsegs == ctx.max_segs)
-			goto split;
-
-		ctx.bvprv = bv;
-		ctx.prv_valid = true;
-
-		if (bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
-			ctx.nsegs++;
-			ctx.sectors += bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &ctx.nsegs, &ctx.sectors,
-				ctx.max_segs)) {
-			goto split;
-		}
+		do_split = bvec_should_split(q, &bv, &ctx);
+		if (do_split)
+			break;
 	}
 
-	do_split = false;
-split:
 	*segs = ctx.nsegs;
 
 	if (do_split) {
-- 
2.20.1
