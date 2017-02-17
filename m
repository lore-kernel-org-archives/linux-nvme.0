From: jsmart2021@gmail.com (James Smart)
Date: Fri, 17 Feb 2017 07:57:28 -0800
Subject: [PATCH] nvme-fc: don't bother to validate ioccsz and iorcsz
Message-ID: <58a71d68.0dWjnIHVj0Wn1QYU%jsmart2021@gmail.com>


Discovery controllers don't set the values. They are in reserved
areas of the Identify Controller data structure.

Given the cmd completed, the minimal capsule sizes are supported,
so no need to check nqn to detect discovery controllers and
special case validations.

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fb51a8d..996e96c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2353,18 +2353,6 @@ __nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	/* sanity checks */
 
-	/* FC-NVME supports 64-byte SQE only */
-	if (ctrl->ctrl.ioccsz != 4) {
-		dev_err(ctrl->ctrl.device, "ioccsz %d is not supported!\n",
-				ctrl->ctrl.ioccsz);
-		goto out_remove_admin_queue;
-	}
-	/* FC-NVME supports 16-byte CQE only */
-	if (ctrl->ctrl.iorcsz != 1) {
-		dev_err(ctrl->ctrl.device, "iorcsz %d is not supported!\n",
-				ctrl->ctrl.iorcsz);
-		goto out_remove_admin_queue;
-	}
 	/* FC-NVME does not have other data in the capsule */
 	if (ctrl->ctrl.icdoff) {
 		dev_err(ctrl->ctrl.device, "icdoff %d is not supported!\n",
-- 
2.5.0
