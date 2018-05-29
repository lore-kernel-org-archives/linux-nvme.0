From: dmilburn@redhat.com (David Milburn)
Date: Tue, 29 May 2018 15:42:34 -0500
Subject: [PATCH] nvme: report subsystem-reset not supported by controller.
Message-ID: <1527626554-101086-1-git-send-email-dmilburn@redhat.com>

Add a little more description for "nvme subsystem-reset"
failures, currently driver reports "Inappropriate ioctl
for device".

$ nvme subsystem-reset /dev/nvme0
Subsystem-reset: Inappropriate ioctl for device

With this change report not permitted on controller's that
do not support NVM Subsystem Reset.

$ nvme subsystem-reset /dev/nvme0
Subsystem-reset: Operation not permitted

<dmesg>
[   88.261923] nvme nvme0: NVM Subsystem Reset not supported.
---
 drivers/nvme/host/nvme.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 17d2f7c..319fc39 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -343,8 +343,10 @@ static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
 
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
-	if (!ctrl->subsystem)
-		return -ENOTTY;
+	if (!ctrl->subsystem) {
+		dev_err(ctrl->device, "NVM Subsystem Reset not supported.\n");
+		return -EPERM;
+	}
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }
 
-- 
1.8.3.1
