From: israelr@mellanox.com (Israel Rukshin)
Date: Mon,  5 Nov 2018 16:23:51 +0000
Subject: [PATCH] nvmet-rdma: Fix using unallocated nvmet_rdma_delete_wq
Message-ID: <1541435031-16919-1-git-send-email-israelr@mellanox.com>

nvmet_rdma_ib_client .remove callback is using nvmet_rdma_delete_wq.
Therefore nvmet_rdma_delete_wq must be destroyed only after calling
to ib_unregister_client().
The bug may happens when unloading the module with open connections.

Fixes: 2acf70a ("nvmet-rdma: use a private workqueue for delete")
Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bd265ac..9d75eb6 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1642,35 +1642,33 @@ static int __init nvmet_rdma_init(void)
 {
 	int ret;
 
+	nvmet_rdma_delete_wq = alloc_workqueue("nvmet-rdma-delete-wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvmet_rdma_delete_wq)
+		return -ENOMEM;
+
 	ret = ib_register_client(&nvmet_rdma_ib_client);
 	if (ret)
-		return ret;
+		goto err_destroy_workqueue;
 
 	ret = nvmet_register_transport(&nvmet_rdma_ops);
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
+err_destroy_workqueue:
+	destroy_workqueue(nvmet_rdma_delete_wq);
 	return ret;
 }
 
 static void __exit nvmet_rdma_exit(void)
 {
-	destroy_workqueue(nvmet_rdma_delete_wq);
 	nvmet_unregister_transport(&nvmet_rdma_ops);
 	ib_unregister_client(&nvmet_rdma_ib_client);
+	destroy_workqueue(nvmet_rdma_delete_wq);
 	WARN_ON_ONCE(!list_empty(&nvmet_rdma_queue_list));
 	ida_destroy(&nvmet_rdma_queue_ida);
 }
-- 
1.8.3.1
