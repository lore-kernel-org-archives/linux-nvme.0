From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Oct 2016 13:31:58 -0400
Subject: [PATCH] nvme: Stop probing a removed device
Message-ID: <1476207118-10113-1-git-send-email-keith.busch@intel.com>

There is no reason the nvme controller can ever return all 1's from
reading the CSTS register. This patch returns an error if we observe
that status. Without this, we may incorrectly proceed with controller
initialization and unnecessarilly rely on error handling to clean this.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62bdbe6..f80ed33 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1086,6 +1086,8 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 	int ret;
 
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+		if (csts == ~0)
+			return -ENODEV;
 		if ((csts & NVME_CSTS_RDY) == bit)
 			break;
 
-- 
2.7.2
