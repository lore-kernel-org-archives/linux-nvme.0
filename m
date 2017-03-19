From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Mar 2017 06:29:12 +0200
Subject: [PATCH 2/2] nvme-loop: fix module_init (theoretical) error path
In-Reply-To: <1489897752-16691-1-git-send-email-sagi@grimberg.me>
References: <1489897752-16691-1-git-send-email-sagi@grimberg.me>
Message-ID: <1489897752-16691-2-git-send-email-sagi@grimberg.me>

if nvmf_register_transport happend to fail, we
need to nvmet_unregister_transport as well.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 22f7bc6bac7f..7053676aa87f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -736,7 +736,12 @@ static int __init nvme_loop_init_module(void)
 	ret = nvmet_register_transport(&nvme_loop_ops);
 	if (ret)
 		return ret;
-	return nvmf_register_transport(&nvme_loop_transport);
+
+	ret = nvmf_register_transport(&nvme_loop_transport);
+	if (ret)
+		nvmet_unregister_transport(&nvme_loop_ops);
+
+	return ret;
 }
 
 static void __exit nvme_loop_cleanup_module(void)
-- 
2.7.4
