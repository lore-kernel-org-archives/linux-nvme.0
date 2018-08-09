From: mgandhi@redhat.com (Milan P. Gandhi)
Date: Thu, 9 Aug 2018 19:06:06 +0530
Subject: [PATCH] Simplify nvmet_init to remove extra out label
Message-ID: <20180809133606.GA11730@machine1>

The 2nd out label at end could easily be removed by returning
an error upon receiving a non-zero error return code from
nvmet_init_discovery. This would avoid need for 2nd out
label.

Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>
---
 drivers/nvme/target/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b40fb6d724b4..e667a3fa0d9b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1109,7 +1109,7 @@ static int __init nvmet_init(void)
 
 	error = nvmet_init_discovery();
 	if (error)
-		goto out;
+		return error;
 
 	error = nvmet_init_configfs();
 	if (error)
@@ -1118,7 +1118,6 @@ static int __init nvmet_init(void)
 
 out_exit_discovery:
 	nvmet_exit_discovery();
-out:
 	return error;
 }
 
-- 
2.14.3
