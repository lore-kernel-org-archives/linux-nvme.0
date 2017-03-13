From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 20:58:18 +0100
Subject: [PATCH 1/3] nvme-rdma: handle cpu unplug when re-establishing
 the controller
In-Reply-To: <1489413740-29085-1-git-send-email-sagi@grimberg.me>
References: <1489413740-29085-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170313195818.GB9648@lst.de>

> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 779f516e7a4e..47a479f26e5d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -343,8 +343,6 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
>  	struct ib_device *ibdev = dev->dev;
>  	int ret;
>  
> -	BUG_ON(queue_idx >= ctrl->queue_count);

This makes me a bit nervous, shouldn't we ensure that queue_count
is accurate even with the fix?
