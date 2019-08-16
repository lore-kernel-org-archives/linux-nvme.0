From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Fri, 16 Aug 2019 21:52:25 +0200
Subject: [PATCH v4 5/5] scsi: sd: stop polling disk stats by ledtrig-blk
 during runtime suspend
In-Reply-To: <1565888399-21550-6-git-send-email-akinobu.mita@gmail.com>
References: <1565888399-21550-1-git-send-email-akinobu.mita@gmail.com>
 <1565888399-21550-6-git-send-email-akinobu.mita@gmail.com>
Message-ID: <aed1b43e-0857-ac5c-2887-c9b444a6b51f@gmail.com>

Hi Akinobu,

Thank you for the update.

Previously I forgot to mention one more thing - this patch does more
than it declares in the commit message, i.e. in addition to what is
declared it uses new ledtrig-blk trigger by calling
ledtrig_blk_enable()/ledtrig_blk_disable().

Those should be definitely split into a separate patch, preceding the
changes required for stopping polling disk stats.

Best regards,
Jacek Anaszewski

On 8/15/19 6:59 PM, Akinobu Mita wrote:
> The LED block device activity trigger periodically polls the disk stats
> to collect the activity.  However, it is pointless to poll while the
> scsi device is in runtime suspend.
> 
> This stops polling disk stats when the device is successfully runtime
> suspended, and restarts polling when the device is successfully runtime
> resumed.
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
>  drivers/scsi/sd.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 149d406..5f73142 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3538,7 +3538,7 @@ static int sd_suspend_common(struct device *dev, bool ignore_stop_errors)
>  {
>  	struct scsi_disk *sdkp = dev_get_drvdata(dev);
>  	struct scsi_sense_hdr sshdr;
> -	int ret = 0;
> +	int ret;
>  
>  	if (!sdkp)	/* E.g.: runtime suspend following sd_remove() */
>  		return 0;
> @@ -3550,18 +3550,16 @@ static int sd_suspend_common(struct device *dev, bool ignore_stop_errors)
>  		if (ret) {
>  			/* ignore OFFLINE device */
>  			if (ret == -ENODEV)
> -				return 0;
> -
> -			if (!scsi_sense_valid(&sshdr) ||
> -			    sshdr.sense_key != ILLEGAL_REQUEST)
> -				return ret;
> +				goto success;
>  
>  			/*
>  			 * sshdr.sense_key == ILLEGAL_REQUEST means this drive
>  			 * doesn't support sync. There's not much to do and
>  			 * suspend shouldn't fail.
>  			 */
> -			ret = 0;
> +			if (!scsi_sense_valid(&sshdr) ||
> +			    sshdr.sense_key != ILLEGAL_REQUEST)
> +				return ret;
>  		}
>  	}
>  
> @@ -3569,11 +3567,14 @@ static int sd_suspend_common(struct device *dev, bool ignore_stop_errors)
>  		sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
>  		/* an error is not worth aborting a system sleep */
>  		ret = sd_start_stop_device(sdkp, 0);
> -		if (ignore_stop_errors)
> -			ret = 0;
> +		if (ret && !ignore_stop_errors)
> +			return ret;
>  	}
>  
> -	return ret;
> +success:
> +	ledtrig_blk_disable(sdkp->disk);
> +
> +	return 0;
>  }
>  
>  static int sd_suspend_system(struct device *dev)
> @@ -3589,19 +3590,24 @@ static int sd_suspend_runtime(struct device *dev)
>  static int sd_resume(struct device *dev)
>  {
>  	struct scsi_disk *sdkp = dev_get_drvdata(dev);
> -	int ret;
>  
>  	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
>  		return 0;
>  
> -	if (!sdkp->device->manage_start_stop)
> -		return 0;
> +	if (sdkp->device->manage_start_stop) {
> +		int ret;
> +
> +		sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
> +		ret = sd_start_stop_device(sdkp, 1);
> +		if (ret)
> +			return ret;
>  
> -	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
> -	ret = sd_start_stop_device(sdkp, 1);
> -	if (!ret)
>  		opal_unlock_from_suspend(sdkp->opal_dev);
> -	return ret;
> +	}
> +
> +	ledtrig_blk_enable(sdkp->disk);
> +
> +	return 0;
>  }
>  
>  /**
> 
