From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 16:27:27 -0700
Subject: [PATCH 3/5] nvmet-fc: remove use of FC-specific error codes
In-Reply-To: <20170907232729.28763-1-jsmart2021@gmail.com>
References: <20170907232729.28763-1-jsmart2021@gmail.com>
Message-ID: <20170907232729.28763-4-jsmart2021@gmail.com>

The FC-NVME target transport used the FC-specific error codes in
return codes when the transport or lldd failed. Instead of using the
FC-specific values, now use a generic value (NVME_SC_INTERNAL).

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 421e43bf1dd7..088f07250d76 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1910,8 +1910,7 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
 			spin_lock_irqsave(&fod->flock, flags);
 			fod->writedataactive = false;
 			spin_unlock_irqrestore(&fod->flock, flags);
-			nvmet_req_complete(&fod->req,
-					NVME_SC_FC_TRANSPORT_ERROR);
+			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 		} else /* NVMET_FCOP_READDATA or NVMET_FCOP_READDATA_RSP */ {
 			fcpreq->fcp_error = ret;
 			fcpreq->transferred_length = 0;
@@ -1929,8 +1928,7 @@ __nvmet_fc_fod_op_abort(struct nvmet_fc_fcp_iod *fod, bool abort)
 	/* if in the middle of an io and we need to tear down */
 	if (abort) {
 		if (fcpreq->op == NVMET_FCOP_WRITEDATA) {
-			nvmet_req_complete(&fod->req,
-					NVME_SC_FC_TRANSPORT_ERROR);
+			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 			return true;
 		}
 
@@ -1968,8 +1966,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 			fod->abort = true;
 			spin_unlock(&fod->flock);
 
-			nvmet_req_complete(&fod->req,
-					NVME_SC_FC_TRANSPORT_ERROR);
+			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 			return;
 		}
 
-- 
2.13.1
