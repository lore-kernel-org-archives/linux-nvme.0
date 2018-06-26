From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 26 Jun 2018 15:16:05 +0300
Subject: [PATCH 1/1] nvme-rdma: fix WARN_ON condition during RDMA ctrl setup
Message-ID: <1530015365-30049-1-git-send-email-maxg@mellanox.com>

We can only agree to fail moving to NVME_CTRL_LIVE while we're in
NVME_CTRL_DELETING for existing controllers. In case we are in the
initial creation of the controller we never should fail.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
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
