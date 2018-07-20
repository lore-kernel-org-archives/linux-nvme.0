From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 20 Jul 2018 08:23:43 -0600
Subject: [RCF PATCH 2/2] nvme-pci: Bounce data from Host memory to CMB
 Memory
In-Reply-To: <20180719230628.31494-3-scott.bauer@intel.com>
References: <20180719230628.31494-1-scott.bauer@intel.com>
 <20180719230628.31494-3-scott.bauer@intel.com>
Message-ID: <20180720142343.GB4093@localhost.localdomain>

On Thu, Jul 19, 2018@05:06:28PM -0600, Scott Bauer wrote:
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>

What does this gain us? I don't think this would do anything except
increase the CPU utilization. If this actually buys additional
performance, could you include some relative data and workload
characteristics in the changelog?

> +static int nvme_copy_to_cmb(struct nvme_dev *dev, struct nvme_iod *iod)
> +{
> +	struct scatterlist *s;
> +	void *data_cmb;
> +	int i;
> +
> +	iod->cmb_data = 1;
> +	for_each_sg(iod->sg, s, iod->nents, i) {
> +		data_cmb = (void *) gen_pool_alloc(dev->cmb_pool, s->length);
> +		if (!data_cmb) {
> +			pr_err("%s: failed to alloc from pool\n", __func__);
> +			goto unwind;
> +		}
> +
> +		memcpy_toio(data_cmb, page_address(sg_page(s)), s->length);
> +
> +		s->dma_address = gen_pool_virt_to_phys(dev->cmb_pool,
> +						       (unsigned long) data_cmb);
> +		sg_dma_len(s) = s->length;
> +		/* We do not need the sg_page page link anymore so we'll steal it. */
> +		s->page_link = (unsigned long) data_cmb;
> +	}
> +	return i;
> +
> + unwind:
> +	nvme_unmap_sg_cmb(dev, iod, i);
> +	return 0;
> +}
> +
>  static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
> -		struct nvme_command *cmnd)
> +				  struct nvme_command *cmnd)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct request_queue *q = req->q;
> @@ -808,8 +874,15 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out;
>  
>  	ret = BLK_STS_RESOURCE;
> -	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
> -			DMA_ATTR_NO_WARN);
> +
> +	if (dma_dir == DMA_TO_DEVICE && use_cmb_wds
> +	    && dev->cmb_pool && dev->cmbsz & NVME_CMBSZ_WDS &&
> +	    iod->nvmeq->qid)
> +		nr_mapped = nvme_copy_to_cmb(dev, iod);
> +	else
> +		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> +					     dma_dir, DMA_ATTR_NO_WARN);
> +
>  	if (!nr_mapped)
>  		goto out;

A failure in to allocate cmb resource should probably fallback to the
non-cmb resource.
