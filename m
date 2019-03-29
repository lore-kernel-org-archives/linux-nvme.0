From: joshi.k@samsung.com (Kanchan Joshi)
Date: Fri, 29 Mar 2019 13:23:48 +0530
Subject: [PATCH v3 3/7] block: add write-hint to stream-id conversion
In-Reply-To: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075749epcas2p22b85cbdbb7ccb4f7f3ecf69b84f75dc9@epcas2p2.samsung.com>
Message-ID: <1553846032-4451-4-git-send-email-joshi.k@samsung.com>

Earlier this conversion was done by driver (nvme). Current conversion
is of the form "streamid = write-hint - 1", for both user and kernel
streams (note that existing infra takes care that user-streams do not
bump into kernel ones). Conversion takes stream limit (maintained in
request queue) into account. Write-hints beyond the queue-limit turn
to 0.
New field 'streamid' has been added in request. While 'write-hint' field
continues to exist. It keeps original value passed from upper layer, and
used during merging checks.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 block/blk-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3c5f61c..c86daed 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -727,6 +727,25 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
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
@@ -735,6 +754,7 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 	req->__sector = bio->bi_iter.bi_sector;
 	req->ioprio = bio_prio(bio);
 	req->write_hint = bio->bi_write_hint;
+	req->streamid = blk_write_hint_to_streamid(req, bio);
 	blk_rq_bio_prep(req->q, req, bio);
 }
 EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
-- 
2.7.4
