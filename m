From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 20 Apr 2017 15:04:40 -0700
Subject: ["PATCH-v2" 14/22] Remove hba lock from NVMET issue WQE.
In-Reply-To: <20170420220448.27095-1-jsmart2021@gmail.com>
References: <20170420220448.27095-1-jsmart2021@gmail.com>
Message-ID: <20170420220448.27095-15-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Unnecessary lock is taken. ring lock should be sufficient to protect the
work queue submission.

This was noticed when doing performance testing. The hbalock is not
needed to issue io to the nvme work queue.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index c8a4941..5a994a8 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -517,7 +517,6 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.fcp_req);
 	struct lpfc_hba *phba = ctxp->phba;
 	struct lpfc_iocbq *nvmewqeq;
-	unsigned long iflags;
 	int rc, id;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
@@ -571,10 +570,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	lpfc_nvmeio_data(phba, "NVMET FCP CMND: xri x%x op x%x len x%x\n",
 			 ctxp->oxid, rsp->op, rsp->rsplen);
 
-	/* For now we take hbalock */
-	spin_lock_irqsave(&phba->hbalock, iflags);
 	rc = lpfc_sli4_issue_wqe(phba, LPFC_FCP_RING, nvmewqeq);
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	if (rc == WQE_SUCCESS) {
 		ctxp->flag |= LPFC_NVMET_IO_INP;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-- 
2.9.3
