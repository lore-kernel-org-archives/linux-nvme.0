From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:40 +0100
Subject: [PATCH 5/8] nvme: add segment limitations
In-Reply-To: <1446915643-21175-1-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
Message-ID: <1446915643-21175-6-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 11 +++++++++--
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6737aaf..14ee152 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -982,9 +982,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (ctrl->max_hw_sectors) {
 		blk_queue_max_hw_sectors(ns->queue, ctrl->max_hw_sectors);
-		blk_queue_max_segments(ns->queue,
-			((ctrl->max_hw_sectors << 9) / ctrl->page_size) + 1);
+
+		if (!ctrl->max_segments)
+			ctrl->max_segments = ((ctrl->max_hw_sectors << 9) /
+						ctrl->page_size) + 1;
 	}
+
+	if (ctrl->max_segments)
+		blk_queue_max_segments(ns->queue, ctrl->max_segments);
+	if (ctrl->max_segment_size)
+		blk_queue_max_segment_size(ns->queue, ctrl->max_segment_size);
 	if (ctrl->stripe_size)
 		blk_queue_chunk_sectors(ns->queue, ctrl->stripe_size >> 9);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8cf6fa5..8377a3f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -55,6 +55,8 @@ struct nvme_ctrl {
 	u32 ctrl_config;
 	u32 max_hw_sectors;
 	u32 stripe_size;
+	u32 max_segments;
+	u32 max_segment_size;
 	u32 page_size;
 	u16 oncs;
 	atomic_t abort_limit;
-- 
1.9.1
