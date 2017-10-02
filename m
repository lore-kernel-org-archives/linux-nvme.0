From: hare@suse.de (Hannes Reinecke)
Date: Mon,  2 Oct 2017 15:55:59 +0200
Subject: [PATCH 6/6] nvme: ignore retries for multipath devices
In-Reply-To: <1506952559-1588-1-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
Message-ID: <1506952559-1588-7-git-send-email-hare@suse.de>

For multipath devices we should switch paths after the retries
are exhausted, and not return an error.
IE we should first retry on the current path, and then switch
paths once the retries are exhausted.
Once all paths are down and all retries are exhausted we will
still retry the command, but then it'll be handled with the
all paths down logic in nvme_make_request().

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1ef11ca..ac7676a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -201,7 +201,8 @@ static inline bool nvme_req_needs_retry(struct request *req)
 		return false;
 	if (nvme_req(req)->status & NVME_SC_DNR)
 		return false;
-	if (nvme_req(req)->retries >= nvme_max_retries)
+	if (nvme_req(req)->retries >= nvme_max_retries &&
+	    !(req->cmd_flags & REQ_NVME_MPATH))
 		return false;
 	return true;
 }
-- 
1.8.5.6
