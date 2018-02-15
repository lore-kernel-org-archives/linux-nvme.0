From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 15 Feb 2018 19:46:28 +0200
Subject: [PATCH 2/2] nvmet-rdma: don't flush system_wq by default during
 remove_one
In-Reply-To: <1518716788-31362-1-git-send-email-maxg@mellanox.com>
References: <1518716788-31362-1-git-send-email-maxg@mellanox.com>
Message-ID: <1518716788-31362-2-git-send-email-maxg@mellanox.com>

The .remove_one function is called for any ib_device removal.
In case the removed device has no reference in our driver, there
is no need to flush the system work queue

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 978e169..d44ccc5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1460,6 +1460,7 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvmet_rdma_queue *queue, *tmp;
+	bool flush = false;
 
 	/* Device is being removed, delete all queues using this device */
 	mutex_lock(&nvmet_rdma_queue_mutex);
@@ -1468,13 +1469,15 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 		if (queue->dev->device != ib_device)
 			continue;
 
+		flush = true;
 		pr_info("Removing queue %d\n", queue->idx);
 		list_del_init(&queue->queue_list);
 		__nvmet_rdma_queue_disconnect(queue);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
-	flush_scheduled_work();
+	if (flush)
+		flush_scheduled_work();
 }
 
 static struct ib_client nvmet_rdma_ib_client = {
-- 
1.8.3.1
