From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 13:19:14 -0700
Subject: [PATCH 3/5 v2] powerpc/dma: implement per-platform dma_get_page_shift
In-Reply-To: <20151002201647.GH8040@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151002201647.GH8040@linux.vnet.ibm.com>
Message-ID: <20151002201914.GI8040@linux.vnet.ibm.com>

The IOMMU page size is not always stored in struct iommu on Power.
Specifically if a device is configured for DDW (Dynamic DMA Windows aka.
64-bit direct DMA), the used TCE (Translation Control Entry) size is
stored in a special device property created at run-time by the DDW
configuration code. DDW is a pseries-specific feature, so allow
platforms to override the implementation of dma_get_page_shift if
desired.

Signed-off-by: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index cab6753..5c372e3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -78,9 +78,10 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	/* Platform set_dma_mask and dma_get_required_mask overrides */
+	/* Platform overrides */
 	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
 	u64		(*dma_get_required_mask)(struct device *dev);
+	unsigned long	(*dma_get_page_shift)(struct device *dev);
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index e805af2..c363896 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -338,6 +338,8 @@ EXPORT_SYMBOL(dma_set_mask);
 unsigned long dma_get_page_shift(struct device *dev)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
+	if (ppc_md.dma_get_page_shift)
+		return ppc_md.dma_get_page_shift(dev);
 	if (tbl)
 		return tbl->it_page_shift;
 	return PAGE_SHIFT;
