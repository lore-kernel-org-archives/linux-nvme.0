From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue,  6 Jun 2017 16:36:09 +0200
Subject: [PATCH v5 1/9] scatterlist: add sg_zeroout_area() helper
In-Reply-To: <20170606143617.32143-1-jthumshirn@suse.de>
References: <20170606143617.32143-1-jthumshirn@suse.de>
Message-ID: <20170606143617.32143-2-jthumshirn@suse.de>

The sg_zeroout_area() helper is used to zero fill an area in a SG
list.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 include/linux/scatterlist.h |  3 +++
 lib/scatterlist.c           | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index cb3c8fe6acd7..a38ce9f4e78a 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -279,6 +279,9 @@ size_t sg_pcopy_from_buffer(struct scatterlist *sgl, unsigned int nents,
 size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 			  void *buf, size_t buflen, off_t skip);
 
+size_t sg_zeroout_area(struct scatterlist *sgl, unsigned int nents,
+		       size_t buflen, off_t skip);
+
 /*
  * Maximum number of entries that will be allocated in one piece, if
  * a list larger than this is required then chaining will be utilized.
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index c6cf82242d65..ce311cde2654 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -751,3 +751,40 @@ size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 	return sg_copy_buffer(sgl, nents, buf, buflen, skip, true);
 }
 EXPORT_SYMBOL(sg_pcopy_to_buffer);
+
+/**
+ * sg_zeroout_area - Zero-out a part of a SG list
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries
+ * @buflen:		 The number of bytes to zero out
+ * @skip:		 Number of bytes to skip before zeroing
+ *
+ * Returns the number of bytes zeroed.
+ *
+ **/
+size_t sg_zeroout_area(struct scatterlist *sgl, unsigned int nents,
+		       size_t buflen, off_t skip)
+{
+	unsigned int offset = 0;
+	struct sg_mapping_iter miter;
+	unsigned int sg_flags = SG_MITER_ATOMIC | SG_MITER_TO_SG;
+
+	sg_miter_start(&miter, sgl, nents, sg_flags);
+
+	if (!sg_miter_skip(&miter, skip))
+		return false;
+
+	while ((offset < buflen) && sg_miter_next(&miter)) {
+		unsigned int len;
+
+		len = min(miter.length, buflen - offset);
+		memset(miter.addr, '\0', len);
+
+		offset += len;
+	}
+
+	sg_miter_stop(&miter);
+
+	return offset;
+}
+EXPORT_SYMBOL(sg_zeroout_area);
-- 
2.12.3
