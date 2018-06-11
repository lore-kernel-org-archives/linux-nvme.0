From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 03:20:24 -0400
Subject: [PATCH] nvmet: free smart-log buffer after use
Message-ID: <20180611072024.485-1-chaitanya.kulkarni@wdc.com>

Free smart-log buffer allocated in the function after use.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 962532842769..ce43c3aaf715 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -118,10 +118,10 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 		status = nvmet_get_smart_log_all(req, log);
 	else
 		status = nvmet_get_smart_log_nsid(req, log);
-	if (status)
-		goto out;
+	if (status == NVME_SC_SUCCESS)
+		status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
-	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	kfree(log);
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.17.0
