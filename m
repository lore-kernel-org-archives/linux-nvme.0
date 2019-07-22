From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon, 22 Jul 2019 23:59:09 +0900
Subject: [PATCH v2 0/3] introduce LED block device activity trigger
Message-ID: <1563807552-23498-1-git-send-email-akinobu.mita@gmail.com>

This work is inspired by the report on linux-nvme mailing list.

disk-activity trigger not working for nvme disk:
http://lists.infradead.org/pipermail/linux-nvme/2019-July/025253.html

This LED block device activity trigger works with any block devices.

* v2
- Remove "move declaration of led_stop_software_blink() to linux/leds.h" patch
- Move the trigger implementation to drivers/leds/trigger
- s/blk_ledtrig/ledtrig_blk/
- Add CONFIG_LEDS_TRIGGER_BLOCK
- Fix wrong bitops usages
- Add interface to stop and restart polling disk stats
- Stop polling disk stats for scsi disk during runtime suspend

Akinobu Mita (3):
  block: introduce LED block device activity trigger
  ledtrig-blk: add interface to stop and restart polling disk stats
  scsi: sd: stop polling disk stats by ledtrig-blk during runtime
    suspend

 block/genhd.c                      |   2 +
 drivers/leds/trigger/Kconfig       |   7 +
 drivers/leds/trigger/Makefile      |   1 +
 drivers/leds/trigger/ledtrig-blk.c | 258 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/sd.c                  |  40 +++---
 include/linux/genhd.h              |   3 +
 include/linux/leds.h               |  38 ++++++
 7 files changed, 332 insertions(+), 17 deletions(-)
 create mode 100644 drivers/leds/trigger/ledtrig-blk.c

Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
Cc: Pavel Machek <pavel at ucw.cz>
Cc: Dan Murphy <dmurphy at ti.com>
Cc: Jens Axboe <axboe at kernel.dk>
Cc: "James E.J. Bottomley" <jejb at linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen at oracle.com>
-- 
2.7.4
