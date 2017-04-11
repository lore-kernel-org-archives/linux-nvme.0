From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 12 Apr 2017 01:01:49 +0300
Subject: [PATCH 2/2] nvme-rdma: add support for arbitrary sg lists mapping
In-Reply-To: <1491948109-9224-1-git-send-email-maxg@mellanox.com>
References: <1491948109-9224-1-git-send-email-maxg@mellanox.com>
Message-ID: <1491948109-9224-2-git-send-email-maxg@mellanox.com>

If the device support arbitrary sg list mapping (device
cap IB_DEVICE_SG_GAPS_REG set) we allocate the memory regions with
IB_MR_TYPE_SG_GAPS and allow the block layer to send us gappy bio
vectors. We use this functionality in iSER driver as well.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 47a479f..2c43e27 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -67,6 +67,7 @@ struct nvme_rdma_qe {
 struct nvme_rdma_request {
 	struct nvme_request	req;
 	struct ib_mr		*mr;
+	enum ib_mr_type		mr_type;
 	struct nvme_rdma_qe	sqe;
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
 	u32			num_sge;
@@ -294,7 +295,7 @@ static int nvme_rdma_reinit_request(void *data, struct request *rq)
 
 	ib_dereg_mr(req->mr);
 
-	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
+	req->mr = ib_alloc_mr(dev->pd, req->mr_type,
 			ctrl->max_fr_pages);
 	if (IS_ERR(req->mr)) {
 		ret = PTR_ERR(req->mr);
@@ -348,8 +349,12 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
 	if (ret)
 		return ret;
 
-	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
-			ctrl->max_fr_pages);
+	if (ibdev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
+		req->mr_type = IB_MR_TYPE_SG_GAPS;
+	else
+		req->mr_type = IB_MR_TYPE_MEM_REG;
+
+	req->mr = ib_alloc_mr(dev->pd, req->mr_type, ctrl->max_fr_pages);
 	if (IS_ERR(req->mr)) {
 		ret = PTR_ERR(req->mr);
 		goto out_free_qe;
@@ -1608,6 +1613,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	ctrl->ctrl.sqsize =
 		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
 
+	if (ctrl->device->dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
+		ctrl->ctrl.sg_gaps_support = true;
+
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
 	if (error)
 		goto out_cleanup_queue;
-- 
1.7.1
