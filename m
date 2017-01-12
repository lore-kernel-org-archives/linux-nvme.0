From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 12:31:19 +0200
Subject: [PATCH 5/5] nvmet: Call fatal_error from keep-alive timout expiration
In-Reply-To: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
References: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
Message-ID: <1484217079-9259-6-git-send-email-sagi@grimberg.me>

We only need to call delete_ctrl once, so given that both
keep-alive timeout and any other fatal error can trigger it,
just make sure we only call delete_ctrl once.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index dcdc2f6146f1..5267ce20c12d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -201,7 +201,7 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	pr_err("ctrl %d keep-alive timer (%d seconds) expired!\n",
 		ctrl->cntlid, ctrl->kato);
 
-	ctrl->ops->delete_ctrl(ctrl);
+	nvmet_ctrl_fatal_error(ctrl);
 }
 
 static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
-- 
2.7.4
