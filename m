From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 17:46:02 -0400
Subject: [PATCHv2 2/4] nvme/pci: Use req_op to determine DIF remapping
In-Reply-To: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
Message-ID: <1504043164-5398-3-git-send-email-keith.busch@intel.com>

Only read and write commands need DIF remapping. Everything else uses
a passthrough integrity payload.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 925467b..75c0007 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -666,7 +666,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
 			goto out_unmap;
 
-		if (rq_data_dir(req))
+		if (req_op(req) == REQ_OP_WRITE)
 			nvme_dif_remap(req, nvme_dif_prep);
 
 		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
@@ -694,7 +694,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	if (iod->nents) {
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 		if (blk_integrity_rq(req)) {
-			if (!rq_data_dir(req))
+			if (req_op(req) == REQ_OP_READ)
 				nvme_dif_remap(req, nvme_dif_complete);
 			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
 		}
-- 
2.5.5
