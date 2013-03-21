From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:02 -0600
Subject: [PATCH v2 2/7] sd: skip verifying unwritten sectors
In-Reply-To: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
References: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
Message-ID: <1363888327-7420-3-git-send-email-keith.busch@intel.com>

This skips verifying unwritten sectors and continues on to the next
sector. Previously, the code would return early if an unwritten sector
was encountered, whether the next sector was written or not.

Cc: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/scsi/sd_dif.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 6174ca4..7cf0a39 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -83,15 +83,15 @@ static void sd_dif_type1_generate_ip(struct blk_integrity_exchg *bix)
 static int sd_dif_type1_verify(struct blk_integrity_exchg *bix, csum_fn *fn)
 {
 	void *buf = bix->data_buf;
+	void *end = buf + bix->data_size;
 	struct sd_dif_tuple *sdt = bix->prot_buf;
 	sector_t sector = bix->sector;
-	unsigned int i;
 	__u16 csum;
 
-	for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
+	for (; buf < end; buf += bix->sector_size, sdt++, sector++) {
 		/* Unwritten sectors */
 		if (sdt->app_tag == 0xffff)
-			return 0;
+			continue;
 
 		if (be32_to_cpu(sdt->ref_tag) != (sector & 0xffffffff)) {
 			printk(KERN_ERR
@@ -110,9 +110,6 @@ static int sd_dif_type1_verify(struct blk_integrity_exchg *bix, csum_fn *fn)
 			       be16_to_cpu(sdt->guard_tag), be16_to_cpu(csum));
 			return -EIO;
 		}
-
-		buf += bix->sector_size;
-		sector++;
 	}
 
 	return 0;
@@ -208,15 +205,15 @@ static void sd_dif_type3_generate_ip(struct blk_integrity_exchg *bix)
 static int sd_dif_type3_verify(struct blk_integrity_exchg *bix, csum_fn *fn)
 {
 	void *buf = bix->data_buf;
+	void *end = buf + bix->data_size;
 	struct sd_dif_tuple *sdt = bix->prot_buf;
 	sector_t sector = bix->sector;
-	unsigned int i;
 	__u16 csum;
 
-	for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
+	for (; buf < end; buf += bix->sector_size, sdt++, sector++) {
 		/* Unwritten sectors */
 		if (sdt->app_tag == 0xffff && sdt->ref_tag == 0xffffffff)
-			return 0;
+			continue;
 
 		csum = fn(buf, bix->sector_size);
 
@@ -227,9 +224,6 @@ static int sd_dif_type3_verify(struct blk_integrity_exchg *bix, csum_fn *fn)
 			       be16_to_cpu(sdt->guard_tag), be16_to_cpu(csum));
 			return -EIO;
 		}
-
-		buf += bix->sector_size;
-		sector++;
 	}
 
 	return 0;
-- 
1.7.0.4
