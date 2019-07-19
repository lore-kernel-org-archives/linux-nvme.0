From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Jul 2019 12:45:43 -0700
Subject: [PATCH 1/4] nvme: have nvme_init_identify set ctrl->cap
In-Reply-To: <20190719194546.24229-1-sagi@grimberg.me>
References: <20190719194546.24229-1-sagi@grimberg.me>
Message-ID: <20190719194546.24229-2-sagi@grimberg.me>

No need to use a stack cap variable.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76cd3dd8736a..058e06e40df8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2563,7 +2563,6 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
-	u64 cap;
 	int ret, page_shift;
 	u32 max_hw_sectors;
 	bool prev_apst_enabled;
@@ -2574,15 +2573,15 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return ret;
 	}
 
-	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
 	if (ret) {
 		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
 		return ret;
 	}
-	page_shift = NVME_CAP_MPSMIN(cap) + 12;
+	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
 
 	if (ctrl->vs >= NVME_VS(1, 1, 0))
-		ctrl->subsystem = NVME_CAP_NSSRC(cap);
+		ctrl->subsystem = NVME_CAP_NSSRC(ctrl->cap);
 
 	ret = nvme_identify_ctrl(ctrl, &id);
 	if (ret) {
-- 
2.17.1
