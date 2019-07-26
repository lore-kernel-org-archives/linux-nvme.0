From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Fri, 26 Jul 2019 23:22:10 +0200
Subject: [PATCH v2 1/3] block: introduce LED block device activity trigger
In-Reply-To: <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
References: <1563807552-23498-1-git-send-email-akinobu.mita@gmail.com>
 <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <44a6093f-7df7-9442-c33b-5827eb5f187b@gmail.com>

Hi Akinobu,

Thank you for the v2. I've checked and it works as expected.

One thing is missing though - ABI documentation.

Please add Documentation/ABI/testing/sysfs-class-led-trigger-blk
and document read, write and discard files.

Best regards,
Jacek Anaszewski

On 7/22/19 4:59 PM, Akinobu Mita wrote:
> This allows LEDs to be controlled by block device activity.
> 
> We already have ledtrig-disk (LED disk activity trigger), but the lower
> level disk drivers need to utilize ledtrig_disk_activity() to make the
> LED blink.
> 
> The LED block device trigger doesn't require the lower level drivers to
> have any instrumentation. The activity is collected by polling the disk
> stats.
> 
> Example:
> 
> echo block-nvme0n1 > /sys/class/leds/diy/trigger
> 
> Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
> Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
> Cc: Pavel Machek <pavel at ucw.cz>
> Cc: Dan Murphy <dmurphy at ti.com>
> Cc: Jens Axboe <axboe at kernel.dk>
> Cc: "James E.J. Bottomley" <jejb at linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen at oracle.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
>  block/genhd.c                      |   2 +
>  drivers/leds/trigger/Kconfig       |   7 ++
>  drivers/leds/trigger/Makefile      |   1 +
>  drivers/leds/trigger/ledtrig-blk.c | 225 +++++++++++++++++++++++++++++++++++++
>  include/linux/genhd.h              |   3 +
>  include/linux/leds.h               |  27 +++++
>  6 files changed, 265 insertions(+)
>  create mode 100644 drivers/leds/trigger/ledtrig-blk.c
[...]
