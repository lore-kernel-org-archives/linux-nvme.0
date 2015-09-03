From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu,  3 Sep 2015 19:28:21 +0300
Subject: [PATCH 2/4] block: Refuse request/bio merges with gaps in the
 integrity payload
In-Reply-To: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
Message-ID: <1441297703-10753-3-git-send-email-sagig@mellanox.com>

If a driver sets the block queue virtual boundary mask, it means that
it cannot handle gaps so we must not allow those in the integrity
payload as well.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-integrity.c  |  3 +++
 block/blk-merge.c      |  6 ++++++
 include/linux/blkdev.h | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index f548b64be092..75f29cf70188 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -204,6 +204,9 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 	    q->limits.max_integrity_segments)
 		return false;
 
+	if (integrity_req_gap_back_merge(req, next->bio))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(blk_integrity_merge_rq);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8fbe79829d79..b4be61f4b65e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -314,6 +314,9 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 {
 	if (req_gap_back_merge(req, bio))
 		return 0;
+	if (blk_integrity_rq(req) &&
+	    integrity_req_gap_back_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -335,6 +338,9 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 
 	if (req_gap_front_merge(req, bio))
 		return 0;
+	if (blk_integrity_rq(req) &&
+	    integrity_req_gap_front_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a65b94480422..dead6088af1c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1393,6 +1393,26 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 	return bio_will_gap(req->q, bio, req->bio);
 }
 
+static inline bool integrity_req_gap_back_merge(struct request *req,
+						struct bio *next)
+{
+	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+	struct bio_integrity_payload *bip_next = bio_integrity(next);
+
+	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
+				bip_next->bip_vec[0].bv_offset);
+}
+
+static inline bool integrity_req_gap_front_merge(struct request *req,
+						 struct bio *bio)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bio_integrity_payload *bip_next = bio_integrity(req->bio);
+
+	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
+				bip_next->bip_vec[0].bv_offset);
+}
+
 struct work_struct;
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_delayed_work(struct delayed_work *dwork, unsigned long delay);
-- 
1.8.4.3
