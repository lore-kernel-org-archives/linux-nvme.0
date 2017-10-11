From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 12:49:51 +0300
Subject: [PATCH 4.14-rc] nvme-rdma: stop controller reset if the controller is
 deleting
Message-ID: <1507715391-430-1-git-send-email-sagi@grimberg.me>

If the controller is deleting (in case the user decided to delete
it), we have no point to continue reset sequence.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 039f38cb6987..cf2ac5d893d5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1821,7 +1821,11 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+	if (!changed) {
+		/* state change failure is ok if we're in DELETING state */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		return;
+	}
 
 	nvme_start_ctrl(&ctrl->ctrl);
 
-- 
2.7.4
