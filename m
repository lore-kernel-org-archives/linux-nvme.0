From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 14:43:58 +0200
Subject: [PATCHv3 2/9] nvme-pci: Fix queue freeze criteria on reset
In-Reply-To: <20180524203500.14081-3-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-3-keith.busch@intel.com>
Message-ID: <20180525124358.GE23463@lst.de>

> +	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE &&

Please throw in a pair of parentheses here.

> +	    (dev->ctrl.state == NVME_CTRL_LIVE ||
> +	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
>  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> -		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> -		    dev->ctrl.state == NVME_CTRL_RESETTING)
> -			nvme_start_freeze(&dev->ctrl);
> +		nvme_start_freeze(&dev->ctrl);

should we same csts after starting the freeze as that might take some
time?

Otherwise this looks fine to me.
