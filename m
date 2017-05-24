From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 May 2017 15:42:20 -0600
Subject: [RFC PATCH 09/16] bvec: introduce bvec_page and bvec_set_page
 accessors
In-Reply-To: <1495662147-18277-1-git-send-email-logang@deltatee.com>
References: <1495662147-18277-1-git-send-email-logang@deltatee.com>
Message-ID: <1495662147-18277-10-git-send-email-logang@deltatee.com>

Introduce two accessor functions for bv_page: bvec_page to return the
page and bvec_set_page. A follow on patch will mechanically convert all the
individual uses within the kernel.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 include/linux/bvec.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 89b65b8..b5369a0 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,6 +43,16 @@ struct bvec_iter {
 						   current bvec */
 };
 
+static inline struct page *bvec_page(const struct bio_vec *bvec)
+{
+	return bvec->bv_page;
+}
+
+static inline void bvec_set_page(struct bio_vec *bvec, struct page *page)
+{
+	bvec->bv_page = page;
+}
+
 /*
  * various member access, note that bio_data should of course not be used
  * on highmem page vectors
-- 
2.1.4
