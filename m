From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Tue, 20 Mar 2018 11:07:29 +0000
Subject: [PATCH 1/2] nvme-rdma: Allow DELETING state change failure in
 error_recovery
Message-ID: <20180320110730.24070-1-nitzanc@mellanox.com>

While error recovery is ongoing, it is OK to move
ctrl to DELETING state (from concurrent delete_work).
Thus we don't need a warning for that case.

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 64a4b8c..987691c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -978,8 +978,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_start_queues(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure should never happen */
-		WARN_ON_ONCE(1);
+		/* state change failure is ok if we're in DELETING state */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
 		return;
 	}
 
-- 
1.8.2.3
