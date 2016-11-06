From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  6 Nov 2016 19:26:40 +0200
Subject: [PATCH v2] nvmet: Don't queue fatal error work if csts.cfs is set
Message-ID: <1478453200-16762-1-git-send-email-sagi@grimberg.me>

In the transport, in case of an interal queue error like
error completion in rdma we trigger a fatal error. However,
multiple queues in the same controller can serr error completions
and we don't want to trigger fatal error work more than once.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- reversed the if condition to avoid a goto statement

Changes from v0:
- protect with ctrl lock instead of abusing atomic bitops on
    ctrl->csts

 drivers/nvme/target/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7c0fe31ee654..55ce769cecee 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -840,9 +840,13 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 {
-	ctrl->csts |= NVME_CSTS_CFS;
-	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
-	schedule_work(&ctrl->fatal_err_work);
+	mutex_lock(&ctrl->lock);
+	if (!(ctrl->csts & NVME_CSTS_CFS)) {
+		ctrl->csts |= NVME_CSTS_CFS;
+		INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
+		schedule_work(&ctrl->fatal_err_work);
+	}
+	mutex_unlock(&ctrl->lock);
 }
 EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
 
-- 
2.7.4
