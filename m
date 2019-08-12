From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Mon, 12 Aug 2019 21:31:17 +0200
Subject: [PATCH v3 5/6] ledtrig-blk: add interface to stop and restart
 polling disk stats
In-Reply-To: <1565459703-30513-6-git-send-email-akinobu.mita@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
 <1565459703-30513-6-git-send-email-akinobu.mita@gmail.com>
Message-ID: <e1ece602-b413-b391-c7c3-34a8e46254c4@gmail.com>

Hi Akinobu,

I don't see any vital reason to keep this change separately.
We're introducing new trigger, so please just squash it with
the patch 4/6.

Best regards,
Jacek Anaszewski

On 8/10/19 7:55 PM, Akinobu Mita wrote:
> The LED block device activity trigger periodically polls the disk stats
> to collect the activity.  However, it is pointless to poll while the
> block device is in quiescent state.
> 
> This provides an optional interface to stop and restart polling disk stats
> for the lower-level block drivers.
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
>  drivers/leds/trigger/ledtrig-blk.c | 37 +++++++++++++++++++++++++++++++++++--
>  include/linux/leds.h               | 11 +++++++++++
>  2 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-blk.c b/drivers/leds/trigger/ledtrig-blk.c
> index d5808c9..6b826ed 100644
> --- a/drivers/leds/trigger/ledtrig-blk.c
> +++ b/drivers/leds/trigger/ledtrig-blk.c
> @@ -153,8 +153,9 @@ static void ledtrig_blk_work(struct work_struct *work)
>  		trig_data->last_activity = activity;
>  	}
>  
> -	schedule_delayed_work(&trig_data->work,
> -			      atomic_read(&trig_data->interval) * 2);
> +	if (atomic_read(&disk->led.enable_count))
> +		schedule_delayed_work(&trig_data->work,
> +				      atomic_read(&trig_data->interval) * 2);
>  }
>  
>  static int ledtrig_blk_activate(struct led_classdev *led_cdev)
> @@ -190,6 +191,36 @@ static void ledtrig_blk_deactivate(struct led_classdev *led_cdev)
>  	kfree(trig_data);
>  }
>  
> +void ledtrig_blk_disable(struct gendisk *disk)
> +{
> +	if (disk)
> +		atomic_dec(&disk->led.enable_count);
> +}
> +EXPORT_SYMBOL_GPL(ledtrig_blk_disable);
> +
> +void ledtrig_blk_enable(struct gendisk *disk)
> +{
> +	struct led_classdev *led_cdev;
> +
> +	if (!disk)
> +		return;
> +
> +	atomic_inc(&disk->led.enable_count);
> +
> +	read_lock(&disk->led.trig.leddev_list_lock);
> +
> +	list_for_each_entry(led_cdev, &disk->led.trig.led_cdevs, trig_list) {
> +		struct ledtrig_blk_data *trig_data =
> +			led_get_trigger_data(led_cdev);
> +
> +		schedule_delayed_work(&trig_data->work,
> +				      atomic_read(&trig_data->interval) * 2);
> +	}
> +
> +	read_unlock(&disk->led.trig.leddev_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(ledtrig_blk_enable);
> +
>  int ledtrig_blk_register(struct gendisk *disk)
>  {
>  	int ret;
> @@ -203,6 +234,8 @@ int ledtrig_blk_register(struct gendisk *disk)
>  	disk->led.trig.deactivate = ledtrig_blk_deactivate;
>  	disk->led.trig.groups = ledtrig_blk_groups;
>  
> +	atomic_set(&disk->led.enable_count, 1);
> +
>  	ret = led_trigger_register(&disk->led.trig);
>  	if (ret) {
>  		kfree(disk->led.trig.name);
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 395fa61..fd2eb7c 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -523,8 +523,11 @@ struct gendisk;
>  
>  struct ledtrig_blk {
>  	struct led_trigger trig;
> +	atomic_t enable_count;
>  };
>  
> +void ledtrig_blk_enable(struct gendisk *disk);
> +void ledtrig_blk_disable(struct gendisk *disk);
>  int ledtrig_blk_register(struct gendisk *disk);
>  void ledtrig_blk_unregister(struct gendisk *disk);
>  
> @@ -533,6 +536,14 @@ void ledtrig_blk_unregister(struct gendisk *disk);
>  struct ledtrig_blk {
>  };
>  
> +static inline void ledtrig_blk_enable(struct gendisk *disk)
> +{
> +}
> +
> +static inline void ledtrig_blk_disable(struct gendisk *disk)
> +{
> +}
> +
>  static inline int ledtrig_blk_register(struct gendisk *disk)
>  {
>  	return 0;
> 
