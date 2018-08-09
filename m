From: jsmart2021@gmail.com (James Smart)
Date: Thu,  9 Aug 2018 16:00:14 -0700
Subject: [PATCH] nvme_fcloop: Fix dropped LS's to removed target port
Message-ID: <20180809230014.6689-1-jsmart2021@gmail.com>

When a targetport is removed from the config, fcloop will avoid calling
the LS done() routine thinking the targetport is gone. This leaves the
initiator reset/reconnect hanging as it waits for a status on the
Create_Association LS for the reconnect.

Change the filter in the LS callback path. If tport null (set when
failed validation before "sending to remote port"), be sure to call
done. This was the main bug. But, continue the logic that only calls
done if tport was set but there is no remoteport (e.g. case where
remoteport has been removed, thus host doesn't expect a completion).

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fcloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 34712def81b1..5251689a1d9a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -311,7 +311,7 @@ fcloop_tgt_lsrqst_done_work(struct work_struct *work)
 	struct fcloop_tport *tport = tls_req->tport;
 	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
 
-	if (tport->remoteport)
+	if (!tport || tport->remoteport)
 		lsreq->done(lsreq, tls_req->status);
 }
 
@@ -329,6 +329,7 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
+		tls_req->tport = NULL;
 		schedule_work(&tls_req->work);
 		return ret;
 	}
-- 
2.13.1
