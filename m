From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Sep 2017 17:01:38 +0300
Subject: [PATCH 3/3] nvme-rdma: don't fully stop the controller in error
 recovery
In-Reply-To: <1506002498-9177-1-git-send-email-sagi@grimberg.me>
References: <1506002498-9177-1-git-send-email-sagi@grimberg.me>
Message-ID: <1506002498-9177-3-git-send-email-sagi@grimberg.me>

By calling nvme_stop_ctrl on a already failed controller will
wait for the scan work to complete (only by identify timeout
expiration which is 60 seconds). This is unnecessary when we
already know that the controller has failed.

Reported-by: Yi Zhang <yizhan at redhat.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8441f6b3f617..92a03ff5fb4d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -967,7 +967,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_keep_alive(&ctrl->ctrl);
 
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-- 
2.7.4
