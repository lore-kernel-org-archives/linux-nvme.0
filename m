From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Wed,  6 Jul 2016 18:03:33 -0300
Subject: [PATCH 3/3] powerpc: implement DMA_ATTR_NO_WARN
In-Reply-To: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <1467839013-22481-4-git-send-email-mauricfo@linux.vnet.ibm.com>

Add support for the DMA_ATTR_NO_WARN attribute on powerpc iommu code.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a8e3490..69bb17f 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -479,7 +479,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
-			if (printk_ratelimit())
+			if (unlikely(!dma_get_attr(DMA_ATTR_NO_WARN, attrs)) && printk_ratelimit())
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %lx npages %lu\n", tbl, vaddr,
 					 npages);
@@ -776,7 +776,7 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 mask >> tbl->it_page_shift, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
-			if (printk_ratelimit())  {
+			if (unlikely(!dma_get_attr(DMA_ATTR_NO_WARN, attrs)) && printk_ratelimit())  {
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %p npages %d\n", tbl, vaddr,
 					 npages);
-- 
1.8.3.1
