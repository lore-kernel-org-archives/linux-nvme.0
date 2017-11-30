From: jsmart2021@gmail.com (James Smart)
Date: Wed, 29 Nov 2017 16:47:30 -0800
Subject: [PATCH 1/4] nvme_fcloop: fix abort race condition
In-Reply-To: <20171130004733.19330-1-jsmart2021@gmail.com>
References: <20171130004733.19330-1-jsmart2021@gmail.com>
Message-ID: <20171130004733.19330-2-jsmart2021@gmail.com>

A test case revealed a race condition of an i/o completing on a thread
parallel to the delete_association generating the aborts for the
outstanding ios on the controller.  The i/o completion was freeing the
target fcloop context, thus the abort task referenced the just-freed
memory.

Correct by clearing the target/initiator cross pointers in the io
completion and abort tasks before calling the callbacks. On aborts
that detect already finished io's, ensure the complete context is
called.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fcloop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 7b75d9de55ab..3eb2a0733f46 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -370,6 +370,7 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
 
 	spin_lock(&tfcp_req->reqlock);
 	fcpreq = tfcp_req->fcpreq;
+	tfcp_req->fcpreq = NULL;
 	spin_unlock(&tfcp_req->reqlock);
 
 	if (tport->remoteport && fcpreq) {
@@ -611,11 +612,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 
 	if (!tfcp_req)
 		/* abort has already been called */
-		return;
-
-	if (rport->targetport)
-		nvmet_fc_rcv_fcp_abort(rport->targetport,
-					&tfcp_req->tgt_fcp_req);
+		goto finish;
 
 	/* break initiator/target relationship for io */
 	spin_lock(&tfcp_req->reqlock);
@@ -623,6 +620,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	tfcp_req->fcpreq = NULL;
 	spin_unlock(&tfcp_req->reqlock);
 
+	if (rport->targetport)
+		nvmet_fc_rcv_fcp_abort(rport->targetport,
+					&tfcp_req->tgt_fcp_req);
+
+finish:
 	/* post the aborted io completion */
 	fcpreq->status = -ECANCELED;
 	schedule_work(&inireq->iniwork);
-- 
2.13.1
