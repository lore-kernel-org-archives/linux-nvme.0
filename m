From: alan.adamson@oracle.com (Alan Adamson)
Date: Fri, 16 Jun 2017 13:34:50 -0700
Subject: [PATCH] nvme: set DMA_ATTR_WEAK_ORDERING attribute on dma buffers
Message-ID: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>

SPARC based platforms suffer significant read performance penalties for
nvme reads when Relaxed Ordering is not enabled. This change sets the
DMA_ATTR_WEAK_ORDERING (Relaxed Ordering) attribute for nvme block dma
buffers.

Both the AIC and SSD versions of the Samsung 2.9TB device were tested
with fio using iodepth=32, numjobs=8, and bs=4k.

For reads, a 450% increase in IOPS was observed.
For writes, no change in IOPS was observed.

Signed-off-by: Alan Adamson <alan.adamson at oracle.com>
Tested-by: Alan Adamson <alan.adamson at oracle.com>
Reviewed-by: Kyle Fortin <kyle.fortin at oracle.com>
Reviewed-by: Govinda Tatti <govinda.tatti at oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson at oracle.com>

---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 951042a375d6..7a6cf6fa95c2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -632,7 +632,7 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 
 	ret = BLK_MQ_RQ_QUEUE_BUSY;
 	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
-				DMA_ATTR_NO_WARN))
+				DMA_ATTR_NO_WARN | DMA_ATTR_WEAK_ORDERING))
 		goto out;
 
 	if (!nvme_setup_prps(dev, req))
@@ -650,7 +650,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 		if (rq_data_dir(req))
 			nvme_dif_remap(req, nvme_dif_prep);
 
-		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
+		if (!dma_map_sg_attrs(dev->dev, &iod->meta_sg, 1, dma_dir,
+				DMA_ATTR_WEAK_ORDERING))
 			goto out_unmap;
 	}
 
-- 
1.8.3.1
