From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:26 -0800
Subject: [PATCH 06/20] lpfc: Fix RCTL value on NVME LS request and response
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-7-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

NVME LS requests and responses had wrong R_CTL values.
Use the FC4 ELS Request and Response defines (defines badly
named, they are FC4 LS's) instead of the base ELS values.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c  | 2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 609a908..6346d4d 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -316,7 +316,7 @@ lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 	bf_set(wqe_dfctl, &wqe->gen_req.wge_ctl, 0);
 	bf_set(wqe_si, &wqe->gen_req.wge_ctl, 1);
 	bf_set(wqe_la, &wqe->gen_req.wge_ctl, 1);
-	bf_set(wqe_rctl, &wqe->gen_req.wge_ctl, FC_RCTL_DD_UNSOL_CTL);
+	bf_set(wqe_rctl, &wqe->gen_req.wge_ctl, FC_RCTL_ELS4_REQ);
 	bf_set(wqe_type, &wqe->gen_req.wge_ctl, FC_TYPE_NVME);
 
 	/* Word 6 */
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index e59a0a8..6c2221a 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1114,7 +1114,7 @@ lpfc_nvmet_prep_ls_wqe(struct lpfc_hba *phba,
 	bf_set(wqe_dfctl, &wqe->xmit_sequence.wge_ctl, 0);
 	bf_set(wqe_ls, &wqe->xmit_sequence.wge_ctl, 1);
 	bf_set(wqe_la, &wqe->xmit_sequence.wge_ctl, 0);
-	bf_set(wqe_rctl, &wqe->xmit_sequence.wge_ctl, FC_RCTL_DD_SOL_CTL);
+	bf_set(wqe_rctl, &wqe->xmit_sequence.wge_ctl, FC_RCTL_ELS4_REP);
 	bf_set(wqe_type, &wqe->xmit_sequence.wge_ctl, FC_TYPE_NVME);
 
 	/* Word 6 */
-- 
2.5.0
