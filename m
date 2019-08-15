From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 16 Aug 2019 01:59:55 +0900
Subject: [PATCH v4 1/5] block: umem: rename LED_* macros to MEMCTRL_LED_*
In-Reply-To: <1565888399-21550-1-git-send-email-akinobu.mita@gmail.com>
References: <1565888399-21550-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1565888399-21550-2-git-send-email-akinobu.mita@gmail.com>

The umem driver defines LED_* macros for MEMCTRLCMD_LEDCTRL register
values.  The LED_OFF and LED_ON macros conflict with the LED subsystem's
LED_OFF and LED_ON enums.

This renames these LED_* macros to MEMCTRL_LED_* in umem driver.

Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
Cc: Pavel Machek <pavel at ucw.cz>
Cc: Dan Murphy <dmurphy at ti.com>
Cc: Jens Axboe <axboe at kernel.dk>
Cc: "James E.J. Bottomley" <jejb at linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen at oracle.com>
Cc: Hannes Reinecke <hare at suse.com>
Acked-by: Pavel Machek <pavel at ucw.cz>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/block/umem.c | 20 ++++++++++----------
 drivers/block/umem.h | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 1f3f9e0..1109308 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -167,14 +167,14 @@ static int set_userbit(struct cardinfo *card, int bit, unsigned char state)
 }
 
 /*
- * NOTE: For the power LED, use the LED_POWER_* macros since they differ
+ * NOTE: For the power LED, use the MEMCTRL_LED_POWER_* macros since they differ
  */
 static void set_led(struct cardinfo *card, int shift, unsigned char state)
 {
 	unsigned char led;
 
 	led = readb(card->csr_remap + MEMCTRLCMD_LEDCTRL);
-	if (state == LED_FLIP)
+	if (state == MEMCTRL_LED_FLIP)
 		led ^= (1<<shift);
 	else {
 		led &= ~(0x03 << shift);
@@ -268,7 +268,7 @@ static void mm_start_io(struct cardinfo *card)
 
 
 	if (debug & DEBUG_LED_ON_TRANSFER)
-		set_led(card, LED_REMOVE, LED_ON);
+		set_led(card, MEMCTRL_LED_REMOVE, MEMCTRL_LED_ON);
 
 	desc = &page->desc[page->headcnt];
 	writel(0, card->csr_remap + DMA_PCI_ADDR);
@@ -477,7 +477,7 @@ static void process_page(unsigned long data)
 	}
 
 	if (debug & DEBUG_LED_ON_TRANSFER)
-		set_led(card, LED_REMOVE, LED_OFF);
+		set_led(card, MEMCTRL_LED_REMOVE, MEMCTRL_LED_OFF);
 
 	if (card->check_batteries) {
 		card->check_batteries = 0;
@@ -652,13 +652,13 @@ HW_TRACE(0x36);
 static void set_fault_to_battery_status(struct cardinfo *card)
 {
 	if (card->battery[0].good && card->battery[1].good)
-		set_led(card, LED_FAULT, LED_OFF);
+		set_led(card, MEMCTRL_LED_FAULT, MEMCTRL_LED_OFF);
 	else if (card->battery[0].warned || card->battery[1].warned)
-		set_led(card, LED_FAULT, LED_ON);
+		set_led(card, MEMCTRL_LED_FAULT, MEMCTRL_LED_ON);
 	else if (!card->battery[0].good && !card->battery[1].good)
-		set_led(card, LED_FAULT, LED_FLASH_7_0);
+		set_led(card, MEMCTRL_LED_FAULT, MEMCTRL_LED_FLASH_7_0);
 	else
-		set_led(card, LED_FAULT, LED_FLASH_3_5);
+		set_led(card, MEMCTRL_LED_FAULT, MEMCTRL_LED_FLASH_3_5);
 }
 
 static void init_battery_timer(void);
@@ -919,8 +919,8 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	/* Clear the LED's we control */
-	set_led(card, LED_REMOVE, LED_OFF);
-	set_led(card, LED_FAULT, LED_OFF);
+	set_led(card, MEMCTRL_LED_REMOVE, MEMCTRL_LED_OFF);
+	set_led(card, MEMCTRL_LED_FAULT, MEMCTRL_LED_OFF);
 
 	batt_status = readb(card->csr_remap + MEMCTRLSTATUS_BATTERY);
 
diff --git a/drivers/block/umem.h b/drivers/block/umem.h
index 5838497..cc9cb37 100644
--- a/drivers/block/umem.h
+++ b/drivers/block/umem.h
@@ -32,16 +32,16 @@
 #define  MEM_2_GB		0xe0
 
 #define MEMCTRLCMD_LEDCTRL	0x08
-#define  LED_REMOVE		2
-#define  LED_FAULT		4
-#define  LED_POWER		6
-#define	 LED_FLIP		255
-#define  LED_OFF		0x00
-#define  LED_ON			0x01
-#define  LED_FLASH_3_5		0x02
-#define  LED_FLASH_7_0		0x03
-#define  LED_POWER_ON		0x00
-#define  LED_POWER_OFF		0x01
+#define  MEMCTRL_LED_REMOVE	2
+#define  MEMCTRL_LED_FAULT	4
+#define  MEMCTRL_LED_POWER	6
+#define  MEMCTRL_LED_FLIP	255
+#define  MEMCTRL_LED_OFF	0x00
+#define  MEMCTRL_LED_ON		0x01
+#define  MEMCTRL_LED_FLASH_3_5	0x02
+#define  MEMCTRL_LED_FLASH_7_0	0x03
+#define  MEMCTRL_LED_POWER_ON	0x00
+#define  MEMCTRL_LED_POWER_OFF	0x01
 #define  USER_BIT1		0x01
 #define  USER_BIT2		0x02
 
-- 
2.7.4
