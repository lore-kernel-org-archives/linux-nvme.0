From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 29 May 2018 11:25:44 -0700
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl support
In-Reply-To: <cover.1527618402.git.swise@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
Message-ID: <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>

The code was checking bit 20 instead of bit 2.  Also fixed
the log entry.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1eb4438..f11faa8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1949,8 +1949,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	/* sanity check keyed sgls */
-	if (!(ctrl->ctrl.sgls & (1 << 20))) {
-		dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not support\n");
+	if (!(ctrl->ctrl.sgls & (1 << 2))) {
+		dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not supported!\n");
 		ret = -EINVAL;
 		goto out_remove_admin_queue;
 	}
-- 
1.8.3.1
