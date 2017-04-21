From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri, 21 Apr 2017 16:04:45 -0700
Subject: [PATCH v3 01/22] Standardize nvme SGL segment count
In-Reply-To: <20170421230506.925-1-jsmart2021@gmail.com>
References: <20170421230506.925-1-jsmart2021@gmail.com>
Message-ID: <20170421230506.925-2-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Standardize default SGL segment count for nvme target and initiator

The driver needs to make them the same for clarity.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/scsi/lpfc/lpfc_nvme.h  | 4 +---
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
 drivers/scsi/lpfc/lpfc_nvmet.h | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 1347deb..6277796 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -21,9 +21,7 @@
  * included with this package.                                     *
  ********************************************************************/
 
-#define LPFC_NVME_MIN_SEGS		16
-#define LPFC_NVME_DEFAULT_SEGS		66	/* 256K IOs - 64 + 2 */
-#define LPFC_NVME_MAX_SEGS		510
+#define LPFC_NVME_DEFAULT_SEGS		(64 + 1)	/* 256K IOs */
 #define LPFC_NVMET_MIN_POSTBUF		16
 #define LPFC_NVMET_DEFAULT_POSTBUF	1024
 #define LPFC_NVMET_MAX_POSTBUF		4096
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index d488c33..c8a4941 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -709,7 +709,7 @@ lpfc_nvmet_create_targetport(struct lpfc_hba *phba)
 	pinfo.port_id = vport->fc_myDID;
 
 	lpfc_tgttemplate.max_hw_queues = phba->cfg_nvme_io_channel;
-	lpfc_tgttemplate.max_sgl_segments = phba->cfg_sg_seg_cnt;
+	lpfc_tgttemplate.max_sgl_segments = phba->cfg_sg_seg_cnt + 1;
 	lpfc_tgttemplate.target_features = NVMET_FCTGTFEAT_READDATA_RSP |
 					   NVMET_FCTGTFEAT_NEEDS_CMD_CPUSCHED |
 					   NVMET_FCTGTFEAT_CMD_IN_ISR |
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
index 02735fc..d8bac4c 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.h
+++ b/drivers/scsi/lpfc/lpfc_nvmet.h
@@ -21,9 +21,7 @@
  * included with this package.                                     *
  ********************************************************************/
 
-#define LPFC_NVMET_MIN_SEGS		16
-#define LPFC_NVMET_DEFAULT_SEGS		64	/* 256K IOs */
-#define LPFC_NVMET_MAX_SEGS		510
+#define LPFC_NVMET_DEFAULT_SEGS		(64 + 1)	/* 256K IOs */
 #define LPFC_NVMET_SUCCESS_LEN	12
 
 /* Used for NVME Target */
-- 
2.9.3
