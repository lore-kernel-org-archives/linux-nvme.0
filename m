From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Nov 2015 16:33:08 -0700
Subject: [PATCH] NVMe: Fix possible arithmetic overflow for max segments
Message-ID: <1447889588-11353-1-git-send-email-keith.busch@intel.com>

Reported-by: Paul Grabinar <paul.grabinar at ranbarg.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8187df2..394fd16 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2268,7 +2268,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	if (dev->max_hw_sectors) {
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
 		blk_queue_max_segments(ns->queue,
-			((dev->max_hw_sectors << 9) / dev->page_size) + 1);
+			(dev->max_hw_sectors / (dev->page_size >> 9)) + 1);
 	}
 	if (dev->stripe_size)
 		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
-- 
2.6.2.307.g37023ba
