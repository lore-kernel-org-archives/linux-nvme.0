From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Sep 2017 16:14:45 -0700
Subject: [PATCH 1/9] nvme: allow timed-out ios to retry
In-Reply-To: <20170918231453.27128-1-hch@lst.de>
References: <20170918231453.27128-1-hch@lst.de>
Message-ID: <20170918231453.27128-2-hch@lst.de>

From: James Smart <jsmart2021@gmail.com>

Currently the nvme_req_needs_retry() applies several checks to see if
a retry is allowed. On of those is whether the current time has exceeded
the start time of the io plus the timeout length. This check, if an io
times out, means there is never a retry allowed for the io. Which means
applications see the io failure.

Remove this check and allow the io to timeout, like it does on other
protocols, and retries to be made.

On the FC transport, a frame can be lost for an individual io, and there
may be no other errors that escalate for the connection/association.
The io will timeout, which causes the transport to escalate into creating
a new association, but the io that timed out, due to this retry logic, has
already failed back to the application and things are hosed.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d470f031e27f..5589f67d2cd8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -134,8 +134,6 @@ static inline bool nvme_req_needs_retry(struct request *req)
 		return false;
 	if (nvme_req(req)->status & NVME_SC_DNR)
 		return false;
-	if (jiffies - req->start_time >= req->timeout)
-		return false;
 	if (nvme_req(req)->retries >= nvme_max_retries)
 		return false;
 	return true;
-- 
2.14.1
