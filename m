From: colin.king@canonical.com (Colin King)
Date: Fri, 14 Dec 2018 18:31:21 +0000
Subject: [PATCH][next] nvmet: fix comparison of a u16 with -1
Message-ID: <20181214183121.17445-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

Currently the u16 req->error_loc is being compared to -1 which
will always be false.  Fix this by casting -1 to u16 to fix this.

Detected by clang:
  warning: result of comparison of constant -1 with expression of
  type 'u16' (aka 'unsigned short') is always false
  [-Wtautological-constant-out-of-range-compare]

Fixes: 76574f37bf4c ("nvmet: add interface to update error-log page")
Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cc81d0231587..b9c219c931eb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -663,7 +663,7 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 
 	req->rsp->status = cpu_to_le16(status << 1);
 
-	if (!ctrl || req->error_loc == -1)
+	if (!ctrl || req->error_loc == (u16)-1)
 		return;
 
 	spin_lock_irqsave(&ctrl->error_lock, flags);
-- 
2.19.1
