From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Wed, 19 Apr 2017 21:46:23 -0700
Subject: [PATCH-v1 04/22] Fix log message in completion path.
In-Reply-To: <20170420044641.10657-1-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
Message-ID: <20170420044641.10657-5-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

In the lpfc_nvme_io_cmd_wqe_cmpl routine the driver was printing two
pointers and the DID for the rport whenever an IO completed on a now
that had transitioned to a non active state.

There is no need to print the node pointer address for a node that
is not active the DID should be enough to debug.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 2a87428..bc6946f 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -787,9 +787,8 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	ndlp = rport->ndlp;
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
-				 "6061 rport %p, ndlp %p, DID x%06x ndlp "
-				 "not ready.\n",
-				 rport, ndlp, rport->remoteport->port_id);
+				 "6061 rport %p,  DID x%06x node not ready.\n",
+				 rport, rport->remoteport->port_id);
 
 		ndlp = lpfc_findnode_did(vport, rport->remoteport->port_id);
 		if (!ndlp) {
-- 
2.1.0
