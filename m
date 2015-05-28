From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 May 2015 09:48:55 -0600
Subject: [PATCH 2/2] NVMe: End sync requests immediately on failure
In-Reply-To: <1432828135-31724-1-git-send-email-keith.busch@intel.com>
References: <1432828135-31724-1-git-send-email-keith.busch@intel.com>
Message-ID: <1432828135-31724-2-git-send-email-keith.busch@intel.com>

Do not retry failed sync commands so the original status may be seen
without issuing unnecessary retries.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 4eb9917..6ed1356 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1010,6 +1010,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
+	req->cmd_flags = REQ_FAILFAST_DRIVER;
 	req->__data_len = 0;
 	req->__sector = (sector_t) -1;
 	req->bio = req->biotail = NULL;
-- 
1.7.10.4
