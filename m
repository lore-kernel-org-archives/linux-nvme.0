From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 22 Feb 2018 20:17:22 +0200
Subject: [PATCH 2/2] nvme-rdma: Don't flush delete_wq by default during
 remove_one
In-Reply-To: <1519323442-30819-1-git-send-email-maxg@mellanox.com>
References: <1519323442-30819-1-git-send-email-maxg@mellanox.com>
Message-ID: <1519323442-30819-2-git-send-email-maxg@mellanox.com>

The .remove_one function is called for any ib_device removal.
In case the removed device has no reference in our driver, there
is no need to flush the work queue.

Reviewed-by: Israel Rukshin <israelr at mellanox.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---

Changes from v1:
 - check for the ib_device in the device list

---
 drivers/nvme/host/rdma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3a51ed5..22dd752 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2025,6 +2025,22 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvme_rdma_ctrl *ctrl;
+	struct nvme_rdma_device *ndev;
+	bool found = false;
+
+	mutex_lock(&device_list_mutex);
+	list_for_each_entry(ndev, &device_list, entry) {
+		if (ndev->dev == ib_device) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&device_list_mutex);
+
+	if (!found) {
+		WARN_ON_ONCE(!list_empty(&nvme_rdma_ctrl_list));
+		return;
+	}
 
 	/* Delete all controllers using this device */
 	mutex_lock(&nvme_rdma_ctrl_mutex);
-- 
1.8.3.1
