From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 May 2015 09:48:54 -0600
Subject: [PATCH 1/2] NVMe: Use requested sync command timeout
Message-ID: <1432828135-31724-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c42bc53..4eb9917 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1014,7 +1014,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	req->__sector = (sector_t) -1;
 	req->bio = req->biotail = NULL;
 
-	req->timeout = ADMIN_TIMEOUT;
+	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
 
 	req->cmd = (unsigned char *)cmd;
 	req->cmd_len = sizeof(struct nvme_command);
-- 
1.7.10.4
