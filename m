From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 24 Jan 2018 18:57:46 +0200
Subject: [PATCH 3/4] nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING
 transition
In-Reply-To: <1516813067-1717-1-git-send-email-maxg@mellanox.com>
References: <1516813067-1717-1-git-send-email-maxg@mellanox.com>
Message-ID: <1516813067-1717-4-git-send-email-maxg@mellanox.com>

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
index 071d163..8e7ab93 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -292,7 +292,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_CONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
-		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
-- 
1.8.3.1
