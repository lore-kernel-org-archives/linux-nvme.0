From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri, 21 Apr 2017 16:05:06 -0700
Subject: [PATCH v3 22/22] lpfc revison 11.2.0.12
In-Reply-To: <20170421230506.925-1-jsmart2021@gmail.com>
References: <20170421230506.925-1-jsmart2021@gmail.com>
Message-ID: <20170421230506.925-23-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Update lpfc version to reflect this set of changes.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index d4e95e2..1c26dc6 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "11.2.0.10"
+#define LPFC_DRIVER_VERSION "11.2.0.12"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.9.3
