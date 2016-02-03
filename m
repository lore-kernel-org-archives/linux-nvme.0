From: keith.busch@intel.com (Keith Busch)
Date: Wed,  3 Feb 2016 09:05:40 -0700
Subject: [PATCH 1/4] NVMe: Fix io incapable return values
In-Reply-To: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
Message-ID: <1454515543-21683-2-git-send-email-keith.busch@intel.com>

The function returns true when the controller can't handle IO.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4fb5bb7..9664d07 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -139,9 +139,9 @@ static inline bool nvme_io_incapable(struct nvme_ctrl *ctrl)
 	u32 val = 0;
 
 	if (ctrl->ops->io_incapable(ctrl))
-		return false;
+		return true;
 	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &val))
-		return false;
+		return true;
 	return val & NVME_CSTS_CFS;
 }
 
-- 
2.6.2.307.g37023ba
