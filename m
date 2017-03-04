From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:28 -0800
Subject: [PATCH 08/20] lpfc: Fix IO submission if WQ is full
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-9-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

For both initiator and target: if WQ is full, return -EBUSY.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c  | 2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index bf3ccc5..e1bf31e 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1310,7 +1310,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 				 "sid: x%x did: x%x oxid: x%x\n",
 				 ret, vport->fc_myDID, ndlp->nlp_DID,
 				 lpfc_ncmd->cur_iocbq.sli4_xritag);
-		ret = -EINVAL;
+		ret = -EBUSY;
 		goto out_free_nvme_buf;
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 6c2221a..735e2ba 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -571,6 +571,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6102 Bad state IO x%x aborted\n",
 				ctxp->oxid);
+		rc = -ENXIO;
 		goto aerr;
 	}
 
@@ -580,6 +581,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6152 FCP Drop IO x%x: Prep\n",
 				ctxp->oxid);
+		rc = -ENXIO;
 		goto aerr;
 	}
 
@@ -618,8 +620,9 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	ctxp->wqeq->hba_wqidx = 0;
 	nvmewqeq->context2 = NULL;
 	nvmewqeq->context3 = NULL;
+	rc = -EBUSY;
 aerr:
-	return -ENXIO;
+	return rc;
 }
 
 static void
-- 
2.5.0
