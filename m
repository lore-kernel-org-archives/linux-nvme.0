From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Jan 2018 09:06:42 -0700
Subject: [PATCH resend 2/3] nvme-pci: allocate device queues storage
 space at probe
In-Reply-To: <20180114103902.6413-3-sagi@grimberg.me>
References: <20180114103902.6413-1-sagi@grimberg.me>
 <20180114103902.6413-3-sagi@grimberg.me>
Message-ID: <20180123160641.GA14790@localhost.localdomain>

On Sun, Jan 14, 2018@12:39:01PM +0200, Sagi Grimberg wrote:
> @@ -1590,14 +1580,12 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
>  	if (result < 0)
>  		return result;
>  
> -	nvmeq = dev->queues[0];
> -	if (!nvmeq) {
> -		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
> -					dev_to_node(dev->dev));
> -		if (!nvmeq)
> -			return -ENOMEM;
> -	}
> +	result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
> +			dev_to_node(dev->dev));
> +	if (result)
> +		return result;
>  
> +	nvmeq = &dev->queues[0];
>  	aqa = nvmeq->q_depth - 1;
>  	aqa |= aqa << 16;

This is reallocting the admin queue on each reset, leaking the previous
allocation's SQ/CQ memory, then creates an incorrect queue_count. This
was already applied, so I'll send a quick fix.
