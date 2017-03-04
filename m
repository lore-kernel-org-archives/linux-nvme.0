From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:22 -0800
Subject: [PATCH 02/20] scsi: lpfc: sanity check hrq is null before
 dereferencing it
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-3-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

From: Colin Ian King <colin.king@canonical.com>

The sanity check for hrq should be moved to before the deference
of hrq to ensure we don't perform a null pointer deference.

Detected by CoverityScan, CID#1411650 ("Dereference before null check")

Signed-off-by: Colin Ian King <colin.king at canonical.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index d8d8693..562a528 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -15185,17 +15185,17 @@ lpfc_mrq_create(struct lpfc_hba *phba, struct lpfc_queue **hrqp,
 		drq = drqp[idx];
 		cq  = cqp[idx];
 
-		if (hrq->entry_count != drq->entry_count) {
-			status = -EINVAL;
-			goto out;
-		}
-
 		/* sanity check on queue memory */
 		if (!hrq || !drq || !cq) {
 			status = -ENODEV;
 			goto out;
 		}
 
+		if (hrq->entry_count != drq->entry_count) {
+			status = -EINVAL;
+			goto out;
+		}
+
 		if (idx == 0) {
 			bf_set(lpfc_mbx_rq_create_num_pages,
 			       &rq_create->u.request,
-- 
2.5.0
