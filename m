From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 12 Apr 2017 01:01:48 +0300
Subject: [PATCH 1/2] nvme: enable SG gaps support
Message-ID: <1491948109-9224-1-git-send-email-maxg@mellanox.com>

For controllers that can handle arbitrarily sized bios (e.g advanced
RDMA ctrls) we can allow the block layer to pass us gaps by skip
setting the queue virt_boundary.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c |    5 ++++-
 drivers/nvme/host/nvme.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b3b57f..218a3c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1252,7 +1252,10 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	}
 	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
 		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
-	blk_queue_virt_boundary(q, ctrl->page_size - 1);
+
+	if (!ctrl->sg_gaps_support)
+		blk_queue_virt_boundary(q, ctrl->page_size - 1);
+
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
 	blk_queue_write_cache(q, vwc, vwc);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2aa20e3..ccb895a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -162,6 +162,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	bool sg_gaps_support;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
-- 
1.7.1
