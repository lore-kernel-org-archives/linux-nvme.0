From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 25 Oct 2018 14:13:09 -0700
Subject: [PATCH v3 2/2] nvmet-rdma: Use the system workqueues again for
 deletion work
In-Reply-To: <20181025211309.100564-1-bvanassche@acm.org>
References: <20181025211309.100564-1-bvanassche@acm.org>
Message-ID: <20181025211309.100564-3-bvanassche@acm.org>

Minimize system resource usage by switching back to the system
workqueues for deletion work. This patch reverts commit 2acf70ade79d
("nvmet-rdma: use a private workqueue for delete").

Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Johannes Berg <johannes.berg at intel.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/rdma.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e85445585884..a87bb8006d1a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -122,7 +122,6 @@ struct nvmet_rdma_device {
 	int			inline_page_count;
 };
 
-static struct workqueue_struct *nvmet_rdma_delete_wq;
 static bool nvmet_rdma_use_srq;
 module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
 MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
@@ -1280,8 +1279,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
 	if (ret) {
 		atomic_inc(&queues_being_released);
-		WARN_ON_ONCE(!queue_work(nvmet_rdma_delete_wq,
-					 &queue->release_work));
+		WARN_ON_ONCE(!schedule_work(&queue->release_work));
 		/* Destroying rdma_cm id is not needed here */
 		return 0;
 	}
@@ -1347,8 +1345,7 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 	if (disconnect) {
 		rdma_disconnect(queue->cm_id);
 		atomic_inc(&queues_being_released);
-		WARN_ON_ONCE(!queue_work(nvmet_rdma_delete_wq,
-					 &queue->release_work));
+		WARN_ON_ONCE(!schedule_work(&queue->release_work));
 	}
 }
 
@@ -1379,7 +1376,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 
 	pr_err("failed to connect queue %d\n", queue->idx);
 	atomic_inc(&queues_being_released);
-	WARN_ON_ONCE(!queue_work(nvmet_rdma_delete_wq, &queue->release_work));
+	WARN_ON_ONCE(!schedule_work(&queue->release_work));
 }
 
 /**
@@ -1661,17 +1658,8 @@ static int __init nvmet_rdma_init(void)
 	if (ret)
 		goto err_ib_client;
 
-	nvmet_rdma_delete_wq = alloc_workqueue("nvmet-rdma-delete-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
-	if (!nvmet_rdma_delete_wq) {
-		ret = -ENOMEM;
-		goto err_unreg_transport;
-	}
-
 	return 0;
 
-err_unreg_transport:
-	nvmet_unregister_transport(&nvmet_rdma_ops);
 err_ib_client:
 	ib_unregister_client(&nvmet_rdma_ib_client);
 	return ret;
@@ -1679,7 +1667,6 @@ static int __init nvmet_rdma_init(void)
 
 static void __exit nvmet_rdma_exit(void)
 {
-	destroy_workqueue(nvmet_rdma_delete_wq);
 	nvmet_unregister_transport(&nvmet_rdma_ops);
 	ib_unregister_client(&nvmet_rdma_ib_client);
 	WARN_ON_ONCE(!list_empty(&nvmet_rdma_queue_list));
-- 
2.19.1.568.g152ad8e336-goog
