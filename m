From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Feb 2014 13:29:11 -0700
Subject: [PATCH 1/2] NVMe: Configure flush capabilities
Message-ID: <1392755352-19445-1-git-send-email-keith.busch@intel.com>

This patch configures the nvme request_queue as flush capable. All NVMe
devices must support the flush command, whether they have a volatile
write cache or not.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd39390..f8d6a9e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1844,6 +1844,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
-- 
1.7.10.4
