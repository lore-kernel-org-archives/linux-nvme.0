From: hch@lst.de (Christoph Hellwig)
Date: Wed,  5 Jun 2019 21:08:26 +0200
Subject: [PATCH 03/13] mtip32xx: also set max_segment_size in the device
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
Message-ID: <20190605190836.32354-4-hch@lst.de>

If we only set the max_segment_size on the queue an IOMMU merge might
create bigger segments again, so limit the IOMMU merges as well.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index bacfdac7161c..a14b09ab3a41 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3676,6 +3676,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	blk_queue_physical_block_size(dd->queue, 4096);
 	blk_queue_max_hw_sectors(dd->queue, 0xffff);
 	blk_queue_max_segment_size(dd->queue, 0x400000);
+	dma_set_max_seg_size(&dd->pdev->dev, 0x400000);
 	blk_queue_io_min(dd->queue, 4096);
 
 	/* Set the capacity of the device in 512 byte sectors. */
-- 
2.20.1
