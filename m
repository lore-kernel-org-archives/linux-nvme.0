From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 31 Jan 2018 18:31:26 +0200
Subject: [PATCH 3/3] nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING
 transition
In-Reply-To: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
Message-ID: <1517416286-31109-4-git-send-email-maxg@mellanox.com>

There is no logical reason to move from live state to connecting
state. In case of initial connection establishment, the transition
should be NVME_CTRL_NEW --> NVME_CTRL_CONNECTING --> NVME_CTRL_LIVE.
In case of error recovery or reset, the transition should be
NVME_CTRL_LIVE --> NVME_CTRL_RESETTING --> NVME_CTRL_CONNECTING -->
NVME_CTRL_LIVE.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d7e304..c2a3700 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -297,7 +297,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_CONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
-		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
-- 
1.8.3.1
