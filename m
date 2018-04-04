From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 15:43:26 +0300
Subject: [PATCH 2/4] nvmet-rdma: Use new SGL alloc/free helper for requests
In-Reply-To: <20180329160721.4691-3-logang@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-3-logang@deltatee.com>
Message-ID: <2fbc3260-6682-f789-9500-2961293ff3b4@grimberg.me>


> @@ -565,24 +565,24 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
>   {
>   	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
>   	u64 addr = le64_to_cpu(sgl->addr);
> -	u32 len = get_unaligned_le24(sgl->length);
>   	u32 key = get_unaligned_le32(sgl->key);
>   	int ret;
>   
> +	rsp->req.transfer_len = get_unaligned_le24(sgl->length);
> +

IIRC, this might result in nvmet-rdma executing data-transfer even
for failed requests in some error cases. I'm not sure this is the
only case, but have you tested what happens in error cases?

See nvmet_rdma_need_data_in()/nvmet_rdma_need_data_out() which look
at transfer_len.

>   	/* no data command? */
> -	if (!len)
> +	if (!rsp->req.transfer_len)
>   		return 0;
>   
> -	rsp->req.sg = sgl_alloc(len, GFP_KERNEL, &rsp->req.sg_cnt);
> -	if (!rsp->req.sg)
> -		return NVME_SC_INTERNAL;
> +	ret = nvmet_req_alloc_sgl(&rsp->req, &rsp->queue->nvme_sq);
> +	if (ret < 0)
> +		goto error_out;
>   
>   	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
>   			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
>   			nvmet_data_dir(&rsp->req));
>   	if (ret < 0)
> -		return NVME_SC_INTERNAL;
> -	rsp->req.transfer_len += len;
> +		goto error_out;
>   	rsp->n_rdma += ret;
>   
>   	if (invalidate) {
> @@ -591,6 +591,10 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
>   	}
>   
>   	return 0;
> +
> +error_out:
> +	rsp->req.transfer_len = 0;
> +	return NVME_SC_INTERNAL;
>   }
>   
>   static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
> 
