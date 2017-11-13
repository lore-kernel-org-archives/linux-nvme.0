From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 23:29:05 +0200
Subject: [PATCH] nvmet-rdma: removed queues cleanup from module exit
Message-ID: <20171113212905.28894-1-sagi@grimberg.me>

We already do that when we are notified in device removal
which is triggered when unregistering as an ib client.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- warn if list is not empty after we unregistered the ib_client (which
  is a definite memory leak)

 drivers/nvme/target/rdma.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 49912909c298..34227ec9491f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1558,25 +1558,9 @@ static int __init nvmet_rdma_init(void)
 
 static void __exit nvmet_rdma_exit(void)
 {
-	struct nvmet_rdma_queue *queue;
-
 	nvmet_unregister_transport(&nvmet_rdma_ops);
-
-	flush_scheduled_work();
-
-	mutex_lock(&nvmet_rdma_queue_mutex);
-	while ((queue = list_first_entry_or_null(&nvmet_rdma_queue_list,
-			struct nvmet_rdma_queue, queue_list))) {
-		list_del_init(&queue->queue_list);
-
-		mutex_unlock(&nvmet_rdma_queue_mutex);
-		__nvmet_rdma_queue_disconnect(queue);
-		mutex_lock(&nvmet_rdma_queue_mutex);
-	}
-	mutex_unlock(&nvmet_rdma_queue_mutex);
-
-	flush_scheduled_work();
 	ib_unregister_client(&nvmet_rdma_ib_client);
+	WARN_ON_ONCE(!list_empty(&nvmet_rdma_queue_list));
 	ida_destroy(&nvmet_rdma_queue_ida);
 }
 
-- 
2.14.1
