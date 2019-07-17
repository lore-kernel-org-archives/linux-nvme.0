From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 17 Jul 2019 23:27:45 +0900
Subject: [PATCH 2/2] block: introduce LED block device activity trigger
In-Reply-To: <89262967-667f-80cc-0fd5-ba480e879fe0@gmail.com>
References: <1562435939-15466-1-git-send-email-akinobu.mita@gmail.com>
 <1562435939-15466-3-git-send-email-akinobu.mita@gmail.com>
 <89262967-667f-80cc-0fd5-ba480e879fe0@gmail.com>
Message-ID: <CAC5umyjDNh+MP+jLST1sLyFhGsRe-SJCm+KjSOp4ppHqXog3Qw@mail.gmail.com>

2019?7?17?(?) 5:57 Jacek Anaszewski <jacek.anaszewski at gmail.com>:
>
> Hi Akinobu,
>
> Thank you for the patch set. It looks nice in general, but I'd like
> to maintain it under LED subsystem. See my below comments.

Thanks for reviewing. I'll apply your feedback.

> On 7/6/19 7:58 PM, Akinobu Mita wrote:
> > This allows LEDs to be controlled by block device activity.
> >
> > We already have ledtrig-disk (LED disk activity trigger), but the lower
> > level disk drivers need to utilize ledtrig_disk_activity() to make the
> > LED blink.
> >
> > The LED block device trigger doesn't require the lower level drivers to
> > have any instrumentation. The activity is collected by polling the disk
> > stats.
> >
> > Example:
> >
> > echo block-nvme0n1 > /sys/class/leds/diy/trigger
> >
> > Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
> > Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
> > Cc: Pavel Machek <pavel at ucw.cz>
> > Cc: Dan Murphy <dmurphy at ti.com>
> > Cc: Jens Axboe <axboe at kernel.dk>
> > Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> > ---
> >  block/Makefile        |   1 +
> >  block/blk-ledtrig.c   | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  block/blk.h           |  13 +++
> >  block/genhd.c         |   2 +
> >  include/linux/genhd.h |   4 +
> >  5 files changed, 239 insertions(+)
> >  create mode 100644 block/blk-ledtrig.c
> >
> > diff --git a/block/Makefile b/block/Makefile
> > index eee1b4c..c74d84e6 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -35,3 +35,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)  += blk-mq-debugfs.o
> >  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
> >  obj-$(CONFIG_BLK_SED_OPAL)   += sed-opal.o
> >  obj-$(CONFIG_BLK_PM)         += blk-pm.o
> > +obj-$(CONFIG_LEDS_TRIGGERS)  += blk-ledtrig.o
> > diff --git a/block/blk-ledtrig.c b/block/blk-ledtrig.c
>
> Please move the whole trigger implementation to
> drivers/leds/trigger and rename the file to ledtrig-blk.c

OK. Then we don't need to patch 1/2 ("leds: move declaration of
led_stop_software_blink() to linux/leds.h") anymore.

> > new file mode 100644
> > index 0000000..da93b06
> > --- /dev/null
> > +++ b/block/blk-ledtrig.c
> > @@ -0,0 +1,219 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// LED Kernel Blockdev Trigger
> > +// Derived from ledtrig-netdev.c
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/genhd.h>
> > +#include <linux/leds.h>
> > +#include <linux/workqueue.h>
> > +
> > +struct blk_ledtrig_data {
> > +     struct delayed_work work;
> > +     struct led_classdev *led_cdev;
> > +
> > +     atomic_t interval;
> > +     u64 last_activity;
> > +
> > +     unsigned long mode;
> > +#define BLK_LEDTRIG_READ BIT(0)
> > +#define BLK_LEDTRIG_WRITE BIT(1)
> > +#define BLK_LEDTRIG_DISCARD BIT(2)
>
> s/BLK_LEDTRIG/LEDTRIG_BLK/

OK.

> > diff --git a/block/blk.h b/block/blk.h
> > index 7814aa2..dd4c230a 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -331,4 +331,17 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
> >  static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
> >  #endif
> >
> > +#ifdef CONFIG_LEDS_TRIGGERS
> > +int blk_ledtrig_register(struct gendisk *disk);
> > +void blk_ledtrig_unregister(struct gendisk *disk);
> > +#else
> > +static inline int blk_ledtrig_register(struct gendisk *disk)
> > +{
> > +     return 0;
> > +}
> > +static inline void blk_ledtrig_unregister(struct gendisk *disk)
> > +{
> > +}
> > +#endif /* CONFIG_LEDS_TRIGGERS */
>
> Please move this part to include/linux/leds.h, next to the other
> triggers' facilities.

OK.
