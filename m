From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Tue, 16 Jul 2019 22:57:54 +0200
Subject: [PATCH 2/2] block: introduce LED block device activity trigger
In-Reply-To: <1562435939-15466-3-git-send-email-akinobu.mita@gmail.com>
References: <1562435939-15466-1-git-send-email-akinobu.mita@gmail.com>
 <1562435939-15466-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <89262967-667f-80cc-0fd5-ba480e879fe0@gmail.com>

Hi Akinobu,

Thank you for the patch set. It looks nice in general, but I'd like
to maintain it under LED subsystem. See my below comments.

On 7/6/19 7:58 PM, Akinobu Mita wrote:
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
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
>  block/Makefile        |   1 +
>  block/blk-ledtrig.c   | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk.h           |  13 +++
>  block/genhd.c         |   2 +
>  include/linux/genhd.h |   4 +
>  5 files changed, 239 insertions(+)
>  create mode 100644 block/blk-ledtrig.c
> 
> diff --git a/block/Makefile b/block/Makefile
> index eee1b4c..c74d84e6 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
>  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
>  obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
>  obj-$(CONFIG_BLK_PM)		+= blk-pm.o
> +obj-$(CONFIG_LEDS_TRIGGERS)	+= blk-ledtrig.o
> diff --git a/block/blk-ledtrig.c b/block/blk-ledtrig.c

Please move the whole trigger implementation to
drivers/leds/trigger and rename the file to ledtrig-blk.c

> new file mode 100644
> index 0000000..da93b06
> --- /dev/null
> +++ b/block/blk-ledtrig.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// LED Kernel Blockdev Trigger
> +// Derived from ledtrig-netdev.c
> +
> +#include <linux/atomic.h>
> +#include <linux/genhd.h>
> +#include <linux/leds.h>
> +#include <linux/workqueue.h>
> +
> +struct blk_ledtrig_data {
> +	struct delayed_work work;
> +	struct led_classdev *led_cdev;
> +
> +	atomic_t interval;
> +	u64 last_activity;
> +
> +	unsigned long mode;
> +#define BLK_LEDTRIG_READ BIT(0)
> +#define BLK_LEDTRIG_WRITE BIT(1)
> +#define BLK_LEDTRIG_DISCARD BIT(2)

s/BLK_LEDTRIG/LEDTRIG_BLK/

> +};
> +
> +static ssize_t blk_ledtrig_attr_show(struct device *dev, char *buf,
> +				     unsigned long blk_ledtrig)
> +{
> +	struct blk_ledtrig_data *trig_data = led_trigger_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", test_bit(blk_ledtrig, &trig_data->mode));
> +}
> +
> +static ssize_t blk_ledtrig_attr_store(struct device *dev, const char *buf,
> +				      size_t size, unsigned long blk_ledtrig)
> +{
> +	struct blk_ledtrig_data *trig_data = led_trigger_get_drvdata(dev);
> +	unsigned long state;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 0, &state);
> +	if (ret)
> +		return ret;
> +
> +	if (state)
> +		set_bit(blk_ledtrig, &trig_data->mode);
> +	else
> +		clear_bit(blk_ledtrig, &trig_data->mode);
> +
> +	return size;
> +}
> +
> +static ssize_t read_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	return blk_ledtrig_attr_show(dev, buf, BLK_LEDTRIG_READ);
> +}
> +static ssize_t read_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t size)
> +{
> +	return blk_ledtrig_attr_store(dev, buf, size, BLK_LEDTRIG_READ);
> +}
> +static DEVICE_ATTR_RW(read);
> +
> +static ssize_t write_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	return blk_ledtrig_attr_show(dev, buf, BLK_LEDTRIG_WRITE);
> +}
> +static ssize_t write_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t size)
> +{
> +	return blk_ledtrig_attr_store(dev, buf, size, BLK_LEDTRIG_WRITE);
> +}
> +static DEVICE_ATTR_RW(write);
> +
> +static ssize_t discard_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	return blk_ledtrig_attr_show(dev, buf, BLK_LEDTRIG_DISCARD);
> +}
> +static ssize_t discard_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t size)
> +{
> +	return blk_ledtrig_attr_store(dev, buf, size, BLK_LEDTRIG_DISCARD);
> +}
> +static DEVICE_ATTR_RW(discard);
> +
> +static ssize_t interval_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct blk_ledtrig_data *trig_data = led_trigger_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n",
> +		       jiffies_to_msecs(atomic_read(&trig_data->interval)));
> +}
> +static ssize_t interval_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t size)
> +{
> +	struct blk_ledtrig_data *trig_data = led_trigger_get_drvdata(dev);
> +	unsigned long value;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 0, &value);
> +	if (ret)
> +		return ret;
> +
> +	/* impose some basic bounds on the timer interval */
> +	if (value >= 5 && value <= 10000) {
> +		cancel_delayed_work_sync(&trig_data->work);
> +		atomic_set(&trig_data->interval, msecs_to_jiffies(value));
> +		schedule_delayed_work(&trig_data->work,
> +				      atomic_read(&trig_data->interval) * 2);
> +	}
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(interval);
> +
> +static struct attribute *blk_ledtrig_attrs[] = {
> +	&dev_attr_read.attr,
> +	&dev_attr_write.attr,
> +	&dev_attr_discard.attr,
> +	&dev_attr_interval.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(blk_ledtrig);
> +
> +static void blk_ledtrig_work(struct work_struct *work)
> +{
> +	struct blk_ledtrig_data *trig_data =
> +		container_of(work, struct blk_ledtrig_data, work.work);
> +	struct gendisk *disk = container_of(trig_data->led_cdev->trigger,
> +					    struct gendisk, led_trig);
> +	u64 activity = 0;
> +
> +	if (test_bit(BLK_LEDTRIG_READ, &trig_data->mode))
> +		activity += part_stat_read(&disk->part0, ios[STAT_READ]);
> +	if (test_bit(BLK_LEDTRIG_WRITE, &trig_data->mode))
> +		activity += part_stat_read(&disk->part0, ios[STAT_WRITE]);
> +	if (test_bit(BLK_LEDTRIG_DISCARD, &trig_data->mode))
> +		activity += part_stat_read(&disk->part0, ios[STAT_DISCARD]);
> +
> +	if (trig_data->last_activity != activity) {
> +		unsigned long interval;
> +
> +		led_stop_software_blink(trig_data->led_cdev);
> +		interval = jiffies_to_msecs(atomic_read(&trig_data->interval));
> +		led_blink_set_oneshot(trig_data->led_cdev, &interval, &interval,
> +				      0);
> +
> +		trig_data->last_activity = activity;
> +	}
> +
> +	schedule_delayed_work(&trig_data->work,
> +			      atomic_read(&trig_data->interval) * 2);
> +}
> +
> +static int blk_ledtrig_activate(struct led_classdev *led_cdev)
> +{
> +	struct blk_ledtrig_data *trig_data;
> +
> +	trig_data = kzalloc(sizeof(*trig_data), GFP_KERNEL);
> +	if (!trig_data)
> +		return -ENOMEM;
> +
> +	trig_data->mode = BLK_LEDTRIG_READ | BLK_LEDTRIG_WRITE |
> +			  BLK_LEDTRIG_DISCARD;
> +
> +	atomic_set(&trig_data->interval, msecs_to_jiffies(50));
> +	trig_data->last_activity = 0;
> +	trig_data->led_cdev = led_cdev;
> +
> +	INIT_DELAYED_WORK(&trig_data->work, blk_ledtrig_work);
> +
> +	led_set_trigger_data(led_cdev, trig_data);
> +
> +	schedule_delayed_work(&trig_data->work,
> +			      atomic_read(&trig_data->interval) * 2);
> +
> +	return 0;
> +}
> +
> +static void blk_ledtrig_deactivate(struct led_classdev *led_cdev)
> +{
> +	struct blk_ledtrig_data *trig_data = led_get_trigger_data(led_cdev);
> +
> +	cancel_delayed_work_sync(&trig_data->work);
> +	kfree(trig_data);
> +}
> +
> +int blk_ledtrig_register(struct gendisk *disk)
> +{
> +	int ret;
> +
> +	disk->led_trig.name = kasprintf(GFP_KERNEL, "block-%s",
> +					disk->disk_name);
> +	if (!disk->led_trig.name)
> +		return -ENOMEM;
> +
> +	disk->led_trig.activate = blk_ledtrig_activate;
> +	disk->led_trig.deactivate = blk_ledtrig_deactivate;
> +	disk->led_trig.groups = blk_ledtrig_groups;
> +
> +	ret = led_trigger_register(&disk->led_trig);
> +	if (ret) {
> +		kfree(disk->led_trig.name);
> +		disk->led_trig.name = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +void blk_ledtrig_unregister(struct gendisk *disk)
> +{
> +	if (!disk->led_trig.name)
> +		return;
> +
> +	led_trigger_unregister(&disk->led_trig);
> +	kfree(disk->led_trig.name);
> +	disk->led_trig.name = NULL;
> +}
> diff --git a/block/blk.h b/block/blk.h
> index 7814aa2..dd4c230a 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -331,4 +331,17 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
>  static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
>  #endif
>  
> +#ifdef CONFIG_LEDS_TRIGGERS
> +int blk_ledtrig_register(struct gendisk *disk);
> +void blk_ledtrig_unregister(struct gendisk *disk);
> +#else
> +static inline int blk_ledtrig_register(struct gendisk *disk)
> +{
> +	return 0;
> +}
> +static inline void blk_ledtrig_unregister(struct gendisk *disk)
> +{
> +}
> +#endif /* CONFIG_LEDS_TRIGGERS */

Please move this part to include/linux/leds.h, next to the other
triggers' facilities.

>  #endif /* BLK_INTERNAL_H */
> diff --git a/block/genhd.c b/block/genhd.c
> index 24654e1..dfd210c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -745,6 +745,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  
>  	disk_add_events(disk);
>  	blk_integrity_add(disk);
> +	blk_ledtrig_register(disk);
>  }
>  
>  void device_add_disk(struct device *parent, struct gendisk *disk,
> @@ -766,6 +767,7 @@ void del_gendisk(struct gendisk *disk)
>  	struct disk_part_iter piter;
>  	struct hd_struct *part;
>  
> +	blk_ledtrig_unregister(disk);
>  	blk_integrity_del(disk);
>  	disk_del_events(disk);
>  
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 8b5330d..9250e9c 100644
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
> @@ -219,6 +220,9 @@ struct gendisk {
>  	int node_id;
>  	struct badblocks *bb;
>  	struct lockdep_map lockdep_map;
> +#ifdef CONFIG_LEDS_TRIGGERS
> +	struct led_trigger led_trig;
> +#endif
>  };
>  
>  static inline struct gendisk *part_to_disk(struct hd_struct *part)
> 

-- 
Best regards,
Jacek Anaszewski
