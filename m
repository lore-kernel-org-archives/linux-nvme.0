From: David.Sariel@pmcs.com (David Sariel)
Date: Sun, 31 May 2015 12:41:20 +0000
Subject: FW: [PATCH] NVMe: Add reset controller sysfs entry
In-Reply-To: <31FEE40556302F408590926A3C4AC65FED5627AD@BBYEXM01.pmc-sierra.internal>
References: <1428096023-1887-1-git-send-email-keith.busch@intel.com>
 <BN1PR0401MB0931F0B9E7345CA59544CDFBF2FE0@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <31FEE40556302F408590926A3C4AC65FED561E45@BBYEXM01.pmc-sierra.internal>
 <alpine.LNX.2.00.1505121508030.15930@localhost.lm.intel.com>
 <31FEE40556302F408590926A3C4AC65FED5627AD@BBYEXM01.pmc-sierra.internal>
Message-ID: <31FEE40556302F408590926A3C4AC65FED563386@BBYEXM01.pmc-sierra.internal>

Hi Keith, Jens,
Is everything ok with the patch? Do you need anything else from me?
Thanks
D

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of David Sariel
Sent: Monday, May 18, 2015 7:58 PM
To: Keith Busch
Cc: David Darrington; Brandon Schulz; linux-nvme at lists.infradead.org
Subject: RE: [PATCH] NVMe: Add reset controller sysfs entry

Hi Keith
Attaching the patch as a file. I have patched against https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git.
Hope it's ok now. LMK if anything else is needed.
Thanks!
D



-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Tuesday, May 12, 2015 6:11 PM
To: David Sariel
Cc: Brandon Schulz; Keith Busch; linux-nvme at lists.infradead.org; David Darrington
Subject: RE: [PATCH] NVMe: Add reset controller sysfs entry

On Sun, 3 May 2015, David Sariel wrote:
> Hi Keith, Brandon,
> It took me a while to get hands on it. Attaching the patch according to Keith's remarks:

Could you send this in a format that can be applied? We need a proper patch with commit log, and I think your email client is mucking up the formatting.

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

This is actually useful upstream as well if we don't want to rely on the pci reset to hook into NVMe controller resets. Sometimes we don't even have pci reset available.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: reset_ioctl.patch
Type: application/octet-stream
Size: 1331 bytes
Desc: reset_ioctl.patch
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150531/eb9e762e/attachment.obj>
