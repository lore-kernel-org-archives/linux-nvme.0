From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 23 Jul 2019 22:58:42 +0900
Subject: [PATCH v2 2/3] nvme: move sqsize setting to the core
In-Reply-To: <20190723000654.6448-3-sagi@grimberg.me>
References: <20190723000654.6448-1-sagi@grimberg.me>
 <20190723000654.6448-3-sagi@grimberg.me>
Message-ID: <20190723135842.GE7148@minwoo-desktop>

On 19-07-22 17:06:53, Sagi Grimberg wrote:
> nvme_enable_ctrl reads the cap register right after, so
> no need to do that locally in the transport driver. Have
> sqsize setting in nvme_init_identify.

Okay, I think it looks better.  Please ignore my comments on previous
patch, but the review tag :)


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index bb970ca82517..e11d50599a51 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1695,7 +1695,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
>  	lo_hi_writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
>  	lo_hi_writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
>  
> -	result = nvme_enable_ctrl(&dev->ctrl, dev->ctrl.cap);
> +	result = nvme_enable_ctrl(&dev->ctrl);
>  	if (result)
>  		return result;
>  
> @@ -2316,6 +2316,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  
>  	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
>  				io_queue_depth);
> +	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */

Sagi,

It seems like could be split into another commit, couldn't it?  It's
because that PCIe host driver never set the sqsize in my experience.  If
so, can we have it in another commit?

If I miss something here, please let me know :)

Thanks,
	Minwoo Im
