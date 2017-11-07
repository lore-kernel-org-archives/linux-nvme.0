From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue,  7 Nov 2017 21:10:22 +0900
Subject: [PATCH] nvmet: fix comment typos in admin-cmd.c
Message-ID: <1510056622-21186-1-git-send-email-minwoo.im.dev@gmail.com>

small typos fixed in admin-cmd.c

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c4a0bf3..9a7d691 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -300,7 +300,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	/*
-	 * nuse = ncap = nsze isn't aways true, but we have no way to find
+	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
 	 */
 	id->ncap = id->nuse = id->nsze =
@@ -424,7 +424,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 }
 
 /*
- * A "mimimum viable" abort implementation: the command is mandatory in the
+ * A "minimum viable" abort implementation: the command is mandatory in the
  * spec, but we are not required to do any useful work.  We couldn't really
  * do a useful abort, so don't bother even with waiting for the command
  * to be exectuted and return immediately telling the command to abort
-- 
2.7.4
