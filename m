From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:29:14 +0000
Subject: [PATCH 11/15] nvme-pci: split metadata handling from
 nvme_map_data / nvme_unmap_data
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-12-hch@lst.de>
Message-ID: <SN6PR04MB4527681E200935EE2481A32A865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:12 PM, Christoph Hellwig wrote:
> This prepares for some bigger changes to the data mapping helpers.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 48 +++++++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a7dad24e0406..cf29d079ad5b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -592,11 +592,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>   	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
>   	int i;
>   
> -	if (blk_integrity_rq(req)) {
> -		dma_unmap_page(dev->dev, iod->meta_dma,
> -				rq_integrity_vec(req)->bv_len, dma_dir);
> -	}
> -
>   	if (iod->nents) {
>   		/* P2PDMA requests do not need to be unmapped */
>   		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
> @@ -858,24 +853,23 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
>   	else
>   		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
> -
> +out:
>   	if (ret != BLK_STS_OK)
> -		goto out;
> -
> -	ret = BLK_STS_IOERR;
> -	if (blk_integrity_rq(req)) {
> -		iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
> -				dma_dir, 0);
> -		if (dma_mapping_error(dev->dev, iod->meta_dma))
> -			goto out;
> -		cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> -	}
> +		nvme_unmap_data(dev, req);
> +	return ret;
> +}
>   
> -	return BLK_STS_OK;
> +static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
> +		struct nvme_command *cmnd)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   
> -out:
> -	nvme_unmap_data(dev, req);
> -	return ret;
> +	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
> +			rq_dma_dir(req), 0);
> +	if (dma_mapping_error(dev->dev, iod->meta_dma))
> +		return BLK_STS_IOERR;
> +	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> +	return 0;
>   }
>   
>   /*
> @@ -913,9 +907,17 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			goto out_free_cmd;
>   	}
>   
> +	if (blk_integrity_rq(req)) {
> +		ret = nvme_map_metadata(dev, req, &cmnd);
> +		if (ret)
> +			goto out_unmap_data;
> +	}
> +
>   	blk_mq_start_request(req);
>   	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
>   	return BLK_STS_OK;
> +out_unmap_data:
> +	nvme_unmap_data(dev, req);
>   out_free_cmd:
>   	nvme_cleanup_cmd(req);
>   	return ret;
> @@ -924,10 +926,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   static void nvme_pci_complete_rq(struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_dev *dev = iod->nvmeq->dev;
>   
>   	nvme_cleanup_cmd(req);
> +	if (blk_integrity_rq(req))
> +		dma_unmap_page(dev->dev, iod->meta_dma,
> +			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
>   	if (blk_rq_nr_phys_segments(req))
> -		nvme_unmap_data(iod->nvmeq->dev, req);
> +		nvme_unmap_data(dev, req);
>   	nvme_complete_rq(req);
>   }
>   
> 

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
