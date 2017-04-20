From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Wed, 19 Apr 2017 21:46:26 -0700
Subject: [PATCH-v1 07/22] Remove unused defines for NVME PostBuf.
In-Reply-To: <20170420044641.10657-1-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
Message-ID: <20170420044641.10657-8-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

These defines for the posting of buffers for nvmet target were not used.

Removing the unused defines.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_nvme.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 6277796..2582f46 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -22,9 +22,6 @@
  ********************************************************************/
 
 #define LPFC_NVME_DEFAULT_SEGS		(64 + 1)	/* 256K IOs */
-#define LPFC_NVMET_MIN_POSTBUF		16
-#define LPFC_NVMET_DEFAULT_POSTBUF	1024
-#define LPFC_NVMET_MAX_POSTBUF		4096
 #define LPFC_NVME_WQSIZE		256
 
 #define LPFC_NVME_ERSP_LEN		0x20
-- 
2.1.0
