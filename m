From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Nov 2015 22:58:20 +0000
Subject: Drives with MDTS set to zero
In-Reply-To: <564B9366.1090904@ranbarg.com>
References: <564B9366.1090904@ranbarg.com>
Message-ID: <20151118225820.GB24252@localhost.localdomain>

On Tue, Nov 17, 2015@08:51:50PM +0000, Paul Grabinar wrote:
> I have a drive that sets MDTS to zero. According to the NVMe
> specification, that is valid and means that the drive does not have a
> limit on the transfer size.
> 
> In the current 4.4 kernel driver, we detect this and set
> dev->max_hw_sectors to UINT_MAX.
> 
> Later, when a namespace is allocated, we set the block level
> max_hw_sectors and max_segments based on dev->max_hw_sectors. This
> operations perform shifts on the value, but we are already at UINT_MAX,
> so end up with strange results.
> 
> I'm not entirely sure what is supposed to happen. The following patch
> sets max_hw_sectors to
> 
> BLK_DEF_MAX_SECTORS and max_segments to BLK_MAX_SEGMENTS, but this still does not seem right, as drives with a large MDTS will set max_segments higher than this.

Nice find. The original code was written before the segment count, so
probably was not tested together (my controllers define MDTS, so I've
never tested it at all).

We can fix this by reordering the math instead of artificially reducing
the transfer size.
---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5aca81c..f17e3d3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2266,7 +2266,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	if (dev->max_hw_sectors) {
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
 		blk_queue_max_segments(ns->queue,
-			((dev->max_hw_sectors << 9) / dev->page_size) + 1);
+			((dev->max_hw_sectors / (dev->page_size >> 9) + 1);
 	}
 	if (dev->stripe_size)
 		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
--
