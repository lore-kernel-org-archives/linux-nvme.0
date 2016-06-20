From: jonathan.derrick@intel.com (Jon Derrick)
Date: Mon, 20 Jun 2016 12:10:25 -0600
Subject: [PATCH] nvme: Unroll nvme_req_needs_retry
Message-ID: <1466446225-29649-1-git-send-email-jonathan.derrick@intel.com>

nvme_req_needs_retry is becoming unreadable, so let's roll it out.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
Depends on "nvme: Limit command retries":
http://lists.infradead.org/pipermail/linux-nvme/2016-June/005114.html

 drivers/nvme/host/nvme.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8ab141d..bf06793 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -205,9 +205,13 @@ static inline int nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 {
-	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
-		(jiffies - req->start_time) < req->timeout &&
-		req->retries < nvme_max_retries;
+	if (status & NVME_SC_DNR || blk_noretry_request(req))
+		return false;
+	if ((jiffies - req->start_time) >= req->timeout)
+		return false;
+	if (req->retries >= nvme_max_retries)
+		return false;
+	return true;
 }
 
 void nvme_cancel_request(struct request *req, void *data, bool reserved);
-- 
1.8.3.1
