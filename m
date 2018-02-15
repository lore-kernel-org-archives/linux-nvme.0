From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 15 Feb 2018 19:46:27 +0200
Subject: [PATCH 1/2] nvme-rdma: don't flush delete_wq by default during
 remove_one
Message-ID: <1518716788-31362-1-git-send-email-maxg@mellanox.com>

The .remove_one function is called for any ib_device removal.
In case the removed device has no reference in our driver, there
is no need to flush the work queue.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3a51ed5..cff9b54 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2025,12 +2025,15 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvme_rdma_ctrl *ctrl;
+	bool flush = false;
 
 	/* Delete all controllers using this device */
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
 		if (ctrl->device->dev != ib_device)
 			continue;
+
+		flush = true;
 		dev_info(ctrl->ctrl.device,
 			"Removing ctrl: NQN \"%s\", addr %pISp\n",
 			ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
@@ -2038,7 +2041,8 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	flush_workqueue(nvme_delete_wq);
+	if (flush)
+		flush_workqueue(nvme_delete_wq);
 }
 
 static struct ib_client nvme_rdma_ib_client = {
-- 
1.8.3.1
