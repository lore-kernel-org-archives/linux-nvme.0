From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Jun 2019 21:11:31 +0200
Subject: [Suspected-Phishing]Re: [PATCH] Revert "nvme-rdma: remove
 redundant reference between ib_device and tagset"
In-Reply-To: <b4a79dfe-ffc8-0571-9f54-cf5b98c21500@mellanox.com>
References: <20190603231159.17034-1-sagi@grimberg.me>
 <b98d3c8f-85ee-06f2-b47a-a3e04261c0d1@grimberg.me>
 <F4E18075-01AA-443B-BF43-23A4BA80C10C@intel.com>
 <d2a20c0f-092d-28ca-3365-1fb5df2cb816@mellanox.com>
 <b4a79dfe-ffc8-0571-9f54-cf5b98c21500@mellanox.com>
Message-ID: <20190604191131.GC28398@lst.de>

So this basically means we can't keep dma mappings around, which
is a bit unfortunate.  Can you also write a real changelog explaining
the reasoning behind it, which isn't quite obvious to me?

Nitpicks below:

> +static void nvme_rdma_unmap_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
> +			       size_t capsule_size, enum dma_data_direction dir)
>  {
>  	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
> +}
> +
> +static int nvme_rdma_map_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
> +			    size_t capsule_size, enum dma_data_direction dir)
> +{
> +	qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
> +	return ib_dma_mapping_error(ibdev, qe->dma);
> +}
> +
> +static void nvme_rdma_free_qe(struct nvme_rdma_qe *qe)
> +{
>  	kfree(qe->data);
>  }

All these helpers are pretty pointless now, and we might as well just
open code them.

> +static void nvme_rdma_free_mapped_qe(struct ib_device *ibdev,
> +				     struct nvme_rdma_qe *qe,
> +				     size_t capsule_size,
> +				     enum dma_data_direction dir)

Can you use normal two tabs indents for your new functions?

>  
>  	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
>  
> -	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> -			sizeof(struct nvme_command), DMA_TO_DEVICE);
> +	error = nvme_rdma_alloc_mapped_qe(ctrl->device->dev,
> +					  &ctrl->async_event_sqe,
> +					  sizeof(struct nvme_command),
> +					  DMA_TO_DEVICE);

So.. If keeping SQEs mapped is not fine, why is keeping the AEN SQE
around fine?

> +		if (err == -ENOMEM || err == -EAGAIN)
> +			ret = BLK_STS_RESOURCE;
> +		else
> +			ret = BLK_STS_IOERR;
> +		goto unmap_qe;
>  	}
>  
>  	sqe->cqe.done = nvme_rdma_send_done;
> @@ -1735,14 +1781,20 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			req->mr ? &req->reg_wr.wr : NULL);
>  	if (unlikely(err)) {
>  		nvme_rdma_unmap_data(queue, rq);
> -		goto err;
> +		if (err == -ENOMEM || err == -EAGAIN)
> +			ret = BLK_STS_RESOURCE;
> +		else
> +			ret = BLK_STS_IOERR;
> +		goto unmap_qe;

It would be nice to keep the status mapping in a single place behind
the goto label.

> +out:
> +	return ret;

No real need for the label here, you could just return directly.
