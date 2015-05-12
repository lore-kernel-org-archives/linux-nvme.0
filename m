From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 May 2015 15:10:47 +0000 (UTC)
Subject: [PATCH] NVMe: Add reset controller sysfs entry
In-Reply-To: <31FEE40556302F408590926A3C4AC65FED561E45@BBYEXM01.pmc-sierra.internal>
References: <1428096023-1887-1-git-send-email-keith.busch@intel.com>
 <BN1PR0401MB0931F0B9E7345CA59544CDFBF2FE0@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <31FEE40556302F408590926A3C4AC65FED561E45@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1505121508030.15930@localhost.lm.intel.com>

On Sun, 3 May 2015, David Sariel wrote:
> Hi Keith, Brandon,
> It took me a while to get hands on it. Attaching the patch according to Keith's remarks:

Could you send this in a format that can be applied? We need a proper
patch with commit log, and I think your email client is mucking up
the formatting.

> diff -uprN a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> --- a/drivers/block/nvme-core.c	2014-09-06 02:37:11.000000000 +0300
> +++ b/drivers/block/nvme-core.c	2015-05-03 21:05:12.000000000 +0300
> @@ -2627,6 +2627,18 @@ static long nvme_dev_ioctl(struct file *
> 	switch (cmd) {
> 	case NVME_IOCTL_ADMIN_CMD:
> 		return nvme_user_admin_cmd(dev, (void __user *)arg);
> +	case NVME_IOCTL_RESET:
> +        if(work_busy(&dev->reset_work) )
> +        	return -EBUSY;
> +
> +        dev_warn(&dev->pci_dev->dev, "resetting controller\n");
> +        dev->reset_workfn = nvme_reset_failed_dev;
> +        queue_work(nvme_workq, &dev->reset_work);
> +
> +        /* Wait for a work to finish executing the last queueing instance */
> +        flush_work(&dev->reset_work);
> +
> +		return 0;
> 	default:
> 		return -ENOTTY;
> 	}
> diff -uprN a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
> --- a/include/uapi/linux/nvme.h	2014-09-06 02:37:11.000000000 +0300
> +++ b/include/uapi/linux/nvme.h	2015-05-03 21:05:30.000000000 +0300
> @@ -513,5 +513,7 @@ struct nvme_admin_cmd {
> #define NVME_IOCTL_ID		_IO('N', 0x40)
> #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
> #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
> +/* 0x43 is used by nvme-cli */
> +#define NVME_IOCTL_RESET  _IO('N', 0x44)
>
> #endif /* _UAPI_LINUX_NVME_H */
>
>
> Although the use case is for the reset is for pre 3.15 kernels, I guess that the patch should be applied to the latest kernel. Am I right?

This is actually useful upstream as well if we don't want to rely on
the pci reset to hook into NVMe controller resets. Sometimes we don't
even have pci reset available.
