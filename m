From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  6 Nov 2016 11:48:10 +0200
Subject: [PATCH] nvmet-rdma: add queue to queue list only if connection
 established
Message-ID: <1478425690-32460-1-git-send-email-sagi@grimberg.me>

In case we accepted a queue connection and it failed, we might not
remove the queue from the list. Instead of dealing with it, simply
add the insert the queue only if we successfully established.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bafd9898b5f6..c25a5f58eea6 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1184,10 +1184,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	if (ret)
 		goto release_queue;
 
-	mutex_lock(&nvmet_rdma_queue_mutex);
-	list_add_tail(&queue->queue_list, &nvmet_rdma_queue_list);
-	mutex_unlock(&nvmet_rdma_queue_mutex);
-
 	return 0;
 
 release_queue:
@@ -1209,6 +1205,10 @@ static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 	}
 	queue->state = NVMET_RDMA_Q_LIVE;
 
+	mutex_lock(&nvmet_rdma_queue_mutex);
+	list_add_tail(&queue->queue_list, &nvmet_rdma_queue_list);
+	mutex_unlock(&nvmet_rdma_queue_mutex);
+
 	while (!list_empty(&queue->rsp_wait_list)) {
 		struct nvmet_rdma_rsp *cmd;
 
-- 
2.7.4
