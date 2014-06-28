From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 28 Jun 2014 10:05:05 -0400
Subject: [PATCH] NVMe: Change nvme_enable_ctrl to set EN and manage CC
 thru ctrl_config.
In-Reply-To: <1403533476-7193-1-git-send-email-daniel.mcleran@intel.com>
References: <1403533476-7193-1-git-send-email-daniel.mcleran@intel.com>
Message-ID: <20140628140505.GW12025@linux.intel.com>

On Mon, Jun 23, 2014@08:24:36AM -0600, Dan McLeran wrote:
> @@ -1465,7 +1470,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  	aqa = nvmeq->q_depth - 1;
>  	aqa |= aqa << 16;
>  
> -	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
> +	dev->ctrl_config = NVME_CC_CSS_NVM;
>  	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
>  	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
>  	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;

We also want this, right?

@@ -1512,7 +1512,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev
        writel(aqa, &dev->bar->aqa);
        writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
        writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
-       writel(dev->ctrl_config, &dev->bar->cc);
 
        result = nvme_enable_ctrl(dev, cap);
        if (result)
