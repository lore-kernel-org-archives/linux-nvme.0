From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:35 -0800
Subject: [PATCH 15/20] lpfc: correct double print
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-16-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Correct a merge error that had debug data printed twice for the
same element

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 9f4798e..913eed82 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -3653,17 +3653,6 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 			idiag.ptr_private = phba->sli4_hba.nvmels_cq;
 			goto pass_check;
 		}
-		/* NVME LS complete queue */
-		if (phba->sli4_hba.nvmels_cq &&
-		    phba->sli4_hba.nvmels_cq->queue_id == queid) {
-			/* Sanity check */
-			rc = lpfc_idiag_que_param_check(
-					phba->sli4_hba.nvmels_cq, index, count);
-			if (rc)
-				goto error_out;
-			idiag.ptr_private = phba->sli4_hba.nvmels_cq;
-			goto pass_check;
-		}
 		/* FCP complete queue */
 		if (phba->sli4_hba.fcp_cq) {
 			for (qidx = 0; qidx < phba->cfg_fcp_io_channel;
@@ -3738,17 +3727,6 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 			idiag.ptr_private = phba->sli4_hba.nvmels_wq;
 			goto pass_check;
 		}
-		/* NVME LS work queue */
-		if (phba->sli4_hba.nvmels_wq &&
-		    phba->sli4_hba.nvmels_wq->queue_id == queid) {
-			/* Sanity check */
-			rc = lpfc_idiag_que_param_check(
-					phba->sli4_hba.nvmels_wq, index, count);
-			if (rc)
-				goto error_out;
-			idiag.ptr_private = phba->sli4_hba.nvmels_wq;
-			goto pass_check;
-		}
 		/* FCP work queue */
 		if (phba->sli4_hba.fcp_wq) {
 			for (qidx = 0; qidx < phba->cfg_fcp_io_channel;
-- 
2.5.0
