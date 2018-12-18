From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 17 Dec 2018 18:35:29 -0800
Subject: [PATCH] nvmet: use a macro for default error location
Message-ID: <20181218023529.4355-1-chaitanya.kulkarni@wdc.com>

This patch defines a new macro NVMET_NO_ERROR_LOC to represent the
default error location value in the nvme-error-log-page.
This is a pure cleanup patch and it does not change any functionality.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 4 ++--
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b9c219c931eb..88d260f31835 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -663,7 +663,7 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 
 	req->rsp->status = cpu_to_le16(status << 1);
 
-	if (!ctrl || req->error_loc == (u16)-1)
+	if (!ctrl || req->error_loc == NVMET_NO_ERROR_LOC)
 		return;
 
 	spin_lock_irqsave(&ctrl->error_lock, flags);
@@ -849,7 +849,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->rsp->status = 0;
 	req->rsp->sq_head = 0;
 	req->ns = NULL;
-	req->error_loc = -1;
+	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 
 	/* no support for fused commands yet */
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3b5f0bcaf3e8..3e4719fdba85 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -30,6 +30,7 @@
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
+#define NVMET_NO_ERROR_LOC		((u16)-1)
 
 /*
  * Supported optional AENs:
-- 
2.17.0
