From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Tue, 25 Apr 2017 15:32:01 -0700
Subject: [PATCH] nvme_fc: stop queues on error detection
Message-ID: <20170425223201.3835-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Per the recommendation by Sagi on:
http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html

Rather than waiting for reset work thread to stop queues and abort the ios,
immediately stop the queues on error detection. Reset thread will restop
the queues (as it's called on other paths), but it does not appear to have
a side effect.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 4d4b902..16a658c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1751,6 +1751,10 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
 
+	/* stop the queues on error, cleanup is in reset thread */
+	if (ctrl->queue_count > 1)
+		nvme_stop_queues(&ctrl->ctrl);
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
-- 
2.9.3
