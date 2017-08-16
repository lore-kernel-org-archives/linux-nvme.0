From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 16 Aug 2017 13:21:00 +0300
Subject: [PATCH 3/3] nvme-rdma: fix virtual boundary calculation
In-Reply-To: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
References: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
Message-ID: <1502878860-11750-3-git-send-email-maxg@mellanox.com>

Set the virtual boundary to correspond the mapping restrictions
of the HCA. This fixes the mismatch in systems with page size > 4KiB.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cf71895..8ab5a71 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1585,7 +1585,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
-	ctrl->ctrl.virt_boundary_mask = ctrl->ctrl.page_size - 1;
+	ctrl->ctrl.virt_boundary_mask = PAGE_SIZE - 1;
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-- 
1.7.1
