From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 28 Jan 2018 15:58:07 +0200
Subject: [PATCH 5/5] nvme: delete NVME_CTRL_NEW --> NVME_CTRL_LIVE transition
In-Reply-To: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
References: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
Message-ID: <1517147887-15645-6-git-send-email-maxg@mellanox.com>

In order to get for "new" to "live" state we must "connect" (or
"reset" and "connect" in case of pci transport), so disable the
option for this transition.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2a3700..b8ddb7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -274,7 +274,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
-- 
1.8.3.1
