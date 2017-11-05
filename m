From: israelr@mellanox.com (Israel Rukshin)
Date: Sun,  5 Nov 2017 08:43:01 +0000
Subject: [PATCH] nvmet-rdma: Update queue list during ib_device removal
Message-ID: <1509871381-6247-1-git-send-email-israelr@mellanox.com>

A NULL deref happens when nvmet_rdma_remove_one() is called more than once
(e.g. while connected via 2 ports).
The first call frees the queues related to the first ib_device but
doesn't remove them from the queue list.
While calling nvmet_rdma_remove_one() for the second ib_device it goes over
the full queue list again and we get the NULL deref.

Fixes: f1d4ef7d ("nvmet-rdma: register ib_client to not deadlock in device removal")
Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grmberg.me>
---
 drivers/nvme/target/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 76d2bb7..3333d41 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1512,15 +1512,17 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
 
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
-	struct nvmet_rdma_queue *queue;
+	struct nvmet_rdma_queue *queue, *tmp;
 
 	/* Device is being removed, delete all queues using this device */
 	mutex_lock(&nvmet_rdma_queue_mutex);
-	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
+	list_for_each_entry_safe(queue, tmp, &nvmet_rdma_queue_list,
+				 queue_list) {
 		if (queue->dev->device != ib_device)
 			continue;
 
 		pr_info("Removing queue %d\n", queue->idx);
+		list_del_init(&queue->queue_list);
 		__nvmet_rdma_queue_disconnect(queue);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
-- 
1.8.3.1
