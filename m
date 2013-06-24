From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Jun 2013 16:34:27 -0600
Subject: [PATCH] NVMe: Disk stats for read/write commands only
Message-ID: <1372113267-31420-1-git-send-email-keith.busch@intel.com>

Flush and discard requests would previously mess up the accounting.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 07d527c..711b51c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -345,7 +345,8 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-	nvme_end_io_acct(bio, iod->start_time);
+	if (bio_rw(bio))
+		nvme_end_io_acct(bio, iod->start_time);
 	nvme_free_iod(dev, iod);
 	if (status)
 		bio_endio(bio, -EIO);
-- 
1.7.0.4
