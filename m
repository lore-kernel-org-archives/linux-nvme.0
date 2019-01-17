From: emilne@redhat.com (Ewan D. Milne)
Date: Thu, 17 Jan 2019 11:14:45 -0500
Subject: [PATCH 2/2] lpfc: nvmet: avoid hang / use-after-free when destroying
 targetport
In-Reply-To: <20190117161445.25671-1-emilne@redhat.com>
References: <20190117161445.25671-1-emilne@redhat.com>
Message-ID: <20190117161445.25671-3-emilne@redhat.com>

We cannot wait on a completion object in the lpfc_nvme_targetport structure
in the _destroy_targetport() code path because the NVMe/fc transport will
free that structure immediately after the .targetport_delete() callback.
This results in a use-after-free, and a hang if slub_debug=FZPU is enabled.

Fix this by putting the completion on the stack.

Signed-off-by: Ewan D. Milne <emilne at redhat.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 8 +++++---
 drivers/scsi/lpfc/lpfc_nvmet.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 6245f44..95fee83 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1003,7 +1003,8 @@ lpfc_nvmet_targetport_delete(struct nvmet_fc_target_port *targetport)
 	struct lpfc_nvmet_tgtport *tport = targetport->private;
 
 	/* release any threads waiting for the unreg to complete */
-	complete(&tport->tport_unreg_done);
+	if (tport->phba->targetport)
+		complete(tport->tport_unreg_cmp);
 }
 
 static void
@@ -1692,6 +1693,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct lpfc_queue *wq;
 	uint32_t qidx;
+	DECLARE_COMPLETION_ONSTACK(tport_unreg_cmp);
 
 	if (phba->nvmet_support == 0)
 		return;
@@ -1701,9 +1703,9 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 			wq = phba->sli4_hba.nvme_wq[qidx];
 			lpfc_nvmet_wqfull_flush(phba, wq, NULL);
 		}
-		init_completion(&tgtp->tport_unreg_done);
+		tgtp->tport_unreg_cmp = &tport_unreg_cmp;
 		nvmet_fc_unregister_targetport(phba->targetport);
-		wait_for_completion_timeout(&tgtp->tport_unreg_done, 5);
+		wait_for_completion_timeout(&tport_unreg_cmp, 5);
 		lpfc_nvmet_cleanup_io_context(phba);
 	}
 	phba->targetport = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
index 1aaff63..0ec1082 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.h
+++ b/drivers/scsi/lpfc/lpfc_nvmet.h
@@ -34,7 +34,7 @@
 /* Used for NVME Target */
 struct lpfc_nvmet_tgtport {
 	struct lpfc_hba *phba;
-	struct completion tport_unreg_done;
+	struct completion *tport_unreg_cmp;
 
 	/* Stats counters - lpfc_nvmet_unsol_ls_buffer */
 	atomic_t rcv_ls_req_in;
-- 
2.1.0
