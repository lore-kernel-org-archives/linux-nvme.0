From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  6 Nov 2016 11:16:18 +0200
Subject: [PATCH v1] nvmet: Don't queue fatal error work if csts.cfs is set
Message-ID: <1478423778-29829-1-git-send-email-sagi@grimberg.me>

In the transport, in case of an interal queue error like
error completion in rdma we trigger a fatal error. However,
multiple queues in the same controller can serr error completions
and we don't want to trigger fatal error work more than once.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v0:
- protect with ctrl lock instead of abusing atomic bitops on
  ctrl->csts

 drivers/nvme/target/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7c0fe31ee654..3903150c489a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -840,9 +840,15 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 {
+	mutex_lock(&ctrl->lock);
+	if (ctrl->csts & NVME_CSTS_CFS)
+		goto out;
+
 	ctrl->csts |= NVME_CSTS_CFS;
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 	schedule_work(&ctrl->fatal_err_work);
+out:
+	mutex_unlock(&ctrl->lock);
 }
 EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
 
-- 
2.7.4
