From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu, 21 Dec 2017 23:31:37 -0800
Subject: [PATCH 01/11] mpt3sas: set default value for cb_idx
In-Reply-To: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1513927907-19735-2-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

No functional change

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
---
 drivers/scsi/mpt3sas/modules.order  | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/modules.order b/drivers/scsi/mpt3sas/modules.order
index 352a4dd..5052fdf 100644
--- a/drivers/scsi/mpt3sas/modules.order
+++ b/drivers/scsi/mpt3sas/modules.order
@@ -1 +1 @@
-kernel/drivers/scsi/mpt3sas/mpt3sas.ko
+kernel//opt/upstream_io_tag/linux/drivers/scsi/mpt3sas/mpt3sas.ko
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8027de4..0119a39 100644
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
