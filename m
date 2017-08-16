From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 16 Aug 2017 13:20:59 +0300
Subject: [PATCH 2/3] nvme: introduce max_segments controller attribute
In-Reply-To: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
References: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
Message-ID: <1502878860-11750-2-git-send-email-maxg@mellanox.com>

Each ctrl will limit max_segments according to it's hardware
restrictions. Implement the restriction for RDMA transport.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c |    4 ++--
 drivers/nvme/host/nvme.h |    1 +
 drivers/nvme/host/rdma.c |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8cf37e7..cc0681e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1495,8 +1495,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	bool vwc = false;
 
 	if (ctrl->max_hw_sectors) {
-		u32 max_segments =
-			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
+		u32 max_segments = min_not_zero(ctrl->max_segments,
+			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1);
 
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 803c211..0d6a91a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -147,6 +147,7 @@ struct nvme_ctrl {
 	u64 cap;
 	u32 page_size;
 	u32 max_hw_sectors;
+	u32 max_segments;
 	u16 oncs;
 	u16 vid;
 	u16 oacs;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 04a0d33..cf71895 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1582,6 +1582,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	if (error)
 		goto out_cleanup_queue;
 
+	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
 	ctrl->ctrl.virt_boundary_mask = ctrl->ctrl.page_size - 1;
-- 
1.7.1
