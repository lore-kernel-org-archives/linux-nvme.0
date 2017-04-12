From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Apr 2017 19:17:59 +0200
Subject: [PATCH 2/2] nvme-rdma: add support for arbitrary sg lists mapping
In-Reply-To: <1491948109-9224-2-git-send-email-maxg@mellanox.com>
References: <1491948109-9224-1-git-send-email-maxg@mellanox.com>
 <1491948109-9224-2-git-send-email-maxg@mellanox.com>
Message-ID: <20170412171759.GC8639@lst.de>

> -	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
> +	req->mr = ib_alloc_mr(dev->pd, req->mr_type,
>  			ctrl->max_fr_pages);
>  	if (IS_ERR(req->mr)) {
>  		ret = PTR_ERR(req->mr);
> @@ -348,8 +349,12 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
>  	if (ret)
>  		return ret;
>  
> -	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
> -			ctrl->max_fr_pages);
> +	if (ibdev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
> +		req->mr_type = IB_MR_TYPE_SG_GAPS;
> +	else
> +		req->mr_type = IB_MR_TYPE_MEM_REG;

Why do we need the req->mr_type member?  Can't we just check the device
aps in the reinit path as well?
