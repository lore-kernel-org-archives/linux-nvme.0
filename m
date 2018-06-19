From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 15:45:33 +0300
Subject: [PATCH v2 1/2] nvmet: reset keep alive timer in controller enable
Message-ID: <20180619124534.26736-1-sagi@grimberg.me>

From: Max Gurtuvoy <maxg@mellanox.com>

Controllers that are not yet enabled should not really
enforce keep alive timeout, but we still want to track
a timeout and cleanup in case a host died before it enabled
us. Hence, simply reset the keep alive timer when the controller
is enabled.

Suggested-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- Added some code documentation

 drivers/nvme/target/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a03da764ecae..1ade6fe9b830 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -686,6 +686,14 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	}
 
 	ctrl->csts = NVME_CSTS_RDY;
+	/*
+	 * Controllers that are not yet enabled should not really
+	 * enforce keep alive timeout, but we still want to track
+	 * a timeout and cleanup in case a host died before it enabled
+	 * us. Hence, simply reset the keep alive timer when the controller
+	 * is enabled.
+	 */
+	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.14.1
