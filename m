From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Tue, 17 Nov 2015 20:51:50 +0000
Subject: Drives with MDTS set to zero
Message-ID: <564B9366.1090904@ranbarg.com>

Hi,

I have a drive that sets MDTS to zero. According to the NVMe
specification, that is valid and means that the drive does not have a
limit on the transfer size.

In the current 4.4 kernel driver, we detect this and set
dev->max_hw_sectors to UINT_MAX.

Later, when a namespace is allocated, we set the block level
max_hw_sectors and max_segments based on dev->max_hw_sectors. This
operations perform shifts on the value, but we are already at UINT_MAX,
so end up with strange results.

I'm not entirely sure what is supposed to happen. The following patch
sets max_hw_sectors to

BLK_DEF_MAX_SECTORS and max_segments to BLK_MAX_SEGMENTS, but this still does not seem right, as drives with a large MDTS will set max_segments higher than this.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8187df2..be35401 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2265,11 +2265,12 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	list_add_tail(&ns->list, &dev->namespaces);
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
-	if (dev->max_hw_sectors) {
-		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
-		blk_queue_max_segments(ns->queue,
-			((dev->max_hw_sectors << 9) / dev->page_size) + 1);
-	}
+	blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors ?
+		dev->max_hw_sectors : BLK_DEF_MAX_SECTORS);
+	blk_queue_max_segments(ns->queue,
+		dev->max_hw_sectors ?
+		((dev->max_hw_sectors << 9) / dev->page_size) + 1 :
+		BLK_MAX_SEGMENTS);
 	if (dev->stripe_size)
 		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
 	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
@@ -2622,8 +2623,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
-	else
-		dev->max_hw_sectors = UINT_MAX;
 	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
 			(pdev->device == 0x0953) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
