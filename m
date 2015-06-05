From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  5 Jun 2015 14:54:24 +0200
Subject: [PATCH v4 2/8] nvme: don't overwrite req->cmd_flags on sync cmd
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <1433508870-28251-3-git-send-email-m@bjorling.me>

In __nvme_submit_sync_cmd, the request direction is overwritten when
the REQ_FAILFAST_DRIVER flag is set.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/nvme-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d2955fe..6e433b1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1010,7 +1010,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
-	req->cmd_flags = REQ_FAILFAST_DRIVER;
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	req->__data_len = 0;
 	req->__sector = (sector_t) -1;
 	req->bio = req->biotail = NULL;
-- 
2.1.4
