From: joshi.k@samsung.com (Kanchan Joshi)
Date: Thu, 25 Apr 2019 16:49:59 +0530
Subject: [PATCH v5 4/7] block: introduce write-hint to stream-id conversion
In-Reply-To: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
References: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <CGME20190425112400epcas1p26e7634f95a185a83c31470006d291161@epcas1p2.samsung.com>
Message-ID: <1556191202-3245-5-git-send-email-joshi.k@samsung.com>

This patch moves write-hint-to-stream-id conversion in block-layer.
Earlier this was done by driver (nvme). For user write-hints, conversion
is of the form "streamid = write-hint - 1". For kernel write-hints,
streams are allocated in top-to-bottom fashion. This has the effect of
mapping user-hints to lower range of stream-ids and kernel-hints to upper
range of stream-ids.
Conversion takes stream limit (maintained in request queue) into
account. Write-hints beyond the exposed limit turn to 0.
A new field 'streamid' has been added in request, while 'write-hint'
field has been removed. For merging checks, 'bi_write_hint' (of bio) is
used instead.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 block/blk-core.c         | 29 ++++++++++++++++++++++++++++-
 block/blk-merge.c        |  4 ++--
 drivers/nvme/host/core.c |  7 ++-----
 include/linux/blkdev.h   |  2 +-
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a55389b..0485c20 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -730,6 +730,33 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	return false;
 }
 
+enum rw_hint blk_write_hint_to_streamid(struct request *req,
+					struct bio *bio)
+{
+	enum rw_hint streamid, write_hint, nr_streams;
+	struct request_queue *q = req->q;
+
+	nr_streams = q->limits.nr_streams;
+
+	write_hint = bio->bi_write_hint;
+
+	if (!nr_streams || write_hint == WRITE_LIFE_NOT_SET ||
+	    write_hint == WRITE_LIFE_NONE)
+		streamid = 0;
+	else if (write_hint < WRITE_LIFE_KERN_MIN) { /*user-space hints*/
+		streamid = write_hint - 1;
+		if (streamid > nr_streams)
+			streamid = 0;
+	} else { /* kernel hints */
+		streamid = write_hint - WRITE_LIFE_KERN_MIN + 1;
+		if (streamid > (nr_streams - BLK_MAX_USER_HINTS))
+			streamid = 0;
+		else
+			streamid = nr_streams - streamid + 1;
+	}
+	return streamid;
+}
+
 void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
 	if (bio->bi_opf & REQ_RAHEAD)
@@ -737,7 +764,7 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 
 	req->__sector = bio->bi_iter.bi_sector;
 	req->ioprio = bio_prio(bio);
-	req->write_hint = bio->bi_write_hint;
+	req->streamid = blk_write_hint_to_streamid(req, bio);
 	blk_rq_bio_prep(req->q, req, bio);
 }
 EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1c9d4f0..1435634 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -832,7 +832,7 @@ static struct request *attempt_merge(struct request_queue *q,
 	 * Don't allow merge of different write hints, or for a hint with
 	 * non-hint IO.
 	 */
-	if (req->write_hint != next->write_hint)
+	if (req->bio->bi_write_hint != next->bio->bi_write_hint)
 		return NULL;
 
 	if (req->ioprio != next->ioprio)
@@ -964,7 +964,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	 * Don't allow merge of different write hints, or for a hint with
 	 * non-hint IO.
 	 */
-	if (rq->write_hint != bio->bi_write_hint)
+	if (rq->bio->bi_write_hint != bio->bi_write_hint)
 		return false;
 
 	if (rq->ioprio != bio_prio(bio))
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2c43e12..f3000d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -530,12 +530,9 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
 				     struct request *req, u16 *control,
 				     u32 *dsmgmt)
 {
-	enum rw_hint streamid = req->write_hint;
+	enum rw_hint streamid = req->streamid;
 
-	if (streamid == WRITE_LIFE_NOT_SET || streamid == WRITE_LIFE_NONE)
-		streamid = 0;
-	else {
-		streamid--;
+	if (streamid != 0) {
 		if (WARN_ON_ONCE(streamid > ctrl->nr_streams))
 			return;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5b6cb9747..9cf8a40 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -216,7 +216,7 @@ struct request {
 	unsigned short nr_integrity_segments;
 #endif
 
-	unsigned short write_hint;
+	unsigned short streamid;
 	unsigned short ioprio;
 
 	unsigned int extra_len;	/* length of alignment and padding */
-- 
2.7.4
