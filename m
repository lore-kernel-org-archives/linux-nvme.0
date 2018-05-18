From: keith.busch@intel.com (Keith Busch)
Date: Fri, 18 May 2018 10:38:21 -0600
Subject: [PATCH 4/6] nvme: Allow reset from CONNECTING state
In-Reply-To: <20180518163823.27820-1-keith.busch@intel.com>
References: <20180518163823.27820-1-keith.busch@intel.com>
Message-ID: <20180518163823.27820-4-keith.busch@intel.com>

A failed connection may be retryable. This patch allows the connecting
state to initiate a reset so that it may try to connect again.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 34d7731f1419..bccc92206fba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -293,6 +293,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_ADMIN_ONLY:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
-- 
2.14.3
