From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Dec 2016 19:10:55 -0500
Subject: [PATCH] nvme: simplify stripe quirk
Message-ID: <1481760655-25877-1-git-send-email-keith.busch@intel.com>

Some subsystem vendors believe they own the Identify Controller vendor
specific region, and will repurpose it with their own values. Since we
can't rely on the VS byte to tell us what the stripe size is, we need to
do something for the quirk whitelist until this feature is standardized.

The field was originally concepted to allow back end flexibility on
its striping, but it turned out that never materialized; the chunk is
always the same as MDTS in the products subscribing to this quirk, and
it always will be that way. So, this patch removes the stripe_size field,
and sets the chunk to the max hw transfer size for quirked devices.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
For blk-mq, this addresses some performance anomolies. The more serious
problem, though, is for the pre-blk-mq driver, and I'll need to port
to stable. In some cases, the circular shifting can get a stripe size
that's smaller than a block, and that causes memory corruption.

 drivers/nvme/host/core.c | 17 ++---------------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b40cfb0..2fc86dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1193,8 +1193,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	if (ctrl->stripe_size)
-		blk_queue_chunk_sectors(q, ctrl->stripe_size >> 9);
+	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
+		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
@@ -1250,19 +1250,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
-	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) && id->vs[3]) {
-		unsigned int max_hw_sectors;
-
-		ctrl->stripe_size = 1 << (id->vs[3] + page_shift);
-		max_hw_sectors = ctrl->stripe_size >> (page_shift - 9);
-		if (ctrl->max_hw_sectors) {
-			ctrl->max_hw_sectors = min(max_hw_sectors,
-							ctrl->max_hw_sectors);
-		} else {
-			ctrl->max_hw_sectors = max_hw_sectors;
-		}
-	}
-
 	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bd53214..6377e14 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -135,7 +135,6 @@ struct nvme_ctrl {
 
 	u32 page_size;
 	u32 max_hw_sectors;
-	u32 stripe_size;
 	u16 oncs;
 	u16 vid;
 	atomic_t abort_limit;
-- 
2.5.5
