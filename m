From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 29 May 2014 09:53:12 -0700
Subject: [PATCH] NVMe: Prevent possible NULL pointer dereference
In-Reply-To: <1401337912-2691-1-git-send-email-santosh.sy@samsung.com>
References: <1401337912-2691-1-git-send-email-santosh.sy@samsung.com>
Message-ID: <538765F8.4020002@linux.intel.com>

On 05/28/2014 09:31 PM, Santosh Y wrote:
> kmalloc() used by the nvme_alloc_iod() to allocate memory for 'iod'
> can fail. So check the return value.
>
> Signed-off-by: Santosh Y <santosh.sy at samsung.com>
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index cd8a8bc7..b089459 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1488,7 +1488,11 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
>   		goto put_pages;
>   	}
>
> +	err = -ENOMEM;
>   	iod = nvme_alloc_iod(count, length, GFP_KERNEL);
> +	if (!iod)
> +		goto put_pages;
> +
>   	sg = iod->sg;
>   	sg_init_table(sg, count);
>   	for (i = 0; i < count; i++) {
> @@ -1501,7 +1505,6 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
>   	sg_mark_end(&sg[i - 1]);
>   	iod->nents = count;
>
> -	err = -ENOMEM;

I am not that familiar with this nvme code yet, but should this 
statement be left in?  It looks to me that this 'err = -ENOMEM;' 
assignment is for the case if dma_map_sg() statement below it fails.

>   	nents = dma_map_sg(&dev->pci_dev->dev, sg, count,
>   				write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
>   	if (!nents)
>
