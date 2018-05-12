From: jsmart2021@gmail.com (James Smart)
Date: Fri, 11 May 2018 17:50:24 -0700
Subject: [PATCH v2 3/7] nvme_fc: remove setting DNR on exception conditions
In-Reply-To: <20180512005028.29661-1-jsmart2021@gmail.com>
References: <20180512005028.29661-1-jsmart2021@gmail.com>
Message-ID: <20180512005028.29661-4-jsmart2021@gmail.com>

Current code will set DNR if the controller is deleting or there is
an error during controller init. None of this is necessary.

remove the code that sets DNR

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6cb26bcf6ec0..7e64fe69c945 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1686,16 +1686,6 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		goto check_error;
 	}
 
-	/*
-	 * Force failures of commands if we're killing the controller
-	 * or have an error on a command used to create an new association
-	 */
-	if (status &&
-	    (blk_queue_dying(rq->q) ||
-	     ctrl->ctrl.state == NVME_CTRL_NEW ||
-	     ctrl->ctrl.state == NVME_CTRL_CONNECTING))
-		status |= cpu_to_le16(NVME_SC_DNR << 1);
-
 	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
 	nvme_end_request(rq, status, result);
 
-- 
2.13.1
