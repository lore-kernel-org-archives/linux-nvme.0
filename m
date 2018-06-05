From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 5 Jun 2018 10:16:41 -0700
Subject: [PATCH v4 1/3] nvme-rdma: correctly check for target keyed sgl support
In-Reply-To: <cover.1528219321.git.swise@opengridcomputing.com>
References: <cover.1528219321.git.swise@opengridcomputing.com>
Message-ID: <be1138dce21044c9f3249a519f6049dcd7756c99.1528219321.git.swise@opengridcomputing.com>

The code was checking bit 20 instead of bit 2.  Also fixed the log entry.

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1eb4438..d9f5fbe 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1949,8 +1949,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	/* sanity check keyed sgls */
-	if (!(ctrl->ctrl.sgls & (1 << 20))) {
-		dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not support\n");
+	if (!(ctrl->ctrl.sgls & (1 << 2))) {
+		dev_err(ctrl->ctrl.device,
+			"Mandatory keyed sgls are not supported!\n");
 		ret = -EINVAL;
 		goto out_remove_admin_queue;
 	}
-- 
1.8.3.1
