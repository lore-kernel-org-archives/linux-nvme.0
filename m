From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Mar 2017 06:29:11 +0200
Subject: [PATCH 1/2] nvme-rdma: fix module_init (theoretical) error path
Message-ID: <1489897752-16691-1-git-send-email-sagi@grimberg.me>

If nvmf_register_transport happened to fail
(it can't, but theoretically) we leak memory.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 71d1e1a6b928..07f1b9956027 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2068,12 +2068,20 @@ static int __init nvme_rdma_init_module(void)
 		return -ENOMEM;
 
 	ret = ib_register_client(&nvme_rdma_ib_client);
-	if (ret) {
-		destroy_workqueue(nvme_rdma_wq);
-		return ret;
-	}
+	if (ret)
+		goto err_destroy_wq;
+
+	ret = nvmf_register_transport(&nvme_rdma_transport);
+	if (ret)
+		goto err_unreg_client;
 
-	return nvmf_register_transport(&nvme_rdma_transport);
+	return 0;
+
+err_unreg_client:
+	ib_unregister_client(&nvme_rdma_ib_client);
+err_destroy_wq:
+	destroy_workqueue(nvme_rdma_wq);
+	return ret;
 }
 
 static void __exit nvme_rdma_cleanup_module(void)
-- 
2.7.4
