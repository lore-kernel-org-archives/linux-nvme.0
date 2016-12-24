From: jsmart2021@gmail.com (James Smart)
Date: Sat, 24 Dec 2016 09:46:44 -0800
Subject: [PATCH] nvmet_fc: cleanup of abort flag processing in fcp_op_done
Message-ID: <585eb484.M7R72sCIYQYXrRlx%jsmart2021@gmail.com>


Cleanup of abort flag processing in fcp_op_done.
References were unnecessary

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 90cd652..2c0709f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1824,16 +1824,14 @@ nvmet_fc_xmt_fcp_op_done(struct nvmefc_tgt_fcp_req *fcpreq)
 		/* data no longer needed */
 		nvmet_fc_free_tgt_pgs(fod);
 
-		if (fcpreq->fcp_error || abort)
-			nvmet_req_complete(&fod->req, fcpreq->fcp_error);
-
+		nvmet_req_complete(&fod->req, fcpreq->fcp_error);
 		return;
 	}
 
 	switch (fcpreq->op) {
 
 	case NVMET_FCOP_WRITEDATA:
-		if (abort || fcpreq->fcp_error ||
+		if (fcpreq->fcp_error ||
 		    fcpreq->transferred_length != fcpreq->transfer_length) {
 			nvmet_req_complete(&fod->req,
 					NVME_SC_FC_TRANSPORT_ERROR);
@@ -1856,7 +1854,7 @@ nvmet_fc_xmt_fcp_op_done(struct nvmefc_tgt_fcp_req *fcpreq)
 
 	case NVMET_FCOP_READDATA:
 	case NVMET_FCOP_READDATA_RSP:
-		if (abort || fcpreq->fcp_error ||
+		if (fcpreq->fcp_error ||
 		    fcpreq->transferred_length != fcpreq->transfer_length) {
 			/* data no longer needed */
 			nvmet_fc_free_tgt_pgs(fod);
-- 
2.5.0
