From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  6 Nov 2016 19:30:48 +0200
Subject: [PATCH v1] nvmet-rdma: don't forget to delete a queue from the list
 of connection failed
Message-ID: <1478453448-17520-1-git-send-email-sagi@grimberg.me>

In case we accepted a queue connection and it failed, we might not
remove the queue from the list until we unload and clean it up.
We should delete it from the queue list on the relevant handler.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- changed strategy according to hch's comments. remove the queue
  on connection failure handlers.
- chaged the commit description (was "nvmet-rdma: add queue to queue list only
  if connection established")

 drivers/nvme/target/rdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bafd9898b5f6..a9eb677d562a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1272,7 +1272,12 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 {
 	WARN_ON_ONCE(queue->state != NVMET_RDMA_Q_CONNECTING);
 
-	pr_err("failed to connect queue\n");
+	mutex_lock(&nvmet_rdma_queue_mutex);
+	if (!list_empty(&queue->queue_list))
+		list_del_init(&queue->queue_list);
+	mutex_unlock(&nvmet_rdma_queue_mutex);
+
+	pr_err("failed to connect queue %d\n", queue->idx);
 	schedule_work(&queue->release_work);
 }
 
-- 
2.7.4
