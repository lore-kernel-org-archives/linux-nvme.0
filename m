From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:41:24 -0700
Subject: [PATCH 3/6] nvmet_fc: Sync NVME LS reject reasons with spec
In-Reply-To: <20170324034127.8676-1-jsmart2021@gmail.com>
References: <20170324034127.8676-1-jsmart2021@gmail.com>
Message-ID: <20170324034127.8676-4-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

nvmet_fc: Sync NVME LS reject reasons with spec

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/fc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8f483ee..3a0f22e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1189,8 +1189,8 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 			validation_errors[ret]);
 		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
-				ELS_RJT_LOGIC,
-				ELS_EXPL_NONE, 0);
+				FCNVME_RJT_RC_LOGIC,
+				FCNVME_RJT_EXP_NONE, 0);
 		return;
 	}
 
@@ -1281,8 +1281,9 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
-						ELS_RJT_PROT : ELS_RJT_LOGIC,
-				ELS_EXPL_NONE, 0);
+					FCNVME_RJT_RC_INV_ASSOC :
+					FCNVME_RJT_RC_LOGIC,
+				FCNVME_RJT_EXP_NONE, 0);
 		return;
 	}
 
@@ -1369,8 +1370,12 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			validation_errors[ret]);
 		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
-				(ret == 8) ? ELS_RJT_PROT : ELS_RJT_LOGIC,
-				ELS_EXPL_NONE, 0);
+				(ret == VERR_NO_ASSOC) ?
+					FCNVME_RJT_RC_INV_ASSOC :
+					(ret == VERR_NO_CONN) ?
+						FCNVME_RJT_RC_INV_CONN :
+						FCNVME_RJT_RC_LOGIC,
+				FCNVME_RJT_EXP_NONE, 0);
 		return;
 	}
 
@@ -1479,7 +1484,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 	default:
 		iod->lsreq->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
 				NVME_FC_MAX_LS_BUFFER_SIZE, w0->ls_cmd,
-				ELS_RJT_INVAL, ELS_EXPL_NONE, 0);
+				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
 	}
 
 	nvmet_fc_xmt_ls_rsp(tgtport, iod);
-- 
2.9.3
