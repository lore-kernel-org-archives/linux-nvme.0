From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu,  4 Jan 2018 04:57:01 -0800
Subject: [Resend 01/11] mpt3sas: set default value for cb_idx
In-Reply-To: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1515070631-14740-2-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

No functional change

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 08237b8..e3857e5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -899,7 +899,7 @@ static u8
 _base_get_cb_idx(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 {
 	int i;
-	u8 cb_idx;
+	u8 cb_idx = 0xFF;
 
 	if (smid < ioc->hi_priority_smid) {
 		i = smid - 1;
@@ -910,8 +910,7 @@ _base_get_cb_idx(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	} else if (smid <= ioc->hba_queue_depth) {
 		i = smid - ioc->internal_smid;
 		cb_idx = ioc->internal_lookup[i].cb_idx;
-	} else
-		cb_idx = 0xFF;
+	}
 	return cb_idx;
 }
 
-- 
2.5.5
