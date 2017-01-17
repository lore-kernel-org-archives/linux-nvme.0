From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 17 Jan 2017 22:06:51 +0200
Subject: [PATCH 3/4] nvme: use blk_rq_payload_bytes
In-Reply-To: <1484306953-3194-4-git-send-email-hch@lst.de>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-4-git-send-email-hch@lst.de>
Message-ID: <7532e18a-6cd3-294f-085d-e1ecdc48af6e@grimberg.me>


> @@ -1014,9 +1013,9 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
>  	}
>

Christoph, a little above here we still look at blk_rq_bytes(),
shouldn't that look at blk_rq_payload_bytes() too?

>  	if (count == 1) {
> -		if (rq_data_dir(rq) == WRITE &&
> -		    map_len <= nvme_rdma_inline_data_size(queue) &&
> -		    nvme_rdma_queue_idx(queue))
> +		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
> +		    blk_rq_payload_bytes(rq) <=
> +				nvme_rdma_inline_data_size(queue))
>  			return nvme_rdma_map_sg_inline(queue, req, c);
>
>  		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
