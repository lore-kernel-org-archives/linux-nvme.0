From: colin.king@canonical.com (Colin King)
Date: Tue, 16 Aug 2016 09:24:39 +0100
Subject: [PATCH] nvme-rdma: initialize ret to zero to avoid returning garbage
Message-ID: <1471335879-6088-1-git-send-email-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

ret is not initialized so it contains garbage.  Ensure garbage
is not returned by initializing rc to 0.

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d2875b..9c69393 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1319,7 +1319,7 @@ out_destroy_queue_ib:
 static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-	int ret;
+	int ret = 0;
 
 	/* Own the controller deletion */
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
-- 
2.8.1
