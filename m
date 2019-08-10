From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun, 11 Aug 2019 02:54:59 +0900
Subject: [PATCH v3 2/6] scsi: mvsas: rename LED_* enums to SGPIO_LED_*
In-Reply-To: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1565459703-30513-3-git-send-email-akinobu.mita@gmail.com>

The mvsas driver declares LED_* enums for enum sgpio_led_status. The
LED_OFF and LED_ON enums cause redeclaration of enumerator with the
LED subsystem's LED_OFF and LED_ON enums.

This adds 'SGPIO_' prefix to these enums in mvsas driver.

Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
Cc: Pavel Machek <pavel at ucw.cz>
Cc: Dan Murphy <dmurphy at ti.com>
Cc: Jens Axboe <axboe at kernel.dk>
Cc: "James E.J. Bottomley" <jejb at linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen at oracle.com>
Cc: Hannes Reinecke <hare at suse.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Acked-by: Pavel Machek <pavel at ucw.cz>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/scsi/mvsas/mv_94xx.c |  2 +-
 drivers/scsi/mvsas/mv_94xx.h | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_94xx.c b/drivers/scsi/mvsas/mv_94xx.c
index fc0b8eb..3558a625 100644
--- a/drivers/scsi/mvsas/mv_94xx.c
+++ b/drivers/scsi/mvsas/mv_94xx.c
@@ -1085,7 +1085,7 @@ static int mvs_94xx_gpio_write(struct mvs_prv_info *mvs_prv,
 				block &= ~((0x7 << MVS_SGPIO_DCTRL_ACT_SHIFT)
 					<< driveshift);
 					/* hardwire activity bit to SOF */
-				block |= LED_BLINKA_SOF << (
+				block |= SGPIO_LED_BLINKA_SOF << (
 					MVS_SGPIO_DCTRL_ACT_SHIFT +
 					driveshift);
 				break;
diff --git a/drivers/scsi/mvsas/mv_94xx.h b/drivers/scsi/mvsas/mv_94xx.h
index a243182..2c96ff1 100644
--- a/drivers/scsi/mvsas/mv_94xx.h
+++ b/drivers/scsi/mvsas/mv_94xx.h
@@ -275,23 +275,23 @@ enum sgpio_registers {
 };
 
 enum sgpio_led_status {
-	LED_OFF	= 0,
-	LED_ON	= 1,
-	LED_BLINKA	= 2,
-	LED_BLINKA_INV	= 3,
-	LED_BLINKA_SOF	= 4,
-	LED_BLINKA_EOF	= 5,
-	LED_BLINKB	= 6,
-	LED_BLINKB_INV	= 7,
+	SGPIO_LED_OFF		= 0,
+	SGPIO_LED_ON		= 1,
+	SGPIO_LED_BLINKA	= 2,
+	SGPIO_LED_BLINKA_INV	= 3,
+	SGPIO_LED_BLINKA_SOF	= 4,
+	SGPIO_LED_BLINKA_EOF	= 5,
+	SGPIO_LED_BLINKB	= 6,
+	SGPIO_LED_BLINKB_INV	= 7,
 };
 
-#define DEFAULT_SGPIO_BITS ((LED_BLINKA_SOF << \
+#define DEFAULT_SGPIO_BITS ((SGPIO_LED_BLINKA_SOF << \
 				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 3) | \
-			(LED_BLINKA_SOF << \
+			(SGPIO_LED_BLINKA_SOF << \
 				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 2) | \
-			(LED_BLINKA_SOF << \
+			(SGPIO_LED_BLINKA_SOF << \
 				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 1) | \
-			(LED_BLINKA_SOF << \
+			(SGPIO_LED_BLINKA_SOF << \
 				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 0))
 
 /*
-- 
2.7.4
