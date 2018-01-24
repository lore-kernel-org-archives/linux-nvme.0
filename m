From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 24 Jan 2018 18:57:47 +0200
Subject: [PATCH 4/4] nvme: delete NVME_CTRL_NEW --> NVME_CTRL_LIVE transition
In-Reply-To: <1516813067-1717-1-git-send-email-maxg@mellanox.com>
References: <1516813067-1717-1-git-send-email-maxg@mellanox.com>
Message-ID: <1516813067-1717-5-git-send-email-maxg@mellanox.com>

In order to get from "new" to "live" state we must "connect" (or
"reset" and "connect" in case of pci transport), so disable the
option for this transition.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e7ab93..4f5065f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -269,7 +269,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
-- 
1.8.3.1
