From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 10:49:26 +0200
Subject: [PATCH 4.14-rc] nvme-rdma: Fix error status return in tagset
 allocation failure
In-Reply-To: <1508396289-12237-1-git-send-email-sagi@grimberg.me>
References: <1508396289-12237-1-git-send-email-sagi@grimberg.me>
Message-ID: <20171019084926.GA14227@lst.de>

>  	if (new) {
>  		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
> -		if (IS_ERR(ctrl->ctrl.admin_tagset))
> +		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
> +			error = PTR_ERR(ctrl->ctrl.admin_tagset);
>  			goto out_free_queue;
> +		}

Can we return an error code instead and just pass in the tag set
to be allocated instead of the admin flag?A  E.g.:

	error = nvme_rdma_alloc_tagset(&ctrl->ctrl, &ctrl->ctrl.admin_tagset);
	if (error)
		goto out_free_queue;
