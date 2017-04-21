From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri, 21 Apr 2017 16:04:49 -0700
Subject: [PATCH v3 05/22] Add debug messages for nvme/fcp resource allocation.
In-Reply-To: <20170421230506.925-1-jsmart2021@gmail.com>
References: <20170421230506.925-1-jsmart2021@gmail.com>
Message-ID: <20170421230506.925-6-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

The xri resources are split into pools for NVME and FCP IO when NVME is
enabled. There was not message in the log that identified this allocation.

Added debug message to log XRI split.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/scsi/lpfc/lpfc_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 6cc561b..b56da01 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3508,6 +3508,12 @@ lpfc_sli4_scsi_sgl_update(struct lpfc_hba *phba)
 	spin_unlock(&phba->scsi_buf_list_put_lock);
 	spin_unlock_irq(&phba->scsi_buf_list_get_lock);
 
+	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
+			"6060 Current allocated SCSI xri-sgl count:%d, "
+			"maximum  SCSI xri count:%d (split:%d)\n",
+			phba->sli4_hba.scsi_xri_cnt,
+			phba->sli4_hba.scsi_xri_max, phba->cfg_xri_split);
+
 	if (phba->sli4_hba.scsi_xri_cnt > phba->sli4_hba.scsi_xri_max) {
 		/* max scsi xri shrinked below the allocated scsi buffers */
 		scsi_xri_cnt = phba->sli4_hba.scsi_xri_cnt -
-- 
2.9.3
