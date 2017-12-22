From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu, 21 Dec 2017 23:31:40 -0800
Subject: [PATCH 04/11] mpt3sas: open-code _scsih_scsi_lookup_get()
In-Reply-To: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1513927907-19735-5-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

Just a wrapper around the scsi lookup array and only used
in one place, so open-code it.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6fea5e6..7d76e8f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -1445,19 +1445,6 @@ _scsih_is_nvme_device(u32 device_info)
 }
 
 /**
- * _scsih_scsi_lookup_get - returns scmd entry
- * @ioc: per adapter object
- * @smid: system request message index
- *
- * Returns the smid stored scmd pointer.
- */
-static struct scsi_cmnd *
-_scsih_scsi_lookup_get(struct MPT3SAS_ADAPTER *ioc, u16 smid)
-{
-	return ioc->scsi_lookup[smid - 1].scmd;
-}
-
-/**
  * __scsih_scsi_lookup_get_clear - returns scmd entry without
  *						holding any lock.
  * @ioc: per adapter object
@@ -7541,7 +7528,7 @@ _scsih_sas_broadcast_primitive_event(struct MPT3SAS_ADAPTER *ioc,
 	for (smid = 1; smid <= ioc->scsiio_depth; smid++) {
 		if (ioc->shost_recovery)
 			goto out;
-		scmd = _scsih_scsi_lookup_get(ioc, smid);
+		scmd = ioc->scsi_lookup[smid - 1].scmd;
 		if (!scmd)
 			continue;
 		sdev = scmd->device;
-- 
2.5.5
