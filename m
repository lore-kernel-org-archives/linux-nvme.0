From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 23 Oct 2015 14:01:15 -0700
Subject: [RFC PATCH 6/7] sparc/dma-mapping: override dma_get_page_shift
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
Message-ID: <20151023210115.GH10197@linux.vnet.ibm.com>

On sparc, the kernel's page size differs from the IOMMU's page size, so
override the generic implementation, which always returns the kernel's
page size, and return IOMMU_PAGE_SHIFT instead.

Signed-off-by: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>

---
I know very little about sparc, so please correct me if this patch is
invalid.

 arch/sparc/include/asm/dma-mapping.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index a21da59..76ba470 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -52,6 +52,14 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 	return -EINVAL;
 }
 
+/* for IOMMU_PAGE_SHIFT */
+#include <asm/iommu_common.h>
+#define HAVE_ARCH_DMA_GET_PAGE_SHIFT 1
+static inline unsigned long dma_get_page_shift(struct device *dev)
+{
+	return IOMMU_PAGE_SHIFT;
+}
+
 #include <asm-generic/dma-mapping-common.h>
 
 #endif
-- 
1.9.1
