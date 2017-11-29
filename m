From: jsmart2021@gmail.com (James Smart)
Date: Wed, 29 Nov 2017 15:11:37 -0800
Subject: [PATCH] nvme_fc: remove double put reference if admin connect fails
Message-ID: <20171129231137.32384-1-jsmart2021@gmail.com>

There are two put references in the failure case of initial
create_association. The first put actually frees the controller,
thus the second put references freed memory.

Remove the unnecessary 2nd put

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0a8af4daef89..794e66e4aa20 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3221,7 +3221,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 		/* initiate nvme ctrl ref counting teardown */
 		nvme_uninit_ctrl(&ctrl->ctrl);
-		nvme_put_ctrl(&ctrl->ctrl);
 
 		/* Remove core ctrl ref. */
 		nvme_put_ctrl(&ctrl->ctrl);
-- 
2.13.1
