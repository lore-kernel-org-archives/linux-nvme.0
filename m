From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 14 Jun 2017 13:46:45 +0300
Subject: [PATCH] nvme-rdma: fix error code in nvme_rdma_create_ctrl()
Message-ID: <20170614104645.GO29394@elgon.mountain>

We accidentally return ERR_PTR(0) which is NULL.  The caller isn't
explicitly checking for that but I couldn't immediately spot whether
this would lead to a NULL dereference.  Anyway, we can fix add an
error code easily enough.

Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e84a74479dd8..8456cb6e2a70 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1940,12 +1940,14 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	/* sanity check icdoff */
 	if (ctrl->ctrl.icdoff) {
 		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
+		ret = -EINVAL;
 		goto out_remove_admin_queue;
 	}
 
 	/* sanity check keyed sgls */
 	if (!(ctrl->ctrl.sgls & (1 << 20))) {
 		dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not support\n");
+		ret = -EINVAL;
 		goto out_remove_admin_queue;
 	}
 
