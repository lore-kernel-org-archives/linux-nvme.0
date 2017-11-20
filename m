From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 Nov 2017 09:09:51 +0100
Subject: [PATCH v2] nvme-rdma: Use mr pool
In-Reply-To: <1510674794-3800-1-git-send-email-israelr@mellanox.com>
References: <1510674794-3800-1-git-send-email-israelr@mellanox.com>
Message-ID: <20171120080951.GA27552@lst.de>

> @@ -495,8 +457,26 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>  		goto out_destroy_qp;
>  	}
>  
> +	if (idx == 0)
> +		queue->ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
> +				ibdev->attrs.max_fast_reg_page_list_len);
> +

Hmm.  Why is this code moved here from nvme_rdma_configure_admin_queue?
I really don't like per-controller initialization in per-queue functions
but if there is no good way around it it needs a very good explanation,
and that explanation should be in a comment place next to the code.

> +	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
> +	if (unlikely(!req->mr))
> +		return -EAGAIN;
> +

Shouldn't the MR pool be sized that this always succeeds?  If so a
WARN_ON_ONCE() here might be useful.
