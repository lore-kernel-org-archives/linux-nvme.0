From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun,  7 Jul 2019 02:58:57 +0900
Subject: [PATCH 0/2] introduce LED block device activity trigger
Message-ID: <1562435939-15466-1-git-send-email-akinobu.mita@gmail.com>

This work is inspired by the recent report on linux-nvme mailing list.

disk-activity trigger not working for nvme disk:
http://lists.infradead.org/pipermail/linux-nvme/2019-July/025253.html

This LED block device activity trigger works with any block devices.

Akinobu Mita (2):
  leds: move declaration of led_stop_software_blink() to linux/leds.h
  block: introduce LED block device activity trigger

 block/Makefile        |   1 +
 block/blk-ledtrig.c   | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h           |  13 +++
 block/genhd.c         |   2 +
 drivers/leds/leds.h   |   1 -
 include/linux/genhd.h |   4 +
 include/linux/leds.h  |   2 +
 7 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-ledtrig.c

Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
Cc: Pavel Machek <pavel at ucw.cz>
Cc: Dan Murphy <dmurphy at ti.com>
Cc: Jens Axboe <axboe at kernel.dk>
-- 
2.7.4
