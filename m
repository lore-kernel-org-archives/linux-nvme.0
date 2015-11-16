From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:42 +0100
Subject: [PATCH 08/13] lightnvm: prematurely activate nvm_dev
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-9-git-send-email-m@bjorling.me>

We register with nvm_devices when there registration can still fail.
Move the final registration at the end of the nvm_register function
to make sure we are fully registered when added to the nvm_devices list.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/lightnvm/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 0985a03..40e6cfa 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -318,10 +318,6 @@ int nvm_register(struct request_queue *q, char *disk_name,
 	if (ret)
 		goto err_init;
 
-	down_write(&nvm_lock);
-	list_add(&dev->devices, &nvm_devices);
-	up_write(&nvm_lock);
-
 	if (dev->ops->max_phys_sect > 1) {
 		dev->ppalist_pool = dev->ops->create_dma_pool(dev->q,
 								"ppalist");
@@ -334,6 +330,10 @@ int nvm_register(struct request_queue *q, char *disk_name,
 		return -EINVAL;
 	}
 
+	down_write(&nvm_lock);
+	list_add(&dev->devices, &nvm_devices);
+	up_write(&nvm_lock);
+
 	return 0;
 err_init:
 	kfree(dev);
-- 
2.1.4
