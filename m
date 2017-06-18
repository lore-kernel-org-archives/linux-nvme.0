From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:21:53 +0300
Subject: [PATCH rfc 19/30] nvme-rdma: call ops->reg_read64 instead of
 nvmf_reg_read64
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-20-git-send-email-sagi@grimberg.me>

Make it a generic routine.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ce63dd40e6b4..753e66c1d77d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -860,7 +860,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 	if (error)
 		goto out_cleanup_connect_queue;
 
-	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
+	error = ctrl->ctrl.ops->reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
-- 
2.7.4
