From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Mon, 12 Aug 2019 21:28:18 +0200
Subject: [PATCH v3 4/6] block: introduce LED block device activity trigger
In-Reply-To: <1565459703-30513-5-git-send-email-akinobu.mita@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
 <1565459703-30513-5-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1b341463-3a0d-93cc-9d76-bbddf5a6e434@gmail.com>

Hi Akinobu,

Thank you for the update. I have one more remark to this patch
below.

On 8/10/19 7:55 PM, Akinobu Mita wrote:
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
> Cc: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
> * v3
> - Add ABI documentation
> - Add more detail to Kconfig help text
> 
>  .../ABI/testing/sysfs-class-led-trigger-blk        |  37 ++++
>  block/genhd.c                                      |   2 +
>  drivers/leds/trigger/Kconfig                       |   9 +
>  drivers/leds/trigger/Makefile                      |   1 +
>  drivers/leds/trigger/ledtrig-blk.c                 | 225 +++++++++++++++++++++
>  include/linux/genhd.h                              |   3 +
>  include/linux/leds.h                               |  27 +++
>  7 files changed, 304 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-blk
>  create mode 100644 drivers/leds/trigger/ledtrig-blk.c
> 
[...]
> +EXPORT_SYMBOL_GPL(ledtrig_blk_unregister);
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 8b5330d..b2c934e 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -17,6 +17,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/uuid.h>
>  #include <linux/blk_types.h>
> +#include <linux/leds.h>
>  #include <asm/local.h>
>  
>  #ifdef CONFIG_BLOCK
> @@ -219,6 +220,8 @@ struct gendisk {
>  	int node_id;
>  	struct badblocks *bb;
>  	struct lockdep_map lockdep_map;
> +
> +	struct ledtrig_blk led;

Please rename this property to led_trig to reflect
its purpose accurately.

>  };
>  
>  static inline struct gendisk *part_to_disk(struct hd_struct *part)
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 9b2bf57..395fa61 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -517,4 +517,31 @@ static inline void ledtrig_audio_set(enum led_audio type,
>  }
>  #endif
>  
> +struct gendisk;
> +
> +#ifdef CONFIG_LEDS_TRIGGER_BLOCK
> +
> +struct ledtrig_blk {
> +	struct led_trigger trig;
> +};
> +
> +int ledtrig_blk_register(struct gendisk *disk);
> +void ledtrig_blk_unregister(struct gendisk *disk);
> +
> +#else
> +
> +struct ledtrig_blk {
> +};
> +
> +static inline int ledtrig_blk_register(struct gendisk *disk)
> +{
> +	return 0;
> +}
> +
> +static inline void ledtrig_blk_unregister(struct gendisk *disk)
> +{
> +}
> +
> +#endif /* CONFIG_LEDS_TRIGGER_BLOCK */
> +
>  #endif		/* __LINUX_LEDS_H_INCLUDED */
> 

-- 
Best regards,
Jacek Anaszewski
