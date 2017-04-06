From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  6 Apr 2017 09:15:52 +0300
Subject: [PATCH for-4.11-rc 3/3] nvme-fc: Fix sqsize wrong assignment based on
 ctrl MQES capability
In-Reply-To: <1491459352-28200-1-git-send-email-sagi@grimberg.me>
References: <1491459352-28200-1-git-send-email-sagi@grimberg.me>
Message-ID: <1491459352-28200-4-git-send-email-sagi@grimberg.me>

both our sqsize and the controller MQES cap are a 0 based value,
so making it 1 based is wrong.

Reported-by: Trapp, Darren <Darren.Trapp at cavium.com>
Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fc42172c796a..6953a5762153 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2011,7 +2011,7 @@ nvme_fc_configure_admin_queue(struct nvme_fc_ctrl *ctrl)
 	}
 
 	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
+		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->ctrl.sqsize);
 
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
 	if (error)
-- 
2.7.4
