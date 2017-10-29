From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 29 Oct 2017 14:21:02 +0200
Subject: [PATCH 2/2] nvme-core: flush reset_work before safely continuing with
 delete operation
In-Reply-To: <1509279662-32169-1-git-send-email-sagi@grimberg.me>
References: <1509279662-32169-1-git-send-email-sagi@grimberg.me>
Message-ID: <1509279662-32169-2-git-send-email-sagi@grimberg.me>

Prevent racing controller reset and delete flows. reset_work must not
ever self-requeue so flushing it suffices.

Reported-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/fc.c   | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05161b700b59..d495c1d1f11c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -102,6 +102,7 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, delete_work);
 
+	flush_work(&ctrl->reset_work);
 	nvme_stop_ctrl(ctrl);
 	nvme_remove_namespaces(ctrl);
 	ctrl->ops->delete_ctrl(ctrl);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 780060c48218..cc214f5a3480 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2655,7 +2655,6 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
-- 
2.7.4
