From: israelr@mellanox.com (Israel Rukshin)
Date: Mon,  3 Dec 2018 15:50:05 +0000
Subject: [PATCH 2/2] nvme: Remove unused function
In-Reply-To: <1543852205-776-1-git-send-email-israelr@mellanox.com>
References: <1543852205-776-1-git-send-email-israelr@mellanox.com>
Message-ID: <1543852205-776-2-git-send-email-israelr@mellanox.com>

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/nvme.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cee79cb..5486d4c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -364,15 +364,6 @@ static inline void nvme_fault_inject_fini(struct nvme_ns *ns) {}
 static inline void nvme_should_fail(struct request *req) {}
 #endif
 
-static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
-{
-	u32 val = 0;
-
-	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &val))
-		return false;
-	return val & NVME_CSTS_RDY;
-}
-
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->subsystem)
-- 
1.8.3.1
