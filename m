From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:30:38 +0000
Subject: [PATCH 12/15] nvme-pci: remove the inline scatterlist optimization
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-13-hch@lst.de>
Message-ID: <SN6PR04MB4527EDD559B724430E1CA017865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:12 PM, Christoph Hellwig wrote:
> We'll have a better way to optimize for small I/O that doesn't
> require it soon, so remove the existing inline_sg case to make that
> optimization easier to implement.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 38 ++++++--------------------------------
>   1 file changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cf29d079ad5b..c6047935e825 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -223,7 +223,6 @@ struct nvme_iod {
>   	dma_addr_t first_dma;
>   	dma_addr_t meta_dma;
>   	struct scatterlist *sg;
> -	struct scatterlist inline_sg[0];
>   };
>   
>   /*
> @@ -370,12 +369,6 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>   	return true;
>   }
>   
> -/*
> - * Max size of iod being embedded in the request payload
> - */
> -#define NVME_INT_PAGES		2
> -#define NVME_INT_BYTES(dev)	(NVME_INT_PAGES * (dev)->ctrl.page_size)
> -
>   /*
>    * Will slightly overestimate the number of pages needed.  This is OK
>    * as it only leads to a small amount of wasted memory for the lifetime of
> @@ -410,15 +403,6 @@ static unsigned int nvme_pci_iod_alloc_size(struct nvme_dev *dev,
>   	return alloc_size + sizeof(struct scatterlist) * nseg;
>   }
>   
> -static unsigned int nvme_pci_cmd_size(struct nvme_dev *dev, bool use_sgl)
> -{
> -	unsigned int alloc_size = nvme_pci_iod_alloc_size(dev,
> -				    NVME_INT_BYTES(dev), NVME_INT_PAGES,
> -				    use_sgl);
> -
> -	return sizeof(struct nvme_iod) + alloc_size;
> -}
> -
>   static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>   				unsigned int hctx_idx)
>   {
> @@ -621,8 +605,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>   		dma_addr = next_dma_addr;
>   	}
>   
> -	if (iod->sg != iod->inline_sg)
> -		mempool_free(iod->sg, dev->iod_mempool);
> +	mempool_free(iod->sg, dev->iod_mempool);
>   }
>   
>   static void nvme_print_sgl(struct scatterlist *sgl, int nents)
> @@ -822,14 +805,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   	blk_status_t ret = BLK_STS_IOERR;
>   	int nr_mapped;
>   
> -	if (blk_rq_payload_bytes(req) > NVME_INT_BYTES(dev) ||
> -	    blk_rq_nr_phys_segments(req) > NVME_INT_PAGES) {
> -		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
> -		if (!iod->sg)
> -			return BLK_STS_RESOURCE;
> -	} else {
> -		iod->sg = iod->inline_sg;
> -	}
> +	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
> +	if (!iod->sg)
> +		return BLK_STS_RESOURCE;
>   
>   	iod->use_sgl = nvme_pci_use_sgls(dev, req);
>   
> @@ -1619,7 +1597,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>   		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
>   		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
>   		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
> -		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev, false);
> +		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
>   		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
>   		dev->admin_tagset.driver_data = dev;
>   
> @@ -2266,11 +2244,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>   		dev->tagset.numa_node = dev_to_node(dev->dev);
>   		dev->tagset.queue_depth =
>   				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
> -		dev->tagset.cmd_size = nvme_pci_cmd_size(dev, false);
> -		if ((dev->ctrl.sgls & ((1 << 0) | (1 << 1))) && sgl_threshold) {
> -			dev->tagset.cmd_size = max(dev->tagset.cmd_size,
> -					nvme_pci_cmd_size(dev, true));
> -		}
> +		dev->tagset.cmd_size = sizeof(struct nvme_iod);
>   		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>   		dev->tagset.driver_data = dev;
>   
>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
