From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Mon,  1 Aug 2016 19:59:49 -0300
Subject: [PATCH 2/3] powerpc: implement the DMA_ATTR_NO_WARN attribute
In-Reply-To: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <1470092390-25451-3-git-send-email-mauricfo@linux.vnet.ibm.com>

Add support for the DMA_ATTR_NO_WARN attribute on powerpc iommu code.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 37d6e74..5f202a5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -479,7 +479,8 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
-			if (printk_ratelimit())
+			if (!(attrs & DMA_ATTR_NO_WARN) &&
+			    printk_ratelimit())
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %lx npages %lu\n", tbl, vaddr,
 					 npages);
@@ -776,7 +777,8 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 mask >> tbl->it_page_shift, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
-			if (printk_ratelimit())  {
+			if (!(attrs & DMA_ATTR_NO_WARN) &&
+			    printk_ratelimit())  {
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %p npages %d\n", tbl, vaddr,
 					 npages);
-- 
1.8.3.1
