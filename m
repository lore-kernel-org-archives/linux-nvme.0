From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:39 +0300
Subject: [PATCH 12/12] nvme-rdma: call ops->reg_read64 instead of
 nvmf_reg_read64
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-13-git-send-email-sagi@grimberg.me>

Make it a generic routine.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bd0d9f7a04ec..000e2f31e8ca 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -785,7 +785,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_cleanup_queue;
 
-	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP,
+	error = ctrl->ctrl.ops->reg_read64(&ctrl->ctrl, NVME_REG_CAP,
 			&ctrl->ctrl.cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
-- 
2.7.4
