From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  2 Nov 2017 18:07:44 +0900
Subject: [PATCH] nvme: comment typo fixed in clearing AER
Message-ID: <1509613664-25006-1-git-send-email-minwoo.im.dev@gmail.com>

a tiny typo fixed in a comment.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07b9f4e..6474435 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2637,7 +2637,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 		return;
 
 	nvme_start_queues(ctrl);
-	/* read FW slot informationi to clear the AER*/
+	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
 }
 
-- 
2.7.4
