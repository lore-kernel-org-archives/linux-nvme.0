From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  3 Nov 2016 23:17:22 +0200
Subject: [PATCH] nvmet: Don't queue fatal error work if csts.cfs is set
Message-ID: <1478207842-27774-1-git-send-email-sagi@grimberg.me>

In the transport, in case of an interal queue error like
error completion in rdma we trigger a fatal error. However,
multiple queues in the same controller can serr error completions
and we don't want to trigger fatal error work more than once.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4d5be2de25f5..ffc8445a1ac3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -840,7 +840,9 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 {
-	ctrl->csts |= NVME_CSTS_CFS;
+	if (test_and_set_bit(NVME_CSTS_CFS, (unsigned long *)&ctrl->csts))
+		return;
+
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 	schedule_work(&ctrl->fatal_err_work);
 }
-- 
2.7.4
