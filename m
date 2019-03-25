From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:22:27 +0000
Subject: [PATCH 08/15] nvme-pci: merge nvme_free_iod into nvme_unmap_data
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-9-hch@lst.de>
Message-ID: <SN6PR04MB452734A9E74001D4684E2675865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:11 PM, Christoph Hellwig wrote:
> This means we now have a function that undoes everything nvme_map_data
> does and we can simplify the error handling a bit.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 44 ++++++++++++++++-------------------------
>   1 file changed, 17 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2fb35d44010a..ce8bdc15ec3c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -583,14 +583,24 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
>   	return true;
>   }
>   
> -static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
> +static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	enum dma_data_direction dma_dir = rq_data_dir(req) ?
> +			DMA_TO_DEVICE : DMA_FROM_DEVICE;
>   	const int last_prp = dev->ctrl.page_size / sizeof(__le64) - 1;
>   	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
> -
>   	int i;
>   
> +	if (iod->nents) {
> +		/* P2PDMA requests do not need to be unmapped */
> +		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
> +			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> +
> +		if (blk_integrity_rq(req))
> +			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
> +	}
> +
>   	if (iod->npages == 0)
>   		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
>   			dma_addr);
> @@ -847,50 +857,30 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
>   
>   	if (ret != BLK_STS_OK)
> -		goto out_unmap;
> +		goto out;
>   
>   	ret = BLK_STS_IOERR;
>   	if (blk_integrity_rq(req)) {
>   		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
> -			goto out_unmap;
> +			goto out;
>   
>   		sg_init_table(&iod->meta_sg, 1);
>   		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
> -			goto out_unmap;
> +			goto out;
>   
>   		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
> -			goto out_unmap;
> +			goto out;
>   
>   		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
>   	}
>   
>   	return BLK_STS_OK;
>   
> -out_unmap:
> -	dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
>   out:
> -	nvme_free_iod(dev, req);
> +	nvme_unmap_data(dev, req);
>   	return ret;
>   }
>   
> -static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
> -{
> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	enum dma_data_direction dma_dir = rq_data_dir(req) ?
> -			DMA_TO_DEVICE : DMA_FROM_DEVICE;
> -
> -	if (iod->nents) {
> -		/* P2PDMA requests do not need to be unmapped */
> -		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
> -			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> -
> -		if (blk_integrity_rq(req))
> -			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
> -	}
> -
> -	nvme_free_iod(dev, req);
> -}
> -
>   /*
>    * NOTE: ns is NULL when called on the admin queue.
>    */
> 
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
