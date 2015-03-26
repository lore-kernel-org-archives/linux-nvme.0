From: brking@linux.vnet.ibm.com (Brian King)
Date: Thu, 26 Mar 2015 11:07:51 -0500
Subject: [PATCH v2 1/1] nvme: Fix PRP list calculation for non-4k system page
 size
In-Reply-To: <alpine.LNX.2.00.1503242233530.32385@localhost.lm.intel.com>
References: <201503242226.t2OMQpWq011660@d03av02.boulder.ibm.com>
 <alpine.LNX.2.00.1503242233530.32385@localhost.lm.intel.com>
Message-ID: <55142ED7.8040809@linux.vnet.ibm.com>

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
+++ linux-nvme-bjking1/drivers/block/nvme-core.c	2015-03-25 09:25:43.580260410 -0500
@@ -503,12 +503,12 @@ int nvme_setup_prps(struct nvme_dev *dev
 	struct scatterlist *sg = iod->sg;
 	int dma_len = sg_dma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
-	int offset = offset_in_page(dma_addr);
+	u32 page_size = dev->page_size;
+	int offset = dma_addr & (page_size - 1);
 	__le64 *prp_list;
 	__le64 **list = iod_list(iod);
 	dma_addr_t prp_dma;
 	int nprps, i;
-	u32 page_size = dev->page_size;
 
 	length -= (page_size - offset);
 	if (length <= 0)
_
