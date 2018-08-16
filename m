From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 18:48:25 -0700
Subject: [PATCH V2] nvmet: free workqueue object if module init fails
Message-ID: <20180816014825.13762-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V1:-

1. Add a separate goto for freeing workqueue.

---
 drivers/nvme/target/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4b9758f13a83..dfd214390163 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1210,7 +1210,7 @@ static int __init nvmet_init(void)
 
 	error = nvmet_init_discovery();
 	if (error)
-		goto out;
+		goto out_free_work_queue;
 
 	error = nvmet_init_configfs();
 	if (error)
@@ -1219,9 +1219,11 @@ static int __init nvmet_init(void)
 
 out_exit_discovery:
 	nvmet_exit_discovery();
+
+out_free_work_queue:
+	destroy_workqueue(buffered_io_wq);
+
 out:
-	if (buffered_io_wq)
-		destroy_workqueue(buffered_io_wq);
 	return error;
 }
 
-- 
2.17.0
