From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 10:23:13 -0700
Subject: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
In-Reply-To: <20151002171800.GB41011@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
Message-ID: <20151002172313.GC41011@linux.vnet.ibm.com>

We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).

The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).

In this particular case, and generally, we want to use the IOMMU's page
size for the default device page size, rather than the kernel's page
size.

With this patch, a NVMe device survives our internal hardware
exerciser; the kernel BUGs within a few seconds without the patch.

Signed-off-by: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..969a95e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -42,6 +42,7 @@
 #include <linux/types.h>
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <asm/iommu.h>
 
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
@@ -1680,6 +1681,11 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	unsigned page_shift = PAGE_SHIFT;
 	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
 	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
+#ifdef CONFIG_PPC64
+	struct iommu_table *tbl = get_iommu_table_base(dev->dev);
+	if (tbl)
+		page_shift = IOMMU_PAGE_SHIFT(tbl);
+#endif
 
 	if (page_shift < dev_page_min) {
 		dev_err(dev->dev,
