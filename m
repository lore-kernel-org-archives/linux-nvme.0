From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:39:35 +0000
Subject: [PATCH 14/15] nvme-pci: optimize mapping single segment requests
 using SGLs
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-15-hch@lst.de>
Message-ID: <SN6PR04MB45274160A60B0803B41190A3865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:12 PM, Christoph Hellwig wrote:
> If the controller supports SGLs we can take another short cut for single
> segment request, given that we can always map those without another
> indirection structure, and thus don't need to create a scatterlist
> structure.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 47fc4d653961..38869f59c296 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -819,6 +819,23 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
>   	return 0;
>   }
>   
> +static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
> +		struct request *req, struct nvme_rw_command *cmnd,
> +		struct bio_vec *bv)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
> +	if (dma_mapping_error(dev->dev, iod->first_dma))
> +		return BLK_STS_RESOURCE;
> +	iod->dma_len = bv->bv_len;
> +
> +	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
> +	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
> +	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
> +	return 0;
> +}
> +
>   static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   		struct nvme_command *cmnd)
>   {
> @@ -836,6 +853,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   			if (bv.bv_offset + bv.bv_len <= dev->ctrl.page_size * 2)
>   				return nvme_setup_prp_simple(dev, req,
>   							     &cmnd->rw, &bv);
> +
> +			if (iod->nvmeq->qid &&
> +			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
> +				return nvme_setup_sgl_simple(dev, req,
> +							     &cmnd->rw, &bv);
>   		}
>   	}
>   
> 

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
