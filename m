From: jsmart2021@gmail.com (James Smart)
Date: Thu, 20 Jun 2019 13:07:00 -0700
Subject: [PATCH] nvme-fcloop: Fix inconsistent lock state warnings
Message-ID: <20190620200700.15659-1-jsmart2021@gmail.com>

With extra debug on, inconsistent lock state warnings are being
called out as the tfcp_req->reqlock is being taken out without
irq, while some calling sequences have the sequence in a softirq
state.

Change the lock taking/release to raise/drop irq.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 drivers/nvme/target/fcloop.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b8c1cc54a0db..e64969d2a7c5 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -434,7 +434,7 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	int ret = 0;
 	bool aborted = false;
 
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -443,11 +443,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 		aborted = true;
 		break;
 	default:
-		spin_unlock(&tfcp_req->reqlock);
+		spin_unlock_irq(&tfcp_req->reqlock);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	if (unlikely(aborted))
 		ret = -ECANCELED;
@@ -469,7 +469,7 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 	struct nvmefc_fcp_req *fcpreq;
 	bool completed = false;
 
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
@@ -478,11 +478,11 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		completed = true;
 		break;
 	default:
-		spin_unlock(&tfcp_req->reqlock);
+		spin_unlock_irq(&tfcp_req->reqlock);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	if (unlikely(completed)) {
 		/* remove reference taken in original abort downcall */
@@ -494,9 +494,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	tfcp_req->fcpreq = NULL;
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
@@ -513,10 +513,10 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
 		container_of(work, struct fcloop_fcpreq, tio_done_work);
 	struct nvmefc_fcp_req *fcpreq;
 
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	fcpreq = tfcp_req->fcpreq;
 	tfcp_req->inistate = INI_IO_COMPLETED;
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, tfcp_req->status);
 }
@@ -621,12 +621,12 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 	int fcp_err = 0, active, aborted;
 	u8 op = tgt_fcpreq->op;
 
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	fcpreq = tfcp_req->fcpreq;
 	active = tfcp_req->active;
 	aborted = tfcp_req->aborted;
 	tfcp_req->active = true;
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	if (unlikely(active))
 		/* illegal - call while i/o active */
@@ -634,9 +634,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 
 	if (unlikely(aborted)) {
 		/* target transport has aborted i/o prior */
-		spin_lock(&tfcp_req->reqlock);
+		spin_lock_irq(&tfcp_req->reqlock);
 		tfcp_req->active = false;
-		spin_unlock(&tfcp_req->reqlock);
+		spin_unlock_irq(&tfcp_req->reqlock);
 		tgt_fcpreq->transferred_length = 0;
 		tgt_fcpreq->fcp_error = -ECANCELED;
 		tgt_fcpreq->done(tgt_fcpreq);
@@ -693,9 +693,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 		break;
 	}
 
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	tfcp_req->active = false;
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	tgt_fcpreq->transferred_length = xfrlen;
 	tgt_fcpreq->fcp_error = fcp_err;
@@ -715,9 +715,9 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 	 * (one doing io, other doing abort) and only kills ops posted
 	 * after the abort request
 	 */
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	tfcp_req->aborted = true;
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	tfcp_req->status = NVME_SC_INTERNAL;
 
@@ -765,7 +765,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		return;
 
 	/* break initiator/target relationship for io */
-	spin_lock(&tfcp_req->reqlock);
+	spin_lock_irq(&tfcp_req->reqlock);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 	case INI_IO_ACTIVE:
@@ -775,11 +775,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		abortio = false;
 		break;
 	default:
-		spin_unlock(&tfcp_req->reqlock);
+		spin_unlock_irq(&tfcp_req->reqlock);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock(&tfcp_req->reqlock);
+	spin_unlock_irq(&tfcp_req->reqlock);
 
 	if (abortio)
 		/* leave the reference while the work item is scheduled */
-- 
2.13.7
