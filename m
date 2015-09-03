From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu,  3 Sep 2015 19:28:20 +0300
Subject: [PATCH 1/4] block: Check for gaps on front and back merges
In-Reply-To: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
Message-ID: <1441297703-10753-2-git-send-email-sagig@mellanox.com>

From: Jens Axboe <axboe@fb.com>

We are checking for gaps to previous bio_vec, which can
only detect back merges gaps. Moreover, at the point where
we check for a gap, we don't know if we will attempt a back
or a front merge. Thus, check for gap to prev in a back merge
attempt and check for a gap to next in a front merge attempt.

Signed-off-by: Jens Axboe <axboe at fb.com>
[sagig: Minor rename change]
Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-merge.c      | 19 ++++++-------------
 include/linux/blkdev.h | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 09bf5cb116e2..8fbe79829d79 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -312,6 +312,8 @@ no_merge:
 int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		     struct bio *bio)
 {
+	if (req_gap_back_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -330,6 +332,9 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		      struct bio *bio)
 {
+
+	if (req_gap_front_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -356,14 +361,6 @@ static bool req_no_special_merge(struct request *req)
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
@@ -378,7 +375,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (req_no_special_merge(req) || req_no_special_merge(next))
 		return 0;
 
-	if (req_gap_to_prev(req, next->bio))
+	if (req_gap_back_merge(req, next->bio))
 		return 0;
 
 	/*
@@ -586,10 +583,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
-	/* Only check gaps if the bio carries data */
-	if (bio_has_data(bio) && req_gap_to_prev(rq, bio))
-		return false;
-
 	return true;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 68adec9da25f..a65b94480422 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1373,6 +1373,26 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
 }
 
+static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
+			 struct bio *next)
+{
+	if (!bio_has_data(prev))
+		return false;
+
+	return bvec_gap_to_prev(q, &prev->bi_io_vec[prev->bi_vcnt - 1],
+				next->bi_io_vec[0].bv_offset);
+}
+
+static inline bool req_gap_back_merge(struct request *req, struct bio *bio)
+{
+	return bio_will_gap(req->q, req->biotail, bio);
+}
+
+static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
+{
+	return bio_will_gap(req->q, bio, req->bio);
+}
+
 struct work_struct;
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_delayed_work(struct delayed_work *dwork, unsigned long delay);
-- 
1.8.4.3
