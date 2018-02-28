From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 28 Feb 2018 13:12:38 +0200
Subject: [PATCH v3 1/2] nvmet-rdma: Don't flush system_wq by default during
 remove_one
Message-ID: <1519816359-27483-1-git-send-email-maxg@mellanox.com>

The .remove_one function is called for any ib_device removal.
In case the removed device has no reference in our driver, there
is no need to flush the system work queue.

Reviewed-by: Israel Rukshin <israelr at mellanox.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---

Changes from v2:
 - remove wrong WARNING in case device not found

Changes from v1:
 - check for the ib_device in the device list
---
 drivers/nvme/target/rdma.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 978e169..1d873f7 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1460,8 +1460,25 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvmet_rdma_queue *queue, *tmp;
+	struct nvmet_rdma_device *ndev;
+	bool found = false;
+
+	mutex_lock(&device_list_mutex);
+	list_for_each_entry(ndev, &device_list, entry) {
+		if (ndev->device == ib_device) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&device_list_mutex);
+
+	if (!found)
+		return;
 
-	/* Device is being removed, delete all queues using this device */
+	/*
+	 * IB Device that is used by nvmet controllers is being removed,
+	 * delete all queues using this device.
+	 */
 	mutex_lock(&nvmet_rdma_queue_mutex);
 	list_for_each_entry_safe(queue, tmp, &nvmet_rdma_queue_list,
 				 queue_list) {
-- 
1.8.3.1
