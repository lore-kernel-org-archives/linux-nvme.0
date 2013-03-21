From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:01 -0600
Subject: [PATCH v2 1/7] sd: remove invalid ref tag check
In-Reply-To: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
References: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
Message-ID: <1363888327-7420-2-git-send-email-keith.busch@intel.com>

Removes incorrect check for a ref tag of 0xffffffff on verify, which is
potentially a valid ref.

Cc: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/scsi/sd_dif.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 04998f3..6174ca4 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -93,14 +93,6 @@ static int sd_dif_type1_verify(struct blk_integrity_exchg *bix, csum_fn *fn)
 		if (sdt->app_tag == 0xffff)
 			return 0;
 
-		/* Bad ref tag received from disk */
-		if (sdt->ref_tag == 0xffffffff) {
-			printk(KERN_ERR
-			       "%s: bad phys ref tag on sector %lu\n",
-			       bix->disk_name, (unsigned long)sector);
-			return -EIO;
-		}
-
 		if (be32_to_cpu(sdt->ref_tag) != (sector & 0xffffffff)) {
 			printk(KERN_ERR
 			       "%s: ref tag error on sector %lu (rcvd %u)\n",
-- 
1.7.0.4
