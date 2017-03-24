From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:43:19 -0700
Subject: [PATCH 3/5] nvme_fcloop: split job struct from transport for
 req_release
In-Reply-To: <20170324034321.8719-1-jsmart2021@gmail.com>
References: <20170324034321.8719-1-jsmart2021@gmail.com>
Message-ID: <20170324034321.8719-4-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Current design has the fcloop job struct, used for both initiator and
target processing, allocated as part of the initiator request structure.
On aborts, the initiator side (based on the request) may terminate, yet
the target side wants to continue processing. the target side can't do
that if the initiator side goes away.
Revise fcloop to allocate an independent target side structure when it
starts an io from the initiator.

Added a lock to the request struct as well to synchronize pointer updates
on abort calls.

Modified target downcalls to recognize conditions where initiator has
aborted the io (thus nulled the pointer between job structs), thus
avoid referencing sgl lists which are gone and no longer making upcalls
to the initiator.

In conditions where the targetport is no longer connected, have the
initiator return an access failure rather than simulating a command
completion.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fcloop.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2c4d682..dbcafd3 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -251,6 +251,10 @@ struct fcloop_fcpreq {
 	struct nvmefc_tgt_fcp_req	tgt_fcp_req;
 };
 
+struct fcloop_ini_fcpreq {
+	struct nvmefc_fcp_req		*fcpreq;
+	struct fcloop_fcpreq		*tfcp_req;
+};
 
 static inline struct fcloop_lsreq *
 tgt_ls_req_to_lsreq(struct nvmefc_tgt_ls_req *tgt_lsreq)
@@ -355,6 +359,8 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
 		fcpreq->status = tfcp_req->status;
 		fcpreq->done(fcpreq);
 	}
+
+	kfree(tfcp_req);
 }
 
 
@@ -364,20 +370,23 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 			void *hw_queue_handle,
 			struct nvmefc_fcp_req *fcpreq)
 {
-	struct fcloop_fcpreq *tfcp_req = fcpreq->private;
 	struct fcloop_rport *rport = remoteport->private;
+	struct fcloop_ini_fcpreq *inireq = fcpreq->private;
+	struct fcloop_fcpreq *tfcp_req;
 	int ret = 0;
 
-	INIT_WORK(&tfcp_req->work, fcloop_tgt_fcprqst_done_work);
+	if (!rport->targetport)
+		return -ECONNREFUSED;
 
-	if (!rport->targetport) {
-		tfcp_req->status = NVME_SC_FC_TRANSPORT_ERROR;
-		schedule_work(&tfcp_req->work);
-		return ret;
-	}
+	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_KERNEL);
+	if (!tfcp_req)
+		return -ENOMEM;
 
+	inireq->fcpreq = fcpreq;
+	inireq->tfcp_req = tfcp_req;
 	tfcp_req->fcpreq = fcpreq;
 	tfcp_req->tport = rport->targetport->private;
+	INIT_WORK(&tfcp_req->work, fcloop_tgt_fcprqst_done_work);
 
 	ret = nvmet_fc_rcv_fcp_req(rport->targetport, &tfcp_req->tgt_fcp_req,
 				 fcpreq->cmdaddr, fcpreq->cmdlen);
@@ -567,7 +576,7 @@ struct nvme_fc_port_template fctemplate = {
 	.local_priv_sz		= sizeof(struct fcloop_lport),
 	.remote_priv_sz		= sizeof(struct fcloop_rport),
 	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
-	.fcprqst_priv_sz	= sizeof(struct fcloop_fcpreq),
+	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
 };
 
 struct nvmet_fc_target_template tgttemplate = {
-- 
2.9.3
