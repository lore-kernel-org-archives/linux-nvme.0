From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 7 May 2019 11:35:28 -0600
Subject: [PATCH v2 3/7] devcoredump: allow to create several coredump
 files in one device
In-Reply-To: <1557248314-4238-4-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-4-git-send-email-akinobu.mita@gmail.com>
Message-ID: <aced1953-4ea2-c8b1-9ee9-068e92ae1f8a@intel.com>



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> @@ -292,6 +309,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   	if (device_add(&devcd->devcd_dev))
>   		goto put_device;
>   
> +	for (i = 0; i < devcd->num_files; i++) {
> +		if (device_create_bin_file(&devcd->devcd_dev,
> +					   &devcd->files[i].bin_attr))
> +			/* nothing - some files will be missing */;

Is the conditional necessary if you aren't going to do anything?

> +	}
> +
>   	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
>   			      "failing_device"))
>   		/* nothing - symlink will be missing */;
