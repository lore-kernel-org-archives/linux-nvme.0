From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 May 2019 14:20:35 -0600
Subject: [PATCH 2/3] nvme: rearm fw notification in admin only state
In-Reply-To: <20190524202036.17265-1-keith.busch@intel.com>
References: <20190524202036.17265-1-keith.busch@intel.com>
Message-ID: <20190524202036.17265-3-keith.busch@intel.com>

From: Keith Busch <kbusch@kernel.org>

Getting the firmware log is an admin command, so admin-only or live
states are valid to rearm the activation notice.

Signed-off-by: Keith Busch <kbusch at kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b7c2afd84cb..96dac2292897 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3615,7 +3615,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 		msleep(100);
 	}
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (ctrl->state != NVME_CTRL_LIVE &&
+	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
 		return;
 
 	nvme_start_queues(ctrl);
-- 
2.14.4
