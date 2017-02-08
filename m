From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Feb 2017 11:45:34 +0200
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <1486507170-23285-1-git-send-email-parav@mellanox.com>
References: <1486507170-23285-1-git-send-email-parav@mellanox.com>
Message-ID: <fcb7f9ed-c36f-8f46-789c-904bd6f72501@grimberg.me>

>  static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
> -		struct nvme_rdma_request *req, struct nvme_command *c)
> +		struct nvme_rdma_request *req, struct nvme_command *c,
> +		int count)
>  {
>  	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> -
> -	req->sge[1].addr = sg_dma_address(req->sg_table.sgl);
> -	req->sge[1].length = sg_dma_len(req->sg_table.sgl);
> -	req->sge[1].lkey = queue->device->pd->local_dma_lkey;
> +	int i;
> +	u32 len = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		req->sge[i + 1].addr = sg_dma_address(&req->sg_table.sgl[i]);
> +		req->sge[i + 1].length = sg_dma_len(&req->sg_table.sgl[i]);
> +		req->sge[i + 1].lkey = queue->device->pd->local_dma_lkey;
> +		len += sg_dma_len(&req->sg_table.sgl[i]);
> +		req->num_sge++;
> +	}

Nit, you can also have sge iterator that starts in req->sge[1] instead.
