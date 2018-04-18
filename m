From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:11 -0400
Subject: [PATCH 20/20] nvmet: use processing paused state for VWC
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-21-chaitanya.kulkarni@wdc.com>

We use the ctrl processing paused state when switching between
O_SYNC and O_DIRECT.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b119a31eb6f9..f1d4005f92b0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -842,6 +842,11 @@ static void nvmet_set_features_vwc_file(struct nvmet_req *req)
 	struct nvmet_ns *ns;
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 
+	if (nvmet_ctrl_processing_pause(req->sq->ctrl) == false) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out;
+	}
+
 	if (subsys->vwc != le32_to_cpu(req->cmd->features.dword11)) {
 		subsys->vwc = le32_to_cpu(req->cmd->features.dword11);
 		mutex_lock(&subsys->lock);
@@ -860,6 +865,9 @@ static void nvmet_set_features_vwc_file(struct nvmet_req *req)
 		mutex_unlock(&subsys->lock);
 	}
 
+	if (nvmet_ctrl_processing_resume(req->sq->ctrl) == false)
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+out:
 	nvmet_req_complete(req, status);
 }
 
-- 
2.14.1
