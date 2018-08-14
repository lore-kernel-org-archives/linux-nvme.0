From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 14 Aug 2018 14:34:30 -0700
Subject: [PATCH] nvmet: free workqueue object if module init fails
Message-ID: <20180814213430.4096-1-chaitanya.kulkarni@wdc.com>

This patch frees the buffered_io_wq workqueue object when module init
fails to complete the initialization.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 14b4c4916a8e..4b9758f13a83 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1220,6 +1220,8 @@ static int __init nvmet_init(void)
 out_exit_discovery:
 	nvmet_exit_discovery();
 out:
+	if (buffered_io_wq)
+		destroy_workqueue(buffered_io_wq);
 	return error;
 }
 
-- 
2.17.0
