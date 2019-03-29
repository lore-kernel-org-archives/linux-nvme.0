From: joshi.k@samsung.com (Kanchan Joshi)
Date: Fri, 29 Mar 2019 13:23:47 +0530
Subject: [PATCH v3 2/7] block: introduce API to register stream information
 with block layer
In-Reply-To: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075746epcas1p19e5a93c1f593b5fed3f98eddf9159aa5@epcas1p1.samsung.com>
Message-ID: <1553846032-4451-3-git-send-email-joshi.k@samsung.com>

This associates stream limit (count of streams exposed by driver) with
request queue.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 block/blk-settings.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 3e7038e..bb0da61 100644
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
-- 
2.7.4
