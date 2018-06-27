From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 27 Jun 2018 12:35:59 +0300
Subject: [v2 PATCH 1/1] nvme-rdma: fix WARN_ON condition during RDMA ctrl setup
Message-ID: <1530092159-20275-1-git-send-email-maxg@mellanox.com>

We can only agree to fail moving to NVME_CTRL_LIVE while we're in
NVME_CTRL_DELETING for existing controllers, so don't warn in this
case. If we are during the initial creation of the controller, warn
unconditionally for each failure on moving to NVME_CTRL_LIVE state.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---

Changes from v1:
 - change log update

---
 drivers/nvme/host/rdma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5194568..0b92262 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -977,8 +977,14 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	if (!changed) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		if (new)
+			WARN_ON_ONCE(1);
+		else
+			/*
+			 * state change failure is ok if we're in DELETING
+			 * state for existing controllers only.
+			 */
+			WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
 		ret = -EINVAL;
 		goto destroy_io;
 	}
-- 
1.8.3.1
