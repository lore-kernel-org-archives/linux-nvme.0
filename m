From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu, 21 Dec 2017 23:31:44 -0800
Subject: [PATCH 08/11] mpt3sas: simplify task management functions
In-Reply-To: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1513927907-19735-9-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

No functional change. Code optimization.
One can simply check 'target_busy' or 'device_busy' when figuring
out if there are outstanding commands; no need to painstakingly
counting them by hand.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 88 +++---------------------------------
 1 file changed, 7 insertions(+), 81 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 0434fd6..c8216c4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -1517,74 +1517,6 @@ _scsih_scsi_lookup_find_by_scmd(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd
 }
 
 /**
- * _scsih_scsi_lookup_find_by_target - search for matching channel:id
- * @ioc: per adapter object
- * @id: target id
- * @channel: channel
- * Context: This function will acquire ioc->scsi_lookup_lock.
- *
- * This will search for a matching channel:id in the scsi_lookup array,
- * returning 1 if found.
- */
-static u8
-_scsih_scsi_lookup_find_by_target(struct MPT3SAS_ADAPTER *ioc, int id,
-	int channel)
-{
-	u8 found;
-	unsigned long	flags;
-	int i;
-
-	spin_lock_irqsave(&ioc->scsi_lookup_lock, flags);
-	found = 0;
-	for (i = 0 ; i < ioc->scsiio_depth; i++) {
-		if (ioc->scsi_lookup[i].scmd &&
-		    (ioc->scsi_lookup[i].scmd->device->id == id &&
-		    ioc->scsi_lookup[i].scmd->device->channel == channel)) {
-			found = 1;
-			goto out;
-		}
-	}
- out:
-	spin_unlock_irqrestore(&ioc->scsi_lookup_lock, flags);
-	return found;
-}
-
-/**
- * _scsih_scsi_lookup_find_by_lun - search for matching channel:id:lun
- * @ioc: per adapter object
- * @id: target id
- * @lun: lun number
- * @channel: channel
- * Context: This function will acquire ioc->scsi_lookup_lock.
- *
- * This will search for a matching channel:id:lun in the scsi_lookup array,
- * returning 1 if found.
- */
-static u8
-_scsih_scsi_lookup_find_by_lun(struct MPT3SAS_ADAPTER *ioc, int id,
-	unsigned int lun, int channel)
-{
-	u8 found;
-	unsigned long	flags;
-	int i;
-
-	spin_lock_irqsave(&ioc->scsi_lookup_lock, flags);
-	found = 0;
-	for (i = 0 ; i < ioc->scsiio_depth; i++) {
-		if (ioc->scsi_lookup[i].scmd &&
-		    (ioc->scsi_lookup[i].scmd->device->id == id &&
-		    ioc->scsi_lookup[i].scmd->device->channel == channel &&
-		    ioc->scsi_lookup[i].scmd->device->lun == lun)) {
-			found = 1;
-			goto out;
-		}
-	}
- out:
-	spin_unlock_irqrestore(&ioc->scsi_lookup_lock, flags);
-	return found;
-}
-
-/**
  * scsih_change_queue_depth - setting device queue depth
  * @sdev: scsi device struct
  * @qdepth: requested queue depth
@@ -2849,19 +2781,9 @@ mpt3sas_scsih_issue_tm(struct MPT3SAS_ADAPTER *ioc, u16 handle, uint channel,
 		rc = FAILED;
 		break;
 
-	case MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET:
-		if (_scsih_scsi_lookup_find_by_target(ioc, id, channel))
-			rc = FAILED;
-		else
-			rc = SUCCESS;
-		break;
 	case MPI2_SCSITASKMGMT_TASKTYPE_ABRT_TASK_SET:
 	case MPI2_SCSITASKMGMT_TASKTYPE_LOGICAL_UNIT_RESET:
-		if (_scsih_scsi_lookup_find_by_lun(ioc, id, lun, channel))
-			rc = FAILED;
-		else
-			rc = SUCCESS;
-		break;
+	case MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET:
 	case MPI2_SCSITASKMGMT_TASKTYPE_QUERY_TASK:
 		rc = SUCCESS;
 		break;
@@ -3082,7 +3004,9 @@ scsih_dev_reset(struct scsi_cmnd *scmd)
 	r = mpt3sas_scsih_issue_locked_tm(ioc, handle, scmd->device->channel,
 	    scmd->device->id, scmd->device->lun,
 	    MPI2_SCSITASKMGMT_TASKTYPE_LOGICAL_UNIT_RESET, 0, 30);
-
+	/* Check for busy commands after reset */
+	if (r == SUCCESS && atomic_read(&scmd->device->device_busy))
+		r = FAILED;
  out:
 	sdev_printk(KERN_INFO, scmd->device, "device reset: %s scmd(%p)\n",
 	    ((r == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
@@ -3144,7 +3068,9 @@ scsih_target_reset(struct scsi_cmnd *scmd)
 	r = mpt3sas_scsih_issue_locked_tm(ioc, handle, scmd->device->channel,
 	    scmd->device->id, 0, MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
 	    30);
-
+	/* Check for busy commands after reset */
+	if (r == SUCCESS && atomic_read(&starget->target_busy))
+		r = FAILED;
  out:
 	starget_printk(KERN_INFO, starget, "target reset: %s scmd(%p)\n",
 	    ((r == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
-- 
2.5.5
