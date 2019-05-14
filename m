From: jsmart2021@gmail.com (James Smart)
Date: Tue, 14 May 2019 14:58:06 -0700
Subject: [PATCH v2 5/7] lpfc: add nvmet discovery_event op support
In-Reply-To: <20190514215808.10572-1-jsmart2021@gmail.com>
References: <20190514215808.10572-1-jsmart2021@gmail.com>
Message-ID: <20190514215808.10572-6-jsmart2021@gmail.com>

This patch adds support for the nvmet discovery op. When the callback
routine is called, the driver will call the routine to generate an RSCN
to the port on the other end of the link.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 361e2b103648..1eb02a0b8db6 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1141,6 +1141,22 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 }
 
+static void
+lpfc_nvmet_discovery_event(struct nvmet_fc_target_port *tgtport)
+{
+	struct lpfc_nvmet_tgtport *tgtp;
+	struct lpfc_hba *phba;
+	uint32_t rc;
+
+	tgtp = tgtport->private;
+	phba = tgtp->phba;
+
+	rc = lpfc_issue_els_rscn(phba->pport, 0);
+	lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			"6420 NVMET subsystem change: Notification %s\n",
+			(rc) ? "Failed" : "Sent");
+}
+
 static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.targetport_delete = lpfc_nvmet_targetport_delete,
 	.xmt_ls_rsp     = lpfc_nvmet_xmt_ls_rsp,
@@ -1148,6 +1164,7 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.fcp_abort      = lpfc_nvmet_xmt_fcp_abort,
 	.fcp_req_release = lpfc_nvmet_xmt_fcp_release,
 	.defer_rcv	= lpfc_nvmet_defer_rcv,
+	.discovery_event = lpfc_nvmet_discovery_event,
 
 	.max_hw_queues  = 1,
 	.max_sgl_segments = LPFC_NVMET_DEFAULT_SEGS,
-- 
2.13.7
