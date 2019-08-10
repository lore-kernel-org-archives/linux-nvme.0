From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun, 11 Aug 2019 02:55:00 +0900
Subject: [PATCH v3 3/6] scsi: nsp32: rename LED_* macros to EXT_PORT_LED_*
In-Reply-To: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1565459703-30513-4-git-send-email-akinobu.mita@gmail.com>

The nsp32 driver defines LED_ON and LED_OFF macros for EXT_PORT_DDR or
EXT_PORT register values.  The LED_OFF and LED_ON macros conflict with
the LED subsystem's LED_OFF and LED_ON enums.

This renames these LED_* macros to EXT_PORT_LED_* in nsp32 driver.

Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
Cc: Pavel Machek <pavel at ucw.cz>
Cc: Dan Murphy <dmurphy at ti.com>
Cc: Jens Axboe <axboe at kernel.dk>
Cc: "James E.J. Bottomley" <jejb at linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen at oracle.com>
Cc: GOTO Masanori <gotom at debian.or.jp>
Cc: YOKOTA Hiroshi <yokota at netlab.is.tsukuba.ac.jp>
Cc: Hannes Reinecke <hare at suse.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Acked-by: Pavel Machek <pavel at ucw.cz>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/scsi/nsp32.c | 7 ++++---
 drivers/scsi/nsp32.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index 70db792..8170358 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -763,7 +763,8 @@ static int nsp32_arbitration(struct scsi_cmnd *SCpnt, unsigned int base)
 	if (arbit & ARBIT_WIN) {
 		/* Arbitration succeeded */
 		SCpnt->result = DID_OK << 16;
-		nsp32_index_write1(base, EXT_PORT, LED_ON); /* PCI LED on */
+		/* PCI LED on */
+		nsp32_index_write1(base, EXT_PORT, EXT_PORT_LED_ON);
 	} else if (arbit & ARBIT_FAIL) {
 		/* Arbitration failed */
 		SCpnt->result = DID_BUS_BUSY << 16;
@@ -1137,8 +1138,8 @@ static int nsp32hw_init(nsp32_hw_data *data)
 	nsp32_write2(base, IRQ_CONTROL, 0);
 
 	/* PCI LED off */
-	nsp32_index_write1(base, EXT_PORT_DDR, LED_OFF);
-	nsp32_index_write1(base, EXT_PORT,     LED_OFF);
+	nsp32_index_write1(base, EXT_PORT_DDR, EXT_PORT_LED_OFF);
+	nsp32_index_write1(base, EXT_PORT,     EXT_PORT_LED_OFF);
 
 	return TRUE;
 }
diff --git a/drivers/scsi/nsp32.h b/drivers/scsi/nsp32.h
index ab0726c..a7553ea 100644
--- a/drivers/scsi/nsp32.h
+++ b/drivers/scsi/nsp32.h
@@ -306,8 +306,8 @@ typedef u16 u16_le;
 
 #define EXT_PORT_DDR		0x02	/* BASE+08, IDX+02, B, R/W */
 #define EXT_PORT		0x03	/* BASE+08, IDX+03, B, R/W */
-# define LED_ON	 (0)
-# define LED_OFF BIT(0)
+# define EXT_PORT_LED_ON	(0)
+# define EXT_PORT_LED_OFF	BIT(0)
 
 #define IRQ_SELECT		0x04	/* BASE+08, IDX+04, W, R/W */
 # define IRQSELECT_RESELECT_IRQ      BIT(0)
-- 
2.7.4
