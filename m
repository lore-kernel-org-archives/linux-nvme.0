From: sagig@mellanox.com (Sagi Grimberg)
Date: Wed, 15 Jul 2015 16:19:15 +0300
Subject: [PATCH 2/3] block: Refuse request/bio merges with gaps in the
 integrity payload
In-Reply-To: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
Message-ID: <1436966356-8979-3-git-send-email-sagig@mellanox.com>

If a driver turned on QUEUE_FLAG_SG_GAPS, it means that it cannot
handle gaps so we must not allow those in the integrity payload as
well.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-integrity.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 79ffb48..bb18e0a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -189,20 +189,31 @@ EXPORT_SYMBOL(blk_integrity_compare);
 bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 			    struct request *next)
 {
+	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+	struct bio_integrity_payload *bip_next = bio_integrity(next->bio);
+
 	if (blk_integrity_rq(req) == 0 && blk_integrity_rq(next) == 0)
 		return true;
 
 	if (blk_integrity_rq(req) == 0 || blk_integrity_rq(next) == 0)
 		return false;
 
-	if (bio_integrity(req->bio)->bip_flags !=
-	    bio_integrity(next->bio)->bip_flags)
+	if (bip->bip_flags != bip_next->bip_flags)
 		return false;
 
 	if (req->nr_integrity_segments + next->nr_integrity_segments >
 	    q->limits.max_integrity_segments)
 		return false;
 
+	if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS)) {
+		struct bio_vec *iv, *iv_next;
+
+		iv = &bip->bip_vec[bip->bip_vcnt];
+		iv_next = &bip_next->bip_vec[0];
+		if (bvec_gap_to_prev(iv, iv_next->bv_offset))
+			return false;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL(blk_integrity_merge_rq);
@@ -212,16 +223,27 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 {
 	int nr_integrity_segs;
 	struct bio *next = bio->bi_next;
+	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+	struct bio_integrity_payload *bip_next = bio_integrity(bio);
 
-	if (blk_integrity_rq(req) == 0 && bio_integrity(bio) == NULL)
+	if (blk_integrity_rq(req) == 0 && bip_next == NULL)
 		return true;
 
-	if (blk_integrity_rq(req) == 0 || bio_integrity(bio) == NULL)
+	if (blk_integrity_rq(req) == 0 || bip_next == NULL)
 		return false;
 
-	if (bio_integrity(req->bio)->bip_flags != bio_integrity(bio)->bip_flags)
+	if (bip->bip_flags != bip_next->bip_flags)
 		return false;
 
+	if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS)) {
+		struct bio_vec *iv, *iv_next;
+
+		iv = &bip->bip_vec[bip->bip_vcnt - 1];
+		iv_next = &bip_next->bip_vec[bip_next->bip_vcnt];
+		if (bvec_gap_to_prev(iv, iv_next->bv_offset))
+			return false;
+	}
+
 	bio->bi_next = NULL;
 	nr_integrity_segs = blk_rq_count_integrity_sg(q, bio);
 	bio->bi_next = next;
-- 
1.8.4.3
