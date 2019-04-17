From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 17 Apr 2019 23:20:03 +0530
Subject: [PATCH v4 4/7] block: introduce write-hint to stream-id conversion
In-Reply-To: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
References: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
 <CGME20190417175358epcas1p41a0a4e349dfe0a70bdcc244161c71604@epcas1p4.samsung.com>
Message-ID: <1555523406-2380-5-git-send-email-joshi.k@samsung.com>

This patch moves write-hint-to-stream-id conversion in block-layer.
Earlier this was done by driver (nvme). Current conversion is of the
form "streamid = write-hint - 1", for both user and kernel streams.
Conversion takes stream limit (maintained in request queue) into
account. Write-hints beyond the exposed limit turn to 0.
A new field 'streamid' has been added in request. While 'write-hint'
field continues to exist. It keeps original value passed from upper
layer, and used during merging checks.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 block/blk-core.c       | 20 ++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index a55389b..712e6b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -730,6 +730,25 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	return false;
 }
 
+enum rw_hint blk_write_hint_to_streamid(struct request *req,
+				        struct bio *bio)
+{
+	enum rw_hint streamid, nr_streams;
+	struct request_queue *q = req->q;
+	nr_streams = q->limits.nr_streams;
+
+	streamid = bio->bi_write_hint;
+	if (!nr_streams || streamid == WRITE_LIFE_NOT_SET ||
+	    streamid == WRITE_LIFE_NONE)
+		streamid = 0;
+	else {
+		--streamid;
+		if(streamid > nr_streams)
+			streamid = 0;
+	}
+	return streamid;
+}
+
 void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
 	if (bio->bi_opf & REQ_RAHEAD)
@@ -738,6 +757,7 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 	req->__sector = bio->bi_iter.bi_sector;
 	req->ioprio = bio_prio(bio);
 	req->write_hint = bio->bi_write_hint;
+	req->streamid = blk_write_hint_to_streamid(req, bio);
 	blk_rq_bio_prep(req->q, req, bio);
 }
 EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eb6eb60..7cd1c2d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -217,6 +217,7 @@ struct request {
 #endif
 
 	unsigned short write_hint;
+	unsigned short streamid;
 	unsigned short ioprio;
 
 	unsigned int extra_len;	/* length of alignment and padding */
-- 
2.7.4
