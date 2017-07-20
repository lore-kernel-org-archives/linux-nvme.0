From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Wed, 19 Jul 2017 17:24:19 -0700
Subject: [PATCH v2 1/2] nvme: add virt boundary per ctrl
In-Reply-To: <20170720002420.26408-1-chaitanya.kulkarni@hgst.com>
References: <20170720002420.26408-1-chaitanya.kulkarni@hgst.com>
Message-ID: <20170720002420.26408-2-chaitanya.kulkarni@hgst.com>

This patch is reimplementation of the original patch provided by
Max Gurtovoy <maxg at mellanox.com> :-
https://www.spinics.net/lists/linux-rdma/msg48610.html

For controllers that can handle arbitrarily sized bios (e.g advanced
RDMA and PCI ctrls) we can allow the block layer to pass us gaps by
setting the queue virt_boundary_mask according to each ctrl constraints.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 drivers/nvme/host/core.c   | 2 +-
 drivers/nvme/host/fc.c     | 1 +
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 1 +
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb96f4a..10127a2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1503,7 +1503,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	}
 	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
 		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
-	blk_queue_virt_boundary(q, ctrl->page_size - 1);
+	blk_queue_virt_boundary(q, ctrl->virt_boundary_mask);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
 	blk_queue_write_cache(q, vwc, vwc);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d666ada..f14bd15 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2351,6 +2351,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	segs = min_t(u32, NVME_FC_MAX_SEGMENTS,
 			ctrl->lport->ops->max_sgl_segments);
 	ctrl->ctrl.max_hw_sectors = (segs - 1) << (PAGE_SHIFT - 9);
+	ctrl->ctrl.virt_boundary_mask = ctrl->ctrl.page_size - 1;
 
 	ret = nvme_init_identify(&ctrl->ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8f2a168..803c211 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -167,6 +167,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	unsigned long virt_boundary_mask;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d10d2f2..be0d8f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2127,6 +2127,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	dev->ctrl.virt_boundary_mask = dev->ctrl.page_size - 1;
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
 		goto out;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index da04df1..04a0d33 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1584,6 +1584,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
+	ctrl->ctrl.virt_boundary_mask = ctrl->ctrl.page_size - 1;
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 717ed7d..b0a831d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -402,6 +402,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	ctrl->ctrl.max_hw_sectors =
 		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
+	ctrl->ctrl.virt_boundary_mask = ctrl->ctrl.page_size - 1;
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-- 
2.7.4
