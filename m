From: keith.busch@intel.com (Keith Busch)
Date: Tue,  1 Sep 2015 10:46:44 -0600
Subject: [PATCH] blk: Fix bio_io_vec index when checking bvec gaps
Message-ID: <1441126004-19708-1-git-send-email-keith.busch@intel.com>

Corrects a coding error from earlier patch.

Reported by: Sagi Grimberg <sagig at dev.mellanox.co.il>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-merge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 53bb485..d088cff 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -488,7 +488,7 @@ static int req_gap_to_prev(struct request *req, struct bio *next)
 	struct bio *prev = req->biotail;
 
 	return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
-			next->bi_io_vec[1].bv_offset);
+			next->bi_io_vec[0].bv_offset);
 }
 
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
-- 
1.7.10.4
