From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 14 Jan 2018 18:36:07 +0200
Subject: [PATCH 1/1] nvme-rdma: fix possible list_del corruption while freeing
 ctrl
Message-ID: <1515947767-7701-1-git-send-email-maxg@mellanox.com>

In case of concurrent calls to nvme_rdma_free_ctrl will occur,
we may end up with a wrong and non-protected check for list emptiness.
For current implementation, this is only for good practice.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a0bba7..591fa4d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -872,11 +872,12 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
-
 	mutex_lock(&nvme_rdma_ctrl_mutex);
-	list_del(&ctrl->list);
+	if (list_empty(&ctrl->list)) {
+		mutex_unlock(&nvme_rdma_ctrl_mutex);
+		goto free_ctrl;
+	}
+	list_del_init(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
 	kfree(ctrl->queues);
-- 
1.8.3.1
