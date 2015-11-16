From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:47 +0100
Subject: [PATCH 13/13] lightnvm: cleanup queue before target removal
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-14-git-send-email-m@bjorling.me>

From: Javier Gonz?lez <javier@javigon.com>

This prevents outstanding IOs to be sent for completion to target after
the target has been removed. The flow is now: stop new IOs > cleanup
queue > remove target.

Signed-off-by: Javier Gonzalez <javier at cnexlabs.com>
Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/lightnvm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 790b1d7..8a556f3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -460,11 +460,11 @@ static void nvm_remove_target(struct nvm_target *t)
 	lockdep_assert_held(&nvm_lock);
 
 	del_gendisk(tdisk);
+	blk_cleanup_queue(q);
+
 	if (tt->exit)
 		tt->exit(tdisk->private_data);
 
-	blk_cleanup_queue(q);
-
 	put_disk(tdisk);
 
 	list_del(&t->list);
-- 
2.1.4
