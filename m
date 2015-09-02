From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 2 Sep 2015 13:18:53 -0600
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55E7324B.3060601@dev.mellanox.co.il>
References: <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
 <55A7D4B6.9020101@kernel.dk> <55ABBFB1.7070201@dev.mellanox.co.il>
 <20150819094003.GB14734@infradead.org>
 <55D45AE0.50805@dev.mellanox.co.il>
 <20150819104246.GA4956@infradead.org>
 <55E6ADA4.5040905@dev.mellanox.co.il>
 <20150902143756.GA11062@kernel.dk>
 <55E7324B.3060601@dev.mellanox.co.il>
Message-ID: <20150902191714.GD14454@kernel.dk>

On Wed, Sep 02 2015, Sagi Grimberg wrote:
> >Does the below work for you?
> 
> It's not on top of Keith virt_boundary patch right?
> First glance looks ok though.

Updated for that.


diff --git a/block/blk-merge.c b/block/blk-merge.c
index b2625271a572..5f35a05337b1 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -436,9 +436,27 @@ no_merge:
 	return 0;
 }
 
+static bool req_gap_to_prev(struct request *req, struct bio *next)
+{
+	struct bio *prev = req->biotail;
+
+	return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
+				next->bi_io_vec[0].bv_offset);
+}
+
+static bool req_gap_to_next(struct request *req, struct bio *bio)
+{
+	struct bio *next = req->bio;
+
+	return bvec_gap_to_prev(req->q, &bio->bi_io_vec[bio->bi_vcnt - 1],
+				next->bi_io_vec[0].bv_offset);
+}
+
 int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		     struct bio *bio)
 {
+	if (bio_has_data(bio) && req_gap_to_prev(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -457,6 +475,9 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		      struct bio *bio)
 {
+
+	if (bio_has_data(bio) && req_gap_to_next(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -483,14 +504,6 @@ static bool req_no_special_merge(struct request *req)
 	return !q->mq_ops && req->special;
 }
 
-static int req_gap_to_prev(struct request *req, struct bio *next)
-{
-	struct bio *prev = req->biotail;
-
-	return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
-			next->bi_io_vec[0].bv_offset);
-}
-
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
@@ -713,10 +726,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
-	/* Only check gaps if the bio carries data */
-	if (bio_has_data(bio) && req_gap_to_prev(rq, bio))
-		return false;
-
 	return true;
 }
 

-- 
Jens Axboe
