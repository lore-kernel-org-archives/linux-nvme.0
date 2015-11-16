From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:43 +0100
Subject: [PATCH 09/13] lightnvm: prevent double free on init error
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-10-git-send-email-m@bjorling.me>

Both the nvm_register and nvm_init does a kfree(dev) on error. Make sure
to only free it once.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/lightnvm/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 40e6cfa..899f6b9 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -160,11 +160,6 @@ int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk)
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
-static void nvm_core_free(struct nvm_dev *dev)
-{
-	kfree(dev);
-}
-
 static int nvm_core_init(struct nvm_dev *dev)
 {
 	struct nvm_id *id = &dev->identity;
@@ -223,8 +218,6 @@ static void nvm_free(struct nvm_dev *dev)
 
 	if (dev->mt)
 		dev->mt->unregister_mgr(dev);
-
-	nvm_core_free(dev);
 }
 
 static int nvm_init(struct nvm_dev *dev)
@@ -351,11 +344,12 @@ void nvm_unregister(char *disk_name)
 		return;
 	}
 
-	nvm_exit(dev);
-
 	down_write(&nvm_lock);
 	list_del(&dev->devices);
 	up_write(&nvm_lock);
+
+	nvm_exit(dev);
+	kfree(dev);
 }
 EXPORT_SYMBOL(nvm_unregister);
 
-- 
2.1.4
