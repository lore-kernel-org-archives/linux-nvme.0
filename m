From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu, 21 Dec 2017 23:31:38 -0800
Subject: [PATCH 02/11] mpt3sas: use list_splice_init()
In-Reply-To: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1513927907-19735-3-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

Use 'list_splice_init()' instead of hand-crafted function.
No functional change.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 0119a39..5a9ad26 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2885,20 +2885,13 @@ mpt3sas_base_free_smid(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 {
 	unsigned long flags;
 	int i;
-	struct chain_tracker *chain_req, *next;
 
 	spin_lock_irqsave(&ioc->scsi_lookup_lock, flags);
 	if (smid < ioc->hi_priority_smid) {
 		/* scsiio queue */
 		i = smid - 1;
-		if (!list_empty(&ioc->scsi_lookup[i].chain_list)) {
-			list_for_each_entry_safe(chain_req, next,
-			    &ioc->scsi_lookup[i].chain_list, tracker_list) {
-				list_del_init(&chain_req->tracker_list);
-				list_add(&chain_req->tracker_list,
-				    &ioc->free_chain_list);
-			}
-		}
+		list_splice_init(&ioc->scsi_lookup[i].chain_list,
+				 &ioc->free_chain_list);
 		ioc->scsi_lookup[i].cb_idx = 0xFF;
 		ioc->scsi_lookup[i].scmd = NULL;
 		ioc->scsi_lookup[i].direct_io = 0;
-- 
2.5.5
