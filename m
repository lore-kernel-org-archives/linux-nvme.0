From: dmilburn@redhat.com (David Milburn)
Date: Thu, 29 Jun 2017 09:33:19 -0500
Subject: [PATCH] nvme-rdma: stop keep_alive before nvme_uninit_ctrl
Message-ID: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>

Its possible for nvme_keep_alive_work() to hit an error
condition after the nvme_uninit_ctrl() in __nvme_rdma_remove_ctrl().
This can lead to usage of NULL pointer in "dev_err(ctrl->device..."
since device has been destroyed by nvme_uninit_ctrl().

This has been seen during continous loop of (discover, connect,
IO, disconnect).

Reported-by: Yi Zhang <yizhan at redhat.com>
Tested-by: Yi Zhang <yizhan at redhat.com>
Signed-off-by: David Milburn <dmilburn at redhat.com>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 24397d3..1f73ace 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1683,6 +1683,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 
 static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	if (shutdown)
 		nvme_rdma_shutdown_ctrl(ctrl);
-- 
1.8.3.1
