From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu, 21 Dec 2017 23:31:46 -0800
Subject: [PATCH 10/11] mpt3sas: simplify _wait_for_commands_to_complete()
In-Reply-To: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1513927907-19735-11-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

Use 'host_busy' instead of counting outstanding commands by hand.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a49040e..eb4cc20 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2898,9 +2898,9 @@ _base_recovery_check(struct MPT3SAS_ADAPTER *ioc)
 	 * See _wait_for_commands_to_complete() call with regards to this code.
 	 */
 	if (ioc->shost_recovery && ioc->pending_io_count) {
-		if (ioc->pending_io_count == 1)
+		ioc->pending_io_count = atomic_read(&ioc->shost->host_busy);
+		if (ioc->pending_io_count == 0)
 			wake_up(&ioc->reset_wq);
-		ioc->pending_io_count--;
 	}
 }
 
@@ -6310,15 +6310,13 @@ _base_reset_handler(struct MPT3SAS_ADAPTER *ioc, int reset_phase)
  * _wait_for_commands_to_complete - reset controller
  * @ioc: Pointer to MPT_ADAPTER structure
  *
- * This function waiting(3s) for all pending commands to complete
+ * This function is waiting 10s for all pending commands to complete
  * prior to putting controller in reset.
  */
 static void
 _wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc)
 {
 	u32 ioc_state;
-	unsigned long flags;
-	u16 i;
 
 	ioc->pending_io_count = 0;
 
@@ -6327,11 +6325,7 @@ _wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc)
 		return;
 
 	/* pending command count */
-	spin_lock_irqsave(&ioc->scsi_lookup_lock, flags);
-	for (i = 0; i < ioc->scsiio_depth; i++)
-		if (ioc->scsi_lookup[i].cb_idx != 0xFF)
-			ioc->pending_io_count++;
-	spin_unlock_irqrestore(&ioc->scsi_lookup_lock, flags);
+	ioc->pending_io_count = atomic_read(&ioc->shost->host_busy);
 
 	if (!ioc->pending_io_count)
 		return;
-- 
2.5.5
