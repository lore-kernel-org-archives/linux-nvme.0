From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 May 2019 12:22:36 +0200
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and
 transport dev
In-Reply-To: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
Message-ID: <20190523102236.GC15492@lst.de>

> +static void nvme_rdma_ctrl_dev_put(struct nvme_rdma_ctrl *ctrl,
> +				   struct nvme_rdma_device *dev)
> +{
> +	ctrl->device = 	NULL;

double whitespace here.

> +	kref_put(&dev->ref, nvme_rdma_free_dev);
> +}
> +
> +static void nvme_rdma_ctrl_dev_get(struct nvme_rdma_ctrl *ctrl,
> +				   struct nvme_rdma_device *dev)
> +{
> +	kref_get(&dev->ref);
> +	ctrl->device = dev;

Why aren't these using nvme_rdma_dev_put / nvme_rdma_dev_get?

>  static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
>  		bool remove)
>  {
> +	struct nvme_rdma_device *ndev = ctrl->device;
> +
>  	if (remove) {
>  		blk_cleanup_queue(ctrl->ctrl.admin_q);
>  		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
> +		/* ctrl releases refcount on device */
> +		nvme_rdma_ctrl_dev_put(ctrl, ctrl->device);
>  	}
>  	if (ctrl->async_event_sqe.data) {
> -		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> +		nvme_rdma_free_qe(ndev->dev, &ctrl->async_event_sqe,

What guarantees ndev is not freed here?
