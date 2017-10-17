From: jsmart2021@gmail.com (James Smart)
Date: Tue, 17 Oct 2017 16:32:44 -0700
Subject: [PATCH v3 1/5] nvme core: allow controller RESETTING to RECONNECTING
 transition
In-Reply-To: <20171017233248.6769-1-jsmart2021@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
Message-ID: <20171017233248.6769-2-jsmart2021@gmail.com>

Allow controller state transition : RESETTING to RECONNECTING

Transport will typically transition from LIVE->RESETTING when
initially performing a reset or recovering from an error. Adding
this transition allows a transport to transition to RECONNECTING
when it checks/waits for connectivity then creates new transport
connections and reinits the controller.

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

---
v3: no change. incorporated Reviewed-by's
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26c8913435b2..aa9e2df27bf7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -205,6 +205,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_RECONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
-- 
2.13.1
