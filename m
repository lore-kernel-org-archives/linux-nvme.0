From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Jan 2017 12:29:10 +0100
Subject: [PATCH 1/4] block: add blk_rq_payload_bytes
In-Reply-To: <1484306953-3194-1-git-send-email-hch@lst.de>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
Message-ID: <1484306953-3194-2-git-send-email-hch@lst.de>

Add a helper to calculate the actual data transfer size for special
payload requests.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/blkdev.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ff3d774..1ca8e8f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1000,6 +1000,19 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
 	return blk_rq_cur_bytes(rq) >> 9;
 }
 
+/*
+ * Some commands like WRITE SAME have a payload or data transfer size which
+ * is different from the size of the request.  Any driver that supports such
+ * commands using the RQF_SPECIAL_PAYLOAD flag needs to use this helper to
+ * calculate the data transfer size.
+ */
+static inline unsigned int blk_rq_payload_bytes(struct request *rq)
+{
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return rq->special_vec.bv_len;
+	return blk_rq_bytes(rq);
+}
+
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     int op)
 {
-- 
2.1.4
