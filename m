From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu,  4 Jan 2018 04:57:06 -0800
Subject: [Resend 06/11] mpt3sas: check command status before attempting abort
In-Reply-To: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1515070631-14740-7-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

When attempting a command abort we should check the command status
prior to sending the abort; the command might've been completed
already.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index a11774b..8870cef 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2771,6 +2771,14 @@ mpt3sas_scsih_issue_tm(struct MPT3SAS_ADAPTER *ioc, u16 handle, uint channel,
 		return (!rc) ? SUCCESS : FAILED;
 	}
 
+	if (type == MPI2_SCSITASKMGMT_TASKTYPE_ABORT_TASK) {
+		scsi_lookup = mpt3sas_get_st_from_smid(ioc, smid_task);
+		if (!scsi_lookup)
+			return FAILED;
+		if (scsi_lookup->cb_idx == 0xFF)
+			return SUCCESS;
+	}
+
 	smid = mpt3sas_base_get_smid_hpr(ioc, ioc->tm_cb_idx);
 	if (!smid) {
 		pr_err(MPT3SAS_FMT "%s: failed obtaining a smid\n",
@@ -2778,9 +2786,6 @@ mpt3sas_scsih_issue_tm(struct MPT3SAS_ADAPTER *ioc, u16 handle, uint channel,
 		return FAILED;
 	}
 
-	if (type == MPI2_SCSITASKMGMT_TASKTYPE_ABORT_TASK)
-		scsi_lookup = mpt3sas_get_st_from_smid(ioc, smid_task);
-
 	dtmprintk(ioc, pr_info(MPT3SAS_FMT
 		"sending tm: handle(0x%04x), task_type(0x%02x), smid(%d)\n",
 		ioc->name, handle, type, smid_task));
-- 
2.5.5
