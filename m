From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun, 11 Aug 2019 02:54:57 +0900
Subject: [PATCH v3 0/6] introduce LED block device activity trigger
Message-ID: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>

This work is inspired by the report on linux-nvme mailing list.

disk-activity trigger not working for nvme disk:
http://lists.infradead.org/pipermail/linux-nvme/2019-July/025253.html

This LED block device activity trigger works with any block devices.

* v3
- Avoid the name collision with LED_OFF and LED_ON
- Add ABI documentation
- Add more detail to Kconfig help text

* v2
- Remove "move declaration of led_stop_software_blink() to linux/leds.h" patch
- Move the trigger implementation to drivers/leds/trigger
- s/blk_ledtrig/ledtrig_blk/
- Add CONFIG_LEDS_TRIGGER_BLOCK
- Fix wrong bitops usages
- Add interface to stop and restart polling disk stats
- Stop polling disk stats for scsi disk during runtime suspend

Akinobu Mita (6):
  block: umem: rename LED_* macros to MEMCTRL_LED_*
  scsi: mvsas: rename LED_* enums to SGPIO_LED_*
  scsi: nsp32: rename LED_* macros to EXT_PORT_LED_*
  block: introduce LED block device activity trigger
  ledtrig-blk: add interface to stop and restart polling disk stats
  scsi: sd: stop polling disk stats by ledtrig-blk during runtime
    suspend

 .../ABI/testing/sysfs-class-led-trigger-blk        |  37 +++
 block/genhd.c                                      |   2 +
 drivers/block/umem.c                               |  20 +-
 drivers/block/umem.h                               |  20 +-
 drivers/leds/trigger/Kconfig                       |   9 +
 drivers/leds/trigger/Makefile                      |   1 +
 drivers/leds/trigger/ledtrig-blk.c                 | 258 +++++++++++++++++++++
 drivers/scsi/mvsas/mv_94xx.c                       |   2 +-
 drivers/scsi/mvsas/mv_94xx.h                       |  24 +-
 drivers/scsi/nsp32.c                               |   7 +-
 drivers/scsi/nsp32.h                               |   4 +-
 drivers/scsi/sd.c                                  |  40 ++--
 include/linux/genhd.h                              |   3 +
 include/linux/leds.h                               |  38 +++
 14 files changed, 410 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-blk
 create mode 100644 drivers/leds/trigger/ledtrig-blk.c

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
-- 
2.7.4
