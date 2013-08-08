From: keith.busch@intel.com (Keith Busch)
Date: Thu,  8 Aug 2013 10:25:37 -0600
Subject: [PATCH 1/2] Revert "NVMe: Disk stats for read/write commands only"
Message-ID: <1375979138-17472-1-git-send-email-keith.busch@intel.com>

This reverts commit 3111a003a2f3c7459885b46953e36edeab4d2dff.
---
I testing with writes... I screwed up.

 drivers/block/nvme-core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7de80bb..56d1fa4 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -346,8 +346,7 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-	if (bio_rw(bio))
-		nvme_end_io_acct(bio, iod->start_time);
+	nvme_end_io_acct(bio, iod->start_time);
 	nvme_free_iod(dev, iod);
 	if (status)
 		bio_endio(bio, -EIO);
-- 
1.7.10.4
