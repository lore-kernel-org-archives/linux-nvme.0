From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Jul 2014 12:33:08 -0600 (MDT)
Subject: [PATCH] NVMe: Write CC before calling enable.
In-Reply-To: <1404229914-6776-1-git-send-email-daniel.mcleran@intel.com>
References: <1404229914-6776-1-git-send-email-daniel.mcleran@intel.com>
Message-ID: <alpine.LRH.2.03.1407021232240.4703@AMR>

On Tue, 1 Jul 2014, Dan McLeran wrote:
> Write the controller configuration register to configure queue sizes,
> memory page size, etc. from within nvme_configure_admin_queue before
> calling nvme_enable_ctrl.

I can see that you're doing that, but why? Is this fixing something?

> Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
> ---
> drivers/block/nvme-core.c |    1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 28aec2d..58281d2 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1512,6 +1512,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
> 	writel(aqa, &dev->bar->aqa);
> 	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
> 	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
> +	writel(dev->ctrl_config, &dev->bar->cc);
>
> 	result = nvme_enable_ctrl(dev, cap);
> 	if (result)
> -- 
> 1.7.10.4
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
