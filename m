From: klaus@birkelund.eu (Klaus Birkelund)
Date: Tue, 30 Apr 2019 16:17:22 +0200
Subject: [PATCH 14/15] nvme-pci: optimize mapping single segment requests
 using SGLs
In-Reply-To: <20190321231037.25104-15-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-15-hch@lst.de>
Message-ID: <20190430141722.GA19100@apples.localdomain>

On Thu, Mar 21, 2019@04:10:36PM -0700, Christoph Hellwig wrote:
> If the controller supports SGLs we can take another short cut for single
> segment request, given that we can always map those without another
> indirection structure, and thus don't need to create a scatterlist
> structure.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/pci.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 47fc4d653961..38869f59c296 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -819,6 +819,23 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
>  	return 0;
>  }
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
>  static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		struct nvme_command *cmnd)
>  {
> @@ -836,6 +853,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  			if (bv.bv_offset + bv.bv_len <= dev->ctrl.page_size * 2)
>  				return nvme_setup_prp_simple(dev, req,
>  							     &cmnd->rw, &bv);
> +
> +			if (iod->nvmeq->qid &&
> +			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
> +				return nvme_setup_sgl_simple(dev, req,
> +							     &cmnd->rw, &bv);
>  		}
>  	}
>  
> -- 
> 2.20.1
> 

Hi Christoph,

nvme_setup_sgl_simple does not set the PSDT field, so bypassing
nvme_pci_setup_sgls causing controllers to assume PRP.

Adding `cmnd->flags = NVME_CMD_SGL_METABUF` in nvme_setup_sgl_simple
fixes the issue.


-- 
Klaus
