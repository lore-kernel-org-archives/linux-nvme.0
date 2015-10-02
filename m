From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 13:11:42 -0700
Subject: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
In-Reply-To: <20151002200953.GB40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
Message-ID: <20151002201142.GC40695@linux.vnet.ibm.com>

Drivers like NVMe need to be able to determine the page size used for
DMA transfers. Add a new API that defaults to return PAGE_SHIFT on all
architectures.

Signed-off-by: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index b1bc954..86e4e97 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -355,4 +355,11 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 }
 #endif
 
+#ifndef HAVE_ARCH_DMA_GET_PAGE_SHIFT
+static inline unsigned long dma_get_page_shift(struct device *dev)
+{
+	return PAGE_SHIFT;
+}
+#endif
+
 #endif
