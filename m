From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 May 2017 15:42:26 -0600
Subject: [RFC PATCH 15/16] dma-mapping: introduce and use unmappable safe
 sg_virt call
In-Reply-To: <1495662147-18277-1-git-send-email-logang@deltatee.com>
References: <1495662147-18277-1-git-send-email-logang@deltatee.com>
Message-ID: <1495662147-18277-16-git-send-email-logang@deltatee.com>

Introduce sg_try_virt which is safe to call with a potentially
unmappable sgl. sg_try_virt returns NULL in cases that the sgl doesn't
have an accessible virtual address to return.

Then, in dma_map_sg_attrs, we use the new function instead of sg_virt
when marking memory as initialized.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 include/linux/dma-mapping.h |  9 +++++++--
 include/linux/scatterlist.h | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4f3eece..5ef1ab5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -241,8 +241,13 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	int i, ents;
 	struct scatterlist *s;
 
-	for_each_sg(sg, s, nents, i)
-		kmemcheck_mark_initialized(sg_virt(s), s->length);
+	for_each_sg(sg, s, nents, i) {
+		void *addr = sg_try_virt(sg);
+
+		if (addr)
+			kmemcheck_mark_initialized(addr, s->length);
+	}
+
 	BUG_ON(!valid_dma_direction(dir));
 	ents = ops->map_sg(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 2c54c6c..1e11af9 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -298,6 +298,22 @@ static inline void *sg_virt(struct scatterlist *sg)
 	return page_address(sg_page(sg)) + sg->offset;
 }
 
+/**
+ * sg_try_virt - Return virtual address of an sg entry or NULL if it is
+ *	unmappable
+ * @sg:      SG entry
+ *
+ * Description:
+ *   This is the same as sg_virt but is safe to call with unmappable
+ *   memory. This function will return NULL in case the sg is is
+ *   unmappable.
+ *
+ **/
+static inline void *sg_try_virt(struct scatterlist *sg)
+{
+	return pfn_t_to_virt(sg->__pfn);
+}
+
 int sg_nents(struct scatterlist *sg);
 int sg_nents_for_len(struct scatterlist *sg, u64 len);
 struct scatterlist *sg_next(struct scatterlist *);
-- 
2.1.4
