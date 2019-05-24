From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 May 2019 00:05:23 -0700
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and transport
 dev
In-Reply-To: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
Message-ID: <da6603ee-4a71-e057-5c88-656455956eba@grimberg.me>


> @@ -758,23 +777,26 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   		bool new)
>   {
> +	struct ib_device *ibdev;
>   	int error;
>   
>   	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
>   	if (error)
>   		return error;
>   
> -	ctrl->device = ctrl->queues[0].device;
> -	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
> +	ibdev = ctrl->queues[0].device->dev;
> +	ctrl->ctrl.numa_node = dev_to_node(ibdev->dma_device);
> +	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ibdev);
>   
> -	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
> -
> -	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> +	error = nvme_rdma_alloc_qe(ibdev, &ctrl->async_event_sqe,
>   			sizeof(struct nvme_command), DMA_TO_DEVICE);
>   	if (error)
>   		goto out_free_queue;
>   
>   	if (new) {
> +		/* ctrl takes refcount on device */
> +		nvme_rdma_ctrl_dev_get(ctrl, ctrl->queues[0].device);
> +

Do you actually need the extra reference on the device? why doesn't just
the set/clear of ctrl->device sufficient? these routines should be
serialized..
