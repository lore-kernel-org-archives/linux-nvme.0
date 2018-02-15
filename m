From: jpittman@redhat.com (John Pittman)
Date: Thu, 15 Feb 2018 15:42:58 -0500
Subject: [PATCH] nvme: Use __func__ macro in place of function name
Message-ID: <1518727378-23194-1-git-send-email-jpittman@redhat.com>

Function nvme_keep_alive_end_io() refers to itself in in a call
to dev_err().  It does so using the actual function name in the
error message.  This should be replaced by a call to the __func__
macro.  Using the macro will prevent future potential risk of
the function name changing and failure to change the associated
error message.  This issue was exposed by checkpatch.pl.

Signed-off-by: John Pittman <jpittman at redhat.com>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f431c32..95402a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -784,8 +784,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 
 	if (status) {
 		dev_err(ctrl->device,
-			"failed nvme_keep_alive_end_io error=%d\n",
-				status);
+			"failed %s error=%d\n", __func__, status);
 		return;
 	}
 
-- 
2.7.5
