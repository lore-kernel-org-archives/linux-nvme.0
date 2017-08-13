From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 13 Aug 2017 19:21:07 +0300
Subject: [PATCH 2/2] nvme: Rename AMS symbolic constants to fit specification
In-Reply-To: <1502641267-2984-1-git-send-email-maxg@mellanox.com>
References: <1502641267-2984-1-git-send-email-maxg@mellanox.com>
Message-ID: <1502641267-2984-2-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c |    2 +-
 include/linux/nvme.h     |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37046ac..8bfb8cd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1447,7 +1447,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 
 	ctrl->ctrl_config = NVME_CC_CSS_NVM;
 	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	ctrl->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ebbe6e8..8dd8b3f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -140,9 +140,9 @@ enum {
 	NVME_CC_SHN_SHIFT	= 14,
 	NVME_CC_IOSQES_SHIFT	= 16,
 	NVME_CC_IOCQES_SHIFT	= 20,
-	NVME_CC_ARB_RR		= 0 << NVME_CC_AMS_SHIFT,
-	NVME_CC_ARB_WRRU	= 1 << NVME_CC_AMS_SHIFT,
-	NVME_CC_ARB_VS		= 7 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
 	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
-- 
1.7.1
