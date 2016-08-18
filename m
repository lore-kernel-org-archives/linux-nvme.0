From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Thu, 18 Aug 2016 10:59:01 +0900
Subject: [PATCH 11/15] zram: Pass attribute group to device_add_disk
In-Reply-To: <1471418115-3654-12-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-12-git-send-email-famz@redhat.com>
Message-ID: <20160818015901.GA499@swordfish>

Hello,

On (08/17/16 15:15), Fam Zheng wrote:
[..]
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 20920a2..2331788 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1298,13 +1298,10 @@ static int zram_add(void)
>  		zram->disk->queue->limits.discard_zeroes_data = 0;
>  	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
>  
> -	device_add_disk(NULL, zram->disk, NULL);
> +	ret = device_add_disk(NULL, zram->disk, &zram_disk_attr_group);
>  
> -	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
> -				&zram_disk_attr_group);
>  	if (ret < 0) {
> -		pr_err("Error creating sysfs group for device %d\n",
> -				device_id);
> +		pr_err("Error creating disk %d\n", device_id);
>  		goto out_free_disk;
>  	}
>  	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));

I like the previous "Error creating sysfs group for device" string better,
than "Error creating disk", because the latter one is much less informative.

do you want to do something like below?

int device_add_disk(struct device *parent, struct gendisk *disk,
...
       if (attr_group) {
               retval = sysfs_create_group(&disk_to_dev(disk)->kobj,
                                           attr_group);

+		pr_err("Error creating sysfs group for device ...\n", ...);

               if (retval)
                       goto fail;
       }

	-ss
