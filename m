From: jsmart2021@gmail.com (James Smart)
Date: Tue, 19 Sep 2017 16:16:08 -0700
Subject: [PATCH] nvme_fc: retry initial controller connections 3 times
Message-ID: <20170919231608.5575-1-jsmart2021@gmail.com>

Currently, if a frame is lost of command fails as part of initial
association create for a new controller, the new controller connection
request will immediately fail.

Add in an immediate 3 retry loop before giving up.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index af075e998944..1b91614263e3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2734,7 +2734,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 {
 	struct nvme_fc_ctrl *ctrl;
 	unsigned long flags;
-	int ret, idx;
+	int ret, idx, retry;
 
 	if (!(rport->remoteport.port_role &
 	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -2825,9 +2825,19 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	ret = nvme_fc_create_association(ctrl);
+	for (retry = 0; retry < 3; retry++) {
+		ret = nvme_fc_create_association(ctrl);
+		if (!ret)
+			break;
+	}
+
 	if (ret) {
+		/* couldn't schedule retry - fail out */
+		dev_err(ctrl->ctrl.device,
+			"NVME-FC{%d}: Connect retry failed\n", ctrl->cnum);
+
 		ctrl->ctrl.opts = NULL;
+
 		/* initiate nvme ctrl ref counting teardown */
 		nvme_uninit_ctrl(&ctrl->ctrl);
 		nvme_put_ctrl(&ctrl->ctrl);
-- 
2.13.1
