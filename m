From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Sep 2017 15:06:14 -0400
Subject: [PATCH] nvme/pci: Print invalid SGL only once
Message-ID: <1505415974-13489-1-git-send-email-keith.busch@intel.com>

The WARN_ONCE macro returns true if the condition is true, not if the
warn was raised, so we're printing the scatter list every time it's
invalid. This is excessive and makes debugging harder, so this patch
prints it just once.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df96562..33d66da 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -554,6 +554,8 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	dma_addr_t prp_dma;
 	int nprps, i;
 
+	static bool sgl_warned = false;
+
 	length -= (page_size - offset);
 	if (length <= 0)
 		return BLK_STS_OK;
@@ -619,8 +621,9 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	return BLK_STS_OK;
 
  bad_sgl:
-	if (WARN_ONCE(1, "Invalid SGL for payload:%d nents:%d\n",
+	if (!sgl_warned && WARN_ONCE(1, "Invalid SGL for payload:%d nents:%d\n",
 				blk_rq_payload_bytes(req), iod->nents)) {
+		sgl_warned = true;
 		for_each_sg(iod->sg, sg, iod->nents, i) {
 			dma_addr_t phys = sg_phys(sg);
 			pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
-- 
2.5.5
