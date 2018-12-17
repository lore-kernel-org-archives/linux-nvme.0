From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 17 Dec 2018 19:24:42 +0800
Subject: [PATCH 2/2] nvme-pci: don't share queue maps
In-Reply-To: <20181217111627.22635-2-hch@lst.de>
References: <20181217111627.22635-1-hch@lst.de>
 <20181217111627.22635-2-hch@lst.de>
Message-ID: <20181217112441.GF1329@ming.t460p>

On Mon, Dec 17, 2018@12:16:27PM +0100, Christoph Hellwig wrote:
> Now that the block layer checks if a queue map has any queues inside
> it there is no more reason to duplicate the maps for the non-default
> types.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fb9d8270f32c..698b350b38cf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -496,11 +496,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		map->nr_queues = dev->io_queues[i];
>  		if (!map->nr_queues) {
>  			BUG_ON(i == HCTX_TYPE_DEFAULT);
> -
> -			/* shared set, resuse read set parameters */
> -			map->nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
> -			qoff = 0;
> -			offset = queue_irq_offset(dev);
> +			continue;
>  		}
>  
>  		/*
> -- 
> 2.19.2
> 

Reviewed-by: Ming Lei <ming.lei at redhat.com>

Thanks,
Ming
