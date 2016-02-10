From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 11:17:21 -0700
Subject: [PATCH for-4.5 04/13] NVMe: Set queue limits max_dev_sectors
In-Reply-To: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455128250-5984-5-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3cd921e..852b789 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1136,6 +1136,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (ctrl->max_hw_sectors) {
+		ns->queue->limits.max_dev_sectors = ctrl->max_hw_sectors;
 		blk_queue_max_hw_sectors(ns->queue, ctrl->max_hw_sectors);
 		blk_queue_max_segments(ns->queue,
 			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1);
-- 
2.6.2.307.g37023ba
