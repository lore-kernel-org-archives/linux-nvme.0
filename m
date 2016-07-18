From: pandit.parav@gmail.com (Parav Pandit)
Date: Mon, 18 Jul 2016 23:17:56 +0530
Subject: [PATCH] NVMe: Fix max hardware sectors calculation for non zero MDTS
Message-ID: <1468864076-6809-1-git-send-email-pandit.parav@gmail.com>

This fix calculates maximum hw sectors correctly.
Current code incorrectly calculates it by right shifting MDTS
that can overflow max_hw_sectors. This incorrect calculation leads
smaller value of maximum hw sectors due to overflow, resulting into
lower performance for larger size IOs which gets split into
smaller IOs by the block IO stack.
Fix:
Unit of MDTS is MPSMIN (minimum page size).
MDTS returns value in number of pages of maximum data transfer size;
so convert page unit to sector unit correctly.

Signed-off-by: Parav Pandit <pandit.parav at gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584..9a162b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1120,7 +1120,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	memcpy(ctrl->model, id->mn, sizeof(id->mn));
 	memcpy(ctrl->firmware_rev, id->fr, sizeof(id->fr));
 	if (id->mdts)
-		ctrl->max_hw_sectors = 1 << (id->mdts + page_shift - 9);
+		ctrl->max_hw_sectors = id->mdts * (1 << (page_shift - 9));
 	else
 		ctrl->max_hw_sectors = UINT_MAX;
 
-- 
1.8.3.1
