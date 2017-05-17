From: jsmart2021@gmail.com (James Smart)
Date: Tue, 16 May 2017 20:52:29 -0700
Subject: [PATCH] lpfc: fix build issue if NVME_FC_TARGET is not defined
Message-ID: <20170517035229.1145-1-jsmart2021@gmail.com>

fix build issue if NVME_FC_TARGET is not defined. noop the code.
The code will never be invoked if target mode is not enabled.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 312f54278bd4..f94294b77b7b 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -157,6 +157,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 void
 lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 {
+#if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
 	struct lpfc_nvmet_rcv_ctx *ctxp = ctx_buf->context;
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct fc_frame_header *fc_hdr;
@@ -260,6 +261,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 		      &phba->sli4_hba.lpfc_nvmet_ctx_list);
 	phba->sli4_hba.nvmet_ctx_cnt++;
 	spin_unlock_irqrestore(&phba->sli4_hba.nvmet_io_lock, iflag);
+#endif
 }
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-- 
2.11.0
