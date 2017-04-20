From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Wed, 19 Apr 2017 21:46:25 -0700
Subject: [PATCH-v1 06/22] Fix spelling in comments.
In-Reply-To: <20170420044641.10657-1-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
Message-ID: <20170420044641.10657-7-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Comment should have said Repost.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 1c9fa45..7087c55 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6338,7 +6338,7 @@ lpfc_sli4_get_allocated_extnts(struct lpfc_hba *phba, uint16_t type,
 }
 
 /**
- * lpfc_sli4_repost_sgl_list - Repsot the buffers sgl pages as block
+ * lpfc_sli4_repost_sgl_list - Repost the buffers sgl pages as block
  * @phba: pointer to lpfc hba data structure.
  * @pring: Pointer to driver SLI ring object.
  * @sgl_list: linked link of sgl buffers to post
-- 
2.1.0
