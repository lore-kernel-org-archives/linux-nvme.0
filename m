From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu,  7 Jun 2018 02:35:01 -0400
Subject: [PATCH] nvme-core: fix nvme_setup_cmd trace call
Message-ID: <20180607063501.4361-1-chaitanya.kulkarni@wdc.com>

This patch fixes the trace_nvme_setup_admin_cmd() call, now we use NULL
in place of ns->disk->disk_name when ns variable is NULL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3250f8d72456..6ac682b67e15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -655,7 +655,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	if (ns)
 		trace_nvme_setup_nvm_cmd(ns->disk->disk_name, req->q->id, cmd);
 	else
-		trace_nvme_setup_admin_cmd(ns->disk->disk_name, cmd);
+		trace_nvme_setup_admin_cmd(NULL, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
-- 
2.17.0
