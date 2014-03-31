From: daniel.mcleran@intel.com (Dan McLeran)
Date: Mon, 31 Mar 2014 12:56:50 -0600 (Mountain Daylight Time)
Subject: [PATCH] NVMe: Increase shutdown complete time
In-Reply-To: <1396283044-31926-1-git-send-email-keith.busch@intel.com>
References: <1396283044-31926-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.WNT.2.00.1403311256420.4656@DMCLERAN-MOBL.amr.corp.intel.com>

Seems reasonable to me.

On Mon, 31 Mar 2014, Keith Busch wrote:

> The spec doesn't have a recommendation for shutdown beyond "that the host
> wait a minimum of one second for the shutdown operations to complete",
> so we need to choose an arbitrarily value so we don't wait forever but
> high enough to prevent unsafe shutdowns. Some h/w vendors say the previous
> two seconds is not long enough at some capacities. Twenty seconds ought
> to be enough for anybody, right?
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> drivers/block/nvme-core.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 625259d..103da93 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1352,7 +1352,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
> 	cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
> 	writel(cc, &dev->bar->cc);
>
> -	timeout = 2 * HZ + jiffies;
> +	timeout = 20 * HZ + jiffies;
> 	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
> 							NVME_CSTS_SHST_CMPLT) {
> 		msleep(100);
> -- 
> 1.7.10.4
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>
