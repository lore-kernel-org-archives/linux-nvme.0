From: keith.busch@intel.com (Keith Busch)
Date: Thu, 4 Jun 2015 22:13:47 +0000 (UTC)
Subject: [PATCH] NVMe: Added IOCTL to initiate subsystem resets
In-Reply-To: <1432936705-30232-1-git-send-email-jonathan.derrick@intel.com>
References: <1432936705-30232-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <alpine.LNX.2.00.1506042209290.15930@localhost.lm.intel.com>

On Fri, 29 May 2015, Jon Derrick wrote:
> Controllers can perform optional subsystem resets as introduced in NVMe
> 1.1. This patch adds an IOCTL to trigger the subsystem reset by writing
> "NVMe" to the NSSR register.

Hi Jon,

Looks good except for one issue below, and then need to merge-up for
another conflict.

> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> ---
> @@ -1861,6 +1870,8 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
> 		return nvme_user_cmd(ns->dev, ns, (void __user *)arg);
> 	case NVME_IOCTL_SUBMIT_IO:
> 		return nvme_submit_io(ns, (void __user *)arg);
> +	case NVME_IOCTL_SUBSYS_RESET:
> +		return nvme_subsys_reset(ns->dev);

This IOCTL belongs only in the "nvme_dev_ioctl" version; we don't want
this capability exposed through namespaces.

> 	case SG_GET_VERSION_NUM:
> 		return nvme_sg_get_version_num((void __user *)arg);
> 	case SG_IO:

> @@ -579,5 +579,6 @@ struct nvme_passthru_cmd {
> #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
> #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
> #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
> +#define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x44)

Will need to change the ioctl number once the single-controller reset
is applied. That patch was in line first, anyway.
