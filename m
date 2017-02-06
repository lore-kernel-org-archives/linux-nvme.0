From: jsmart2021@gmail.com (James Smart)
Date: Mon, 06 Feb 2017 15:09:08 -0800
Subject: [PATCH v2 18/18] lpfc: Update lpfc version to 11.2.0.7
Message-ID: <58990214.mwgH0rtBqxNX+jxR%jsmart2021@gmail.com>


Update lpfc version to 11.2.0.7

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>

---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index 0d93535..86c6c9b 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "11.2.0.4"
+#define LPFC_DRIVER_VERSION "11.2.0.7"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.5.0
