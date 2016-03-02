From: hch@lst.de (Christoph Hellwig)
Date: Wed,  2 Mar 2016 18:07:12 +0100
Subject: [PATCH 3/5] nvme: fix max_segments integer truncation
In-Reply-To: <1456938434-20387-1-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
Message-ID: <1456938434-20387-4-git-send-email-hch@lst.de>

The block layer uses an unsigned short for max_segments.  The way we
calculate the value for NVMe tends to generate very large 32-bit values,
which after integer truncation may lead to a zero value instead of
the desired outcome.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
Tested-by: Jeff Lien <Jeff.Lien at hgst.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cfee6ac..c30cb10 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -844,9 +844,11 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
 	if (ctrl->max_hw_sectors) {
+		u32 max_segments = 
+			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
+
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-		blk_queue_max_segments(q,
-			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1);
+		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
 	if (ctrl->stripe_size)
 		blk_queue_chunk_sectors(q, ctrl->stripe_size >> 9);
-- 
2.1.4
