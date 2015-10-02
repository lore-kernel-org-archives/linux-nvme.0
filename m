From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 10:18:00 -0700
Subject: [PATCH 1/2] powerpc/iommu: expose IOMMU page shift
In-Reply-To: <20151002171606.GA41011@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
Message-ID: <20151002171800.GB41011@linux.vnet.ibm.com>

We will leverage this macro in the NVMe driver, which needs to know the
configured IOMMU page shift to properly configure its device's page
size.

Signed-off-by: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>

---
Given this is available, it seems reasonable to expose -- and it doesn't
really make sense to make the driver do a log2 call on the existing
IOMMU_PAGE_SIZE() value.

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index ca18cff..6fdf857 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -36,6 +36,7 @@
 #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
 #define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
 
+#define IOMMU_PAGE_SHIFT(tblptr) (tblptr)->it_page_shift
 #define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)
 #define IOMMU_PAGE_MASK(tblptr) (~((1 << (tblptr)->it_page_shift) - 1))
 #define IOMMU_PAGE_ALIGN(addr, tblptr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE(tblptr))
