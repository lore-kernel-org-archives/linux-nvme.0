From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:24 -0700
Subject: [PATCH 02/15] block: add a rq_integrity_vec helper
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-3-hch@lst.de>

This provides a nice little shortcut to get the integrity data for
drivers like NVMe that only support a single integrity segment.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/blkdev.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 255e20313cde..f9a072610d28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1552,6 +1552,16 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
 }
 
+/*
+ * Return the first bvec that contains integrity data.  In general only
+ * drivers that are limited to a single integrity segment should use this
+ * helper.
+ */
+static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+{
+	return rq->bio->bi_integrity->bip_vec;
+}
+
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
 struct bio;
@@ -1626,6 +1636,11 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 	return 0;
 }
 
+static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 struct block_device_operations {
-- 
2.20.1
