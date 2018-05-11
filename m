From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 May 2018 08:48:28 +0200
Subject: [PATCH RFC 1/2] nvme-rdma: Support 8K inline
In-Reply-To: <1609e345042f2801f92e8831e8c83b688fad07eb.1525880285.git.swise@opengridcomputing.com>
References: <cover.1525880285.git.swise@opengridcomputing.com>
 <1609e345042f2801f92e8831e8c83b688fad07eb.1525880285.git.swise@opengridcomputing.com>
Message-ID: <20180511064828.GC8368@lst.de>

> -#define NVME_RDMA_MAX_INLINE_SEGMENTS	1
> +#define NVME_RDMA_MAX_INLINE_SEGMENTS	2

Given how little space we use for just the sge array maybe we
want to bump this to 4 once we need to deal with multiple entries?

>  static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
> -		struct nvme_rdma_request *req, struct nvme_command *c)
> +		struct nvme_rdma_request *req, int count,
> +		struct nvme_command *c)

Just gut feeling, but I'd pass the count argument last.

>  	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> +	u32 len;
>  
>  	req->sge[1].addr = sg_dma_address(req->sg_table.sgl);
>  	req->sge[1].length = sg_dma_len(req->sg_table.sgl);
>  	req->sge[1].lkey = queue->device->pd->local_dma_lkey;
> +	len = req->sge[1].length;
> +	if (count == 2) {
> +		req->sge[2].addr = sg_dma_address(req->sg_table.sgl+1);
> +		req->sge[2].length = sg_dma_len(req->sg_table.sgl+1);
> +		req->sge[2].lkey = queue->device->pd->local_dma_lkey;
> +		len += req->sge[2].length;
> +	}

I think this should be turned into a for loop, e.g.

	u32 len, i;

	for (i = 0; i < count; i++) {
		req->sge[1 + i].addr = sg_dma_address(&req->sg_table.sgl[i]);
		req->sge[1 + i].length = sg_dma_len(&req->sg_table.sgl[i]);
		req->sge[1 + i].lkey = queue->device->pd->local_dma_lkey;
		req->num_sge++;
		len += req->sge[i + 1].length;
	}
		
> -	if (count == 1) {
> +	if (count <= 2) {

This should be NVME_RDMA_MAX_INLINE_SEGMENTS.
