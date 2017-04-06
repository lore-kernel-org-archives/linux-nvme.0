From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  6 Apr 2017 09:15:50 +0300
Subject: [PATCH for-4.11-rc 1/3] nvme-loop: Fix sqsize wrong assignment based
 on ctrl MQES capability
In-Reply-To: <1491459352-28200-1-git-send-email-sagi@grimberg.me>
References: <1491459352-28200-1-git-send-email-sagi@grimberg.me>
Message-ID: <1491459352-28200-2-git-send-email-sagi@grimberg.me>

both our sqsize and the controller MQES cap are a 0 based value,
so making it 1 based is wrong.

Reported-by: Trapp, Darren <Darren.Trapp at cavium.com>
Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 33b431e4eec3..0487fdf82cfc 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -408,7 +408,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	}
 
 	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
+		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->ctrl.sqsize);
 
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
 	if (error)
-- 
2.7.4
