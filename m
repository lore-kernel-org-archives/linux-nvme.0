From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 28 Oct 2016 17:23:00 -0700
Subject: [PATCH v5 12/14] SRP transport, scsi-mq: Wait for .queue_rq() if
 necessary
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Message-ID: <32accadb-3ed3-cd5d-e92f-655f8f3cb9bc@sandisk.com>

Ensure that if scsi-mq is enabled that scsi_internal_device_block()
waits until ongoing shost->hostt->queuecommand() calls have finished.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: James Bottomley <jejb at linux.vnet.ibm.com>
Cc: Martin K. Petersen <martin.petersen at oracle.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Doug Ledford <dledford at redhat.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3ab9c87..1febc52 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2873,7 +2873,7 @@ scsi_internal_device_block(struct scsi_device *sdev)
 	 * request queue. 
 	 */
 	if (q->mq_ops) {
-		blk_mq_stop_hw_queues(q);
+		blk_mq_quiesce_queue(q);
 	} else {
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_stop_queue(q);
-- 
2.10.1
