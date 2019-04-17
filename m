From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 17 Apr 2019 23:20:02 +0530
Subject: [PATCH v4 3/7] block: introduce API to register stream information
 with block-layer
In-Reply-To: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
References: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
 <CGME20190417175355epcas2p182a8626924a911310f7584d564d0a1ec@epcas2p1.samsung.com>
Message-ID: <1555523406-2380-4-git-send-email-joshi.k@samsung.com>

This introduces stream limit (count of streams supported by underlying
driver) in request-queue.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 block/blk-settings.c   | 12 ++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6375afa..6023229 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -231,6 +231,18 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
 /**
+ * blk_queue_stream_limits - set stream parameters
+ * @q:  the request queue for the device
+ * @nr_streams: number of streams supported by device
+ **/
+void blk_queue_stream_limits(struct request_queue *q,
+		unsigned short nr_streams)
+{
+	q->limits.nr_streams = nr_streams;
+}
+EXPORT_SYMBOL(blk_queue_stream_limits);
+
+/**
  * blk_queue_max_write_same_sectors - set max sectors for a single write same
  * @q:  the request queue for the device
  * @max_write_same_sectors: maximum number of sectors to write per command
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f200aed..eb6eb60 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -340,6 +340,7 @@ struct queue_limits {
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
 	enum blk_zoned_model	zoned;
+	unsigned short		nr_streams;
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -1065,6 +1066,7 @@ extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
+extern void blk_queue_stream_limits(struct request_queue *q, unsigned short);
 
 /*
  * Number of physical segments as sent to the device.
-- 
2.7.4
