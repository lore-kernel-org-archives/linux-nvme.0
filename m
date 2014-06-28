From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 28 Jun 2014 09:00:04 -0400
Subject: [PATCH] NVMe: Create module parameter for shutdown timeout.
In-Reply-To: <1403256174-3595-1-git-send-email-daniel.mcleran@intel.com>
References: <1403256174-3595-1-git-send-email-daniel.mcleran@intel.com>
Message-ID: <20140628130004.GU12025@linux.intel.com>

On Fri, Jun 20, 2014@03:22:54AM -0600, Dan McLeran wrote:
> @@ -62,6 +63,10 @@ static unsigned char retry_time = 30;
>  module_param(retry_time, byte, 0644);
>  MODULE_PARM_DESC(retry_time, "time in seconds to retry failed I/O");
>  
> +unsigned char nvme_shutdown_timeout = 5;
> +module_param_named(shutdown_timeout, nvme_shutdown_timeout, byte, 0644);
> +MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");

You've copied the pattern for nvme_io_timeout instead of retry_time.
The reason io_timeout has the nvme_ prefix is because it's exposed outside
this file (it's used by nvme-scsi.c).  I don't see a reason to expose
shutdown_timeout outside of nvme-core.c, so retry_time is the pattern to
follow here.

>  static int nvme_major;
>  module_param(nvme_major, int, 0);
>  
> @@ -1428,7 +1433,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
>  	cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
>  	writel(cc, &dev->bar->cc);
>  
> -	timeout = 2 * HZ + jiffies;
> +	timeout = SHUTDOWN_TIMEOUT + jiffies;
>  	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
>  							NVME_CSTS_SHST_CMPLT) {
>  		msleep(100);
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
