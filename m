From: mundu2510@gmail.com (Mundu)
Date: Mon, 17 Mar 2014 22:30:45 +0530
Subject: [PATCH] NVMe: core: Fix bug on maximum hardware sectors support by
 driver
Message-ID: <1395075645-19774-1-git-send-email-mundu2510@gmail.com>

NVMe spec defines maximum data transfer size as 0 in case no size restriction.
Fixed exception - divide by zero in function nvme_trans_io_get_num_cmds.
Change to maximum hardware sector supports as Block safe max sectors,
when mdts set as zero.

Signed-off-by: Mundu <mundu2510 at gmail.com>
---
 drivers/block/nvme-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd39390..c8c0ccc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1847,6 +1847,8 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
+	else
+		dev->max_hw_sectors = ns->queue->limits.max_hw_sectors;
 
 	disk->major = nvme_major;
 	disk->first_minor = 0;
-- 
1.8.3.2
