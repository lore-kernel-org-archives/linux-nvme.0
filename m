From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 3 Sep 2015 09:04:47 -0600
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55E80DD4.9000505@dev.mellanox.co.il>
References: <55A7D4B6.9020101@kernel.dk> <55ABBFB1.7070201@dev.mellanox.co.il>
 <20150819094003.GB14734@infradead.org>
 <55D45AE0.50805@dev.mellanox.co.il>
 <20150819104246.GA4956@infradead.org>
 <55E6ADA4.5040905@dev.mellanox.co.il>
 <20150902143756.GA11062@kernel.dk>
 <55E7324B.3060601@dev.mellanox.co.il>
 <20150902191714.GD14454@kernel.dk>
 <55E80DD4.9000505@dev.mellanox.co.il>
Message-ID: <20150903150447.GA24222@kernel.dk>

On Thu, Sep 03 2015, Sagi Grimberg wrote:
> On 9/2/2015 10:18 PM, Jens Axboe wrote:
> >On Wed, Sep 02 2015, Sagi Grimberg wrote:
> >>>Does the below work for you?
> >>
> >>It's not on top of Keith virt_boundary patch right?
> >>First glance looks ok though.
> >
> >Updated for that.
> >
> 
> Thanks Jens,
> 
> I'll test it.

Cleaned up version, unified the gap checking and changed the names of
the function to make it easier to understand. And then we only need to
check bio_has_data() in bio_will_gap().

Functionally it should be identical to the previous one.


diff --git a/block/blk-merge.c b/block/blk-merge.c
index cce23ba1ae5f..bf9c45ddcd11 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -435,9 +435,31 @@ no_merge:
 	return 0;
 }
 
+static bool bio_will_gap(struct request_queue *q, struct bio *prev,
+			 struct bio *next)
+{
+	if (!bio_has_data(prev))
+		return false;
+
+	return bvec_gap_to_prev(q, &prev->bi_io_vec[prev->bi_vcnt - 1],
+				next->bi_io_vec[0].bv_offset);
+}
+
+static bool req_gap_back_merge(struct request *req, struct bio *next)
+{
+	return bio_will_gap(req->q, req->biotail, next);
+}
+
+static bool req_gap_front_merge(struct request *req, struct bio *bio)
+{
+	return bio_will_gap(req->q, bio, req->bio);
+}
+
 int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		     struct bio *bio)
 {
+	if (req_gap_back_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -456,6 +478,9 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		      struct bio *bio)
 {
+
+	if (req_gap_front_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -482,14 +507,6 @@ static bool req_no_special_merge(struct request *req)
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
@@ -504,7 +521,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (req_no_special_merge(req) || req_no_special_merge(next))
 		return 0;
 
-	if (req_gap_to_prev(req, next->bio))
+	if (req_gap_back_merge(req, next->bio))
 		return 0;
 
 	/*
@@ -712,10 +729,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
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
