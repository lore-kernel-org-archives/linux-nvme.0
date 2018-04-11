From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 11 Apr 2018 16:07:03 +0000
Subject: [PATCH 1/2 v3] nvme-rdma: Fix race between queue timeout and error
 recovery
In-Reply-To: <1523462824-25643-1-git-send-email-israelr@mellanox.com>
References: <1523462824-25643-1-git-send-email-israelr@mellanox.com>
Message-ID: <1523462824-25643-2-git-send-email-israelr@mellanox.com>

When returning BLK_EH_HANDLED from nvme_rdma_timeout() the block layer
complete the request.
Returning BLK_EH_RESET_TIMER is safe because those requests will be completed
later by nvme abort mechanism.

Completing the requests in the timeout handler was done while
the rdma queues were active.
When completing the request we return its mr to the mr pool (set mr to NULL)
and also unmap its data.
This leads to a NULL deref of the mr if we get a rdma completion of a
completed request.
This also lead to unmapping the request data before it is really safe.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 758537e..c1abfc8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1595,10 +1595,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	/* queue error recovery */
 	nvme_rdma_error_recovery(req->queue->ctrl);
 
-	/* fail with DNR on cmd timeout */
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
-
-	return BLK_EH_HANDLED;
+	return BLK_EH_RESET_TIMER;
 }
 
 /*
-- 
1.8.3.1
