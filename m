From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 20 Apr 2017 15:04:47 -0700
Subject: ["PATCH-v2" 21/22] Fix Express lane queue creation.
In-Reply-To: <20170420220448.27095-1-jsmart2021@gmail.com>
References: <20170420220448.27095-1-jsmart2021@gmail.com>
Message-ID: <20170420220448.27095-22-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

The older sli4 adapters only supported the 64 byte WQE entry size.
The new adapter (fw) support both 64 and 128 byte WQE entry sizies.
The Express lane WQ was not being created with the 128 byte WQE sizes
when it was supported.

Not having the right WQE size created for the express lane work queue
caused the the firmware to overwrite the lun indentifier in the FCP header.

This patch correctly creates the express lane work queue with the
supported size.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/scsi/lpfc/lpfc_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 74cec22..90ae354 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12040,6 +12040,7 @@ int
 lpfc_fof_queue_create(struct lpfc_hba *phba)
 {
 	struct lpfc_queue *qdesc;
+	uint32_t wqesize;
 
 	/* Create FOF EQ */
 	qdesc = lpfc_sli4_queue_alloc(phba, phba->sli4_hba.eq_esize,
@@ -12060,8 +12061,11 @@ lpfc_fof_queue_create(struct lpfc_hba *phba)
 		phba->sli4_hba.oas_cq = qdesc;
 
 		/* Create OAS WQ */
-		qdesc = lpfc_sli4_queue_alloc(phba, phba->sli4_hba.wq_esize,
+		wqesize = (phba->fcp_embed_io) ?
+				LPFC_WQE128_SIZE : phba->sli4_hba.wq_esize;
+		qdesc = lpfc_sli4_queue_alloc(phba, wqesize,
 					      phba->sli4_hba.wq_ecount);
+
 		if (!qdesc)
 			goto out_error;
 
-- 
2.9.3
