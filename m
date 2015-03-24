From: brking@linux.vnet.ibm.com (Brian King)
Date: Tue, 24 Mar 2015 17:26:50 -0500
Subject: [PATCH 1/1] nvme: Fix PRP list calculation for non-4k system page size
Message-ID: <201503242226.t2OMQpWq011660@d03av02.boulder.ibm.com>


From: Murali Iyer <mniyer@us.ibm.com>

PRP list calculation is supposed to be based on device's page size.
Systems with page size larger than device's page size cause corruption
to the name space as well as system memory with out this fix.
Systems like x86 might not experience this issue because it uses
PAGE_SIZE of 4K where as powerpc uses PAGE_SIZE of 64k while NVMe device's
page size varies depending upon the vendor.

Signed-off-by: Murali Iyer <mniyer at us.ibm.com>
Signed-off-by: Brian King <brking at linux.vnet.ibm.com>
---

 drivers/block/nvme-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/block/nvme-core.c~nvme_power drivers/block/nvme-core.c
--- linux-nvme/drivers/block/nvme-core.c~nvme_power	2015-03-24 17:12:09.912743224 -0500
+++ linux-nvme-bjking1/drivers/block/nvme-core.c	2015-03-24 17:16:13.414970447 -0500
@@ -503,12 +503,12 @@ int nvme_setup_prps(struct nvme_dev *dev
 	struct scatterlist *sg = iod->sg;
 	int dma_len = sg_dma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
-	int offset = offset_in_page(dma_addr);
+	u32 page_size = dev->page_size;
+	int offset = dma_addr % page_size;
 	__le64 *prp_list;
 	__le64 **list = iod_list(iod);
 	dma_addr_t prp_dma;
 	int nprps, i;
-	u32 page_size = dev->page_size;
 
 	length -= (page_size - offset);
 	if (length <= 0)
_
