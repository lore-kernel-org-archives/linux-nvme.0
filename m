From: jsmart2021@gmail.com (James Smart)
Date: Mon,  5 Jun 2017 15:03:42 -0700
Subject: [PATCH] nvme_fc: fix missing put reference on controller create
 failure
Message-ID: <20170605220342.10794-1-jsmart2021@gmail.com>

The failure case, of a create controller request, called
nvme_uninit_ctrl() but didn't do a put to allow the nvme
controller to be deleted.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 4d1e7e1103f9..cd5e1df4399b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3216,6 +3216,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		ctrl->ctrl.opts = NULL;
 		/* initiate nvme ctrl ref counting teardown */
 		nvme_uninit_ctrl(&ctrl->ctrl);
+		nvme_put_ctrl(&ctrl->ctrl);
 
 		/* as we're past the point where we transition to the ref
 		 * counting teardown path, if we return a bad pointer here,
-- 
2.11.0
