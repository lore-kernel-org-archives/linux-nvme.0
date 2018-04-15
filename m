From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 15 Apr 2018 11:47:40 +0300
Subject: [PATCH 1/2] nvmet: reset keep alive timer in controller enable
Message-ID: <20180415084741.4235-1-sagi@grimberg.me>

From: Max Gurtuvoy <maxg@mellanox.com>

Controllers that are not yet enabled should not really
enforce keep alive timeout, but we still want to track
a timeout and cleanup in case a host died before it enabled
us. Hence, simply reset the keep alive timer when the controller
is enabled.

Suggested-by: Max Gurtuvoy <maxg at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index fe151d672241..a81bf4d5e60c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -643,6 +643,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	}
 
 	ctrl->csts = NVME_CSTS_RDY;
+	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.14.1
