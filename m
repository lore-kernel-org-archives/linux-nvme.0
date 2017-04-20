From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 20 Apr 2017 15:04:35 -0700
Subject: ["PATCH-v2" 09/22] Fix extra line print in rqpair debug print.
In-Reply-To: <20170420220448.27095-1-jsmart2021@gmail.com>
References: <20170420220448.27095-1-jsmart2021@gmail.com>
Message-ID: <20170420220448.27095-10-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

An extra blank line was being added the the rqpair printing.

Remove the extra line feed.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 76857e2..55a8d8f 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -3128,8 +3128,6 @@ __lpfc_idiag_print_rqpair(struct lpfc_queue *qp, struct lpfc_queue *datqp,
 			datqp->queue_id, datqp->entry_count,
 			datqp->entry_size, datqp->host_index,
 			datqp->hba_index);
-	len +=  snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len, "\n");
-
 	return len;
 }
 
-- 
2.9.3
