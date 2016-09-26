From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 26 Sep 2016 11:28:42 -0700
Subject: [PATCH 8/9] SRP transport: Port srp_wait_for_queuecommand() to scsi-mq
In-Reply-To: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
Message-ID: <456fc29e-a20f-51ec-631b-39ae311aa83a@sandisk.com>

Ensure that if scsi-mq is enabled that srp_wait_for_queuecommand()
waits until ongoing shost->hostt->queuecommand() calls have finished.
For the !scsi-mq path, use blk_quiesce_queue() and blk_resume_queue()
instead of busy-waiting.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: James Bottomley <jejb at linux.vnet.ibm.com>
Cc: Martin K. Petersen <martin.petersen at oracle.com>
Cc: Doug Ledford <dledford at redhat.com>
---
 drivers/scsi/scsi_transport_srp.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/scsi_transport_srp.c b/drivers/scsi/scsi_transport_srp.c
index e3cd3ec..841a3eb 100644
--- a/drivers/scsi/scsi_transport_srp.c
+++ b/drivers/scsi/scsi_transport_srp.c
@@ -24,7 +24,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/delay.h>
+#include <linux/blk-mq.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -402,34 +402,18 @@ static void srp_reconnect_work(struct work_struct *work)
 	}
 }
 
-/**
- * scsi_request_fn_active() - number of kernel threads inside scsi_request_fn()
- * @shost: SCSI host for which to count the number of scsi_request_fn() callers.
- *
- * To do: add support for scsi-mq in this function.
- */
-static int scsi_request_fn_active(struct Scsi_Host *shost)
+/* Wait until ongoing shost->hostt->queuecommand() calls have finished. */
+static void srp_wait_for_queuecommand(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
 	struct request_queue *q;
-	int request_fn_active = 0;
 
 	shost_for_each_device(sdev, shost) {
 		q = sdev->request_queue;
 
-		spin_lock_irq(q->queue_lock);
-		request_fn_active += q->request_fn_active;
-		spin_unlock_irq(q->queue_lock);
+		blk_quiesce_queue(q);
+		blk_resume_queue(q);
 	}
-
-	return request_fn_active;
-}
-
-/* Wait until ongoing shost->hostt->queuecommand() calls have finished. */
-static void srp_wait_for_queuecommand(struct Scsi_Host *shost)
-{
-	while (scsi_request_fn_active(shost))
-		msleep(20);
 }
 
 static void __rport_fail_io_fast(struct srp_rport *rport)
-- 
2.10.0
