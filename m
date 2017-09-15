From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Sep 2017 13:05:38 -0400
Subject: [PATCHv2] nvme/pci: Print invalid SGL only once
Message-ID: <1505495138-11325-1-git-send-email-keith.busch@intel.com>

The WARN_ONCE macro returns true if the condition is true, not if the
warn was raised, so we're printing the scatter list every time it's
invalid. This is excessive and makes debugging harder, so this patch
prints it just once.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

  Use the kernel's DO_ONCE macro rather than try to track that in the driver.

 drivers/nvme/host/pci.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df96562..ea4485a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/once.h>
 #include <linux/pci.h>
 #include <linux/poison.h>
 #include <linux/t10-pi.h>
@@ -539,6 +540,20 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
+static void nvme_print_sgl(struct scatterlist *sgl, int nents)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sgl, sg, nents, i) {
+		dma_addr_t phys = sg_phys(sg);
+		pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
+			"dma_address:%pad dma_length:%d\n",
+			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
+			sg_dma_len(sg));
+	}
+}
+
 static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -619,19 +634,10 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	return BLK_STS_OK;
 
  bad_sgl:
-	if (WARN_ONCE(1, "Invalid SGL for payload:%d nents:%d\n",
-				blk_rq_payload_bytes(req), iod->nents)) {
-		for_each_sg(iod->sg, sg, iod->nents, i) {
-			dma_addr_t phys = sg_phys(sg);
-			pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
-			       "dma_address:%pad dma_length:%d\n", i, &phys,
-					sg->offset, sg->length,
-					&sg_dma_address(sg),
-					sg_dma_len(sg));
-		}
-	}
+	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
+			"Invalid SGL for payload:%d nents:%d\n",
+			blk_rq_payload_bytes(req), iod->nents);
 	return BLK_STS_IOERR;
-
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
-- 
2.5.5
