From: kenneth.heitke@intel.com (Kenneth Heitke)
Date: Thu,  4 Apr 2019 12:57:45 -0600
Subject: [PATCH] Log error status on Identify Namespace failure
Message-ID: <20190404185745.12501-1-kenneth.heitke@intel.com>

Identify Namespace failures are logged as a warning but there is not
an indication of the cause for the failure. Update the log message to
include the error status.

Signed-off-by: Kenneth Heitke <kenneth.heitke at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5939112b9b6..ddb943395118 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1105,7 +1105,7 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
 	if (error) {
-		dev_warn(ctrl->device, "Identify namespace failed\n");
+		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(id);
 		return NULL;
 	}
-- 
2.17.1
