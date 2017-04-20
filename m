From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Wed, 19 Apr 2017 21:46:31 -0700
Subject: [PATCH-v1 12/22] Fix driver usage of 128B WQEs when WQ_CREATE is V1.
In-Reply-To: <20170420044641.10657-1-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
Message-ID: <20170420044641.10657-13-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

There are two versions of a structure for queue creation and setup that the
driver shares with FW. The driver was only treating as version 0.

Verify WQ_CREATE with 128B WQEs in V0 and V1.

Code review of another bug showed the driver passing
128B WQEs and 8 pages in WQ CREATE and V0.
Code inspection/instrumentation showed that the driver
uses V0 in WQ_CREATE and if the caller passes queue->entry_size
128B, the driver sets the hdr_version to V1 so all is good.
When I tested the V1 WQ_CREATE, the mailbox failed causing
the driver to unload.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index d606944..1519fdf 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -14741,6 +14741,9 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 	case LPFC_Q_CREATE_VERSION_1:
 		bf_set(lpfc_mbx_wq_create_wqe_count, &wq_create->u.request_1,
 		       wq->entry_count);
+		bf_set(lpfc_mbox_hdr_version, &shdr->request,
+		       LPFC_Q_CREATE_VERSION_1);
+
 		switch (wq->entry_size) {
 		default:
 		case 64:
-- 
2.1.0
