From: keith.busch@intel.com (Keith Busch)
Date: Mon,  8 Jun 2015 10:08:14 -0600
Subject: [PATCH 2/3] NVMe: Don't use fake status on cancelled command
In-Reply-To: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
Message-ID: <1433779695-15866-3-git-send-email-keith.busch@intel.com>

Synchronized commands do different things for timed out commands
vs. controller returned errors.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8513321..52742d4 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -613,7 +613,10 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 			return;
 		}
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-			req->errors = status;
+			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
+				req->errors = -EINTR;
+			else
+				req->errors = status;
 		} else {
 			req->errors = nvme_error_status(status);
 		}
-- 
1.7.10.4
