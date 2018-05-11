From: keith.busch@intel.com (Keith Busch)
Date: Fri, 11 May 2018 10:25:01 -0600
Subject: [PATCH] Fix controller reset return
Message-ID: <20180511162501.7258-1-keith.busch@intel.com>

From: Charles Machalow <charles.machalow@intel.com>

If the Controller Reset comes in when the device had no namespaces,
we're incorrectly giving back ENETRESET.

Fixes: 8000d1fdb0  ("nvme-rdma: fix sysfs invoked reset_ctrl error flow ")
Cc: <stable at vger.kernel.org>
Signed-off-by: Charles Machalow <charles.machalow at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd03f2bdac7b..b4eb74f14c02 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -117,7 +117,8 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret = nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state != NVME_CTRL_LIVE)
+		if (ctrl->state != NVME_CTRL_LIVE &&
+		    ctrl->state != NVME_CTRL_ADMIN_ONLY)
 			ret = -ENETRESET;
 	}
 
-- 
2.14.3
