From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Aug 2015 16:17:54 -0600
Subject: [PATCH] NVMe: Set queue max segments
Message-ID: <1439417874-8925-1-git-send-email-keith.busch@intel.com>

This sets the queue's max segment size to match the device's
capabilities. The default of 128 is usable until a device's transfer
capability exceeds 512k, assuming a device page size of 4k. Many nvme
devices exceed that transfer limit, so this lets the block layer know what
kind of commands it to allow to form rather than unnecessarily split them.

One additional segment is added to account for a transfer that may start
in the middle of a page.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 613c1bc..abe93a5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2098,8 +2098,11 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	list_add_tail(&ns->list, &dev->namespaces);
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
-	if (dev->max_hw_sectors)
+	if (dev->max_hw_sectors) {
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
+		blk_queue_max_segments(ns->queue,
+			((dev->max_hw_sectors << 9) / dev->page_size) + 1);
+	}
 	if (dev->stripe_size)
 		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
 	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
-- 
1.7.10.4
