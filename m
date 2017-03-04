From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:32 -0800
Subject: [PATCH 12/20] lpfc: add transport eh_timed_out reference
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-13-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Christoph's prior patch missed the template for the sli3 adapters,
which is now the "no host reset" template. Add the transport
eh_timed_out handler to the no host reset template

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index bcfd6d6..54fd0c8 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5959,6 +5959,7 @@ struct scsi_host_template lpfc_template_no_hr = {
 	.proc_name		= LPFC_DRIVER_NAME,
 	.info			= lpfc_info,
 	.queuecommand		= lpfc_queuecommand,
+	.eh_timed_out		= fc_eh_timed_out,
 	.eh_abort_handler	= lpfc_abort_handler,
 	.eh_device_reset_handler = lpfc_device_reset_handler,
 	.eh_target_reset_handler = lpfc_target_reset_handler,
-- 
2.5.0
