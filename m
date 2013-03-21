From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:05 -0600
Subject: [PATCH v2 5/7] sd: export dif integrity template
In-Reply-To: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
References: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
Message-ID: <1363888327-7420-6-git-send-email-keith.busch@intel.com>

Exports access to copies of common blk_integrity templates so that other
non-scsi dif capable block drivers can use them.

Cc: Martin K. Petersen <martin.petersen at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/scsi/sd_dif.c  |   24 ++++++++++++++++++++++++
 include/linux/blkdev.h |    5 +++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 1735513..8c85027 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -22,6 +22,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/crc-t10dif.h>
+#include <linux/export.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -482,3 +483,26 @@ void sd_dif_complete(struct scsi_cmnd *scmd, unsigned int good_bytes)
 	}
 }
 
+struct blk_integrity sd_dif_get_type1_crc(void)
+{
+	return dif_type1_integrity_crc;
+}
+EXPORT_SYMBOL(sd_dif_get_type1_crc);
+
+struct blk_integrity sd_dif_get_type1_ip(void)
+{
+	return dif_type1_integrity_ip;
+}
+EXPORT_SYMBOL(sd_dif_get_type1_ip);
+
+struct blk_integrity sd_dif_get_type3_crc(void)
+{
+	return dif_type3_integrity_crc;
+}
+EXPORT_SYMBOL(sd_dif_get_type3_crc);
+
+struct blk_integrity sd_dif_get_type3_ip(void)
+{
+	return dif_type3_integrity_ip;
+}
+EXPORT_SYMBOL(sd_dif_get_type3_ip);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 70eccab..f4769a7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1350,6 +1350,11 @@ struct blk_integrity {
 	struct kobject		kobj;
 };
 
+extern struct blk_integrity sd_dif_get_type1_ip(void);
+extern struct blk_integrity sd_dif_get_type1_crc(void);
+extern struct blk_integrity sd_dif_get_type3_ip(void);
+extern struct blk_integrity sd_dif_get_type3_crc(void);
+
 extern bool blk_integrity_is_initialized(struct gendisk *);
 extern int blk_integrity_register(struct gendisk *, struct blk_integrity *);
 extern void blk_integrity_unregister(struct gendisk *);
-- 
1.7.0.4
