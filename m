From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Mar 2017 14:22:32 +0200
Subject: [PATCH 3/3] nvme-fc: fix module_init (theoretical) error path
Message-ID: <1489926152-9798-1-git-send-email-sagi@grimberg.me>

If nvmf_register_transport happened to fail
(it can't, but theoretically) we leak memory.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9690beb15e69..f77cdcf51e65 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2546,11 +2546,20 @@ static struct nvmf_transport_ops nvme_fc_transport = {
 
 static int __init nvme_fc_init_module(void)
 {
+	int ret;
+
 	nvme_fc_wq = create_workqueue("nvme_fc_wq");
 	if (!nvme_fc_wq)
 		return -ENOMEM;
 
-	return nvmf_register_transport(&nvme_fc_transport);
+	ret = nvmf_register_transport(&nvme_fc_transport);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	destroy_workqueue(nvme_fc_wq);
+	return ret;
 }
 
 static void __exit nvme_fc_exit_module(void)
-- 
2.7.4
