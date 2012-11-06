From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Nov 2012 11:59:23 -0700
Subject: [PATCH] NVMe: Initialize iod nents to 0
Message-ID: <1352228363-4937-1-git-send-email-keith.busch@intel.com>

For commands that do not map a scatter list, we need to initilaize the iod's
number of sg entries (nents) to 0 and not unmap in this case.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..2544504 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -334,6 +334,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
 		iod->offset = offsetof(struct nvme_iod, sg[nseg]);
 		iod->npages = -1;
 		iod->length = nbytes;
+		iod->nents = 0;
 	}
 
 	return iod;
@@ -374,7 +375,8 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 	struct bio *bio = iod->private;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 
-	dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
+	if (iod->nents)
+		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	nvme_free_iod(dev, iod);
 	if (status) {
-- 
1.7.0.4
