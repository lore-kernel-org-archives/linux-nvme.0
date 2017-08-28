From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 28 Aug 2017 12:52:27 +0300
Subject: [PATCH 1/1] nvme-rdma: default MR page size to 4k
Message-ID: <1503913947-28915-1-git-send-email-maxg@mellanox.com>

Due to various page sizes in the system (IOMMU/device/kernel), we
set the fabrics controller page size to 4k and block layer boundaries
accordinglly. In architectures that uses different kernel page size
we'll have a mismatch to the MR page size that may cause a mapping error.
Update the MR page size to correspond to the core ctrl settings.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index da04df1..a03299d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -920,7 +920,11 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 	int nr;
 
-	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, PAGE_SIZE);
+	/*
+	 * Align the MR to a 4K page size to match the ctrl page size and
+	 * the block virtual boundary.
+	 */
+	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, SZ_4K);
 	if (nr < count) {
 		if (nr < 0)
 			return nr;
@@ -1583,7 +1587,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 		goto out_cleanup_queue;
 
 	ctrl->ctrl.max_hw_sectors =
-		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
+		(ctrl->max_fr_pages - 1) << (ilog2(SZ_4K) - 9);
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-- 
1.7.1
