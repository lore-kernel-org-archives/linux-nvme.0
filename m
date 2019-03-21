From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:23 -0700
Subject: [PATCH 01/15] block: add a req_bvec helper
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-2-hch@lst.de>

Return the currently active bvec segment, potentially spanning multiple
pages.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0de92b29f589..255e20313cde 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -929,6 +929,13 @@ static inline unsigned int blk_rq_payload_bytes(struct request *rq)
 	return blk_rq_bytes(rq);
 }
 
+static inline struct bio_vec req_bvec(struct request *rq)
+{
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return rq->special_vec;
+	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
+}
+
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     int op)
 {
-- 
2.20.1
