From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Dec 2017 11:20:14 -0700
Subject: [PATCH] nvme: Check hw sectors before setting chunk sectors
Message-ID: <20171214182014.4715-1-keith.busch@intel.com>

Some devices with IDs matching the "stripe" quirk don't actually have
this quirk, and don't have an MDTS value. When MDTS is not set, the
driver sets the max sectors to UINT_MAX, which is not a power of 2,
hitting a BUG_ON from blk_queue_chunk_sectors. This patch skips setting
chunk sectors for such devices.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f837d666cbd4..9831a592bbb9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1705,7 +1705,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
+	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE &&
+				is_power_of_2(ctrl->max_hw_sectors))
 		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
-- 
2.13.6
