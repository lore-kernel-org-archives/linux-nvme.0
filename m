From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu,  4 Jan 2018 04:57:03 -0800
Subject: [Resend 03/11] mpt3sas: separate out _base_recovery_check()
In-Reply-To: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1515070631-14740-4-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

No functional change.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 464a11e..55aa80c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2873,6 +2873,19 @@ mpt3sas_base_get_smid_hpr(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx)
 	return smid;
 }
 
+static void
+_base_recovery_check(struct MPT3SAS_ADAPTER *ioc)
+{
+	/*
+	 * See _wait_for_commands_to_complete() call with regards to this code.
+	 */
+	if (ioc->shost_recovery && ioc->pending_io_count) {
+		if (ioc->pending_io_count == 1)
+			wake_up(&ioc->reset_wq);
+		ioc->pending_io_count--;
+	}
+}
+
 /**
  * mpt3sas_base_free_smid - put smid back on free_list
  * @ioc: per adapter object
@@ -2898,15 +2911,7 @@ mpt3sas_base_free_smid(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 		list_add(&ioc->scsi_lookup[i].tracker_list, &ioc->free_list);
 		spin_unlock_irqrestore(&ioc->scsi_lookup_lock, flags);
 
-		/*
-		 * See _wait_for_commands_to_complete() call with regards
-		 * to this code.
-		 */
-		if (ioc->shost_recovery && ioc->pending_io_count) {
-			if (ioc->pending_io_count == 1)
-				wake_up(&ioc->reset_wq);
-			ioc->pending_io_count--;
-		}
+		_base_recovery_check(ioc);
 		return;
 	} else if (smid < ioc->internal_smid) {
 		/* hi-priority */
-- 
2.5.5
