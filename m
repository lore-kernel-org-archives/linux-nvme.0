From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 23 May 2019 11:13:51 +0300
Subject: [Suspected-Phishing][PATCH 1/1] nvme-rdma: Add association
 between ctrl and transport dev
In-Reply-To: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
Message-ID: <53ba6182-53bc-ef4c-f818-94ea6e69f9f0@mellanox.com>

Sagi/Christoph,

can you review this please ? we need to fix that scenario for 5.2


On 5/21/2019 4:19 PM, Max Gurtovoy wrote:
> RDMA transport ctrl holds a reference to it's underlaying transport
> device, so we need to make sure that this reference is valid. Use kref
> object to enforce that.
>
> This commit fixes possible segmentation fault that may happen during
> reconnection + device removal flow that was caused by removing the ref
> count between block layer tagsets and the transport device.
>
> Fixes: 87fd125344d6 ("nvme-rdma: remove redundant reference between ib_device and tagset")
>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/rdma.c | 51 ++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f383146..07eddfb 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -354,6 +354,21 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
>   	return kref_get_unless_zero(&dev->ref);
>   }
>   
> +static void nvme_rdma_ctrl_dev_put(struct nvme_rdma_ctrl *ctrl,
> +				   struct nvme_rdma_device *dev)
> +{
> +	ctrl->device = 	NULL;
> +	kref_put(&dev->ref, nvme_rdma_free_dev);
> +}
> +
> +static void nvme_rdma_ctrl_dev_get(struct nvme_rdma_ctrl *ctrl,
> +				   struct nvme_rdma_device *dev)
> +{
> +	kref_get(&dev->ref);
> +	ctrl->device = dev;
> +}
> +
> +
>   static struct nvme_rdma_device *
>   nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
>   {
> @@ -743,12 +758,16 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
>   static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   		bool remove)
>   {
> +	struct nvme_rdma_device *ndev = ctrl->device;
> +
>   	if (remove) {
>   		blk_cleanup_queue(ctrl->ctrl.admin_q);
>   		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
> +		/* ctrl releases refcount on device */
> +		nvme_rdma_ctrl_dev_put(ctrl, ctrl->device);
>   	}
>   	if (ctrl->async_event_sqe.data) {
> -		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> +		nvme_rdma_free_qe(ndev->dev, &ctrl->async_event_sqe,
>   				sizeof(struct nvme_command), DMA_TO_DEVICE);
>   		ctrl->async_event_sqe.data = NULL;
>   	}
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
>   		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
>   		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
>   			error = PTR_ERR(ctrl->ctrl.admin_tagset);
> @@ -786,6 +808,14 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   			error = PTR_ERR(ctrl->ctrl.admin_q);
>   			goto out_free_tagset;
>   		}
> +	} else if (ctrl->device != ctrl->queues[0].device) {
> +		/* ctrl releases refcount on old device */
> +		nvme_rdma_ctrl_dev_put(ctrl, ctrl->device);
> +		/*
> +		 * underlaying device might change, ctrl takes refcount on
> +		 * new device.
> +		 */
> +		nvme_rdma_ctrl_dev_get(ctrl, ctrl->queues[0].device);
>   	}
>   
>   	error = nvme_rdma_start_queue(ctrl, 0);
> @@ -825,7 +855,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   	if (new)
>   		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
>   out_free_async_qe:
> -	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> +	if (new)
> +		nvme_rdma_ctrl_dev_put(ctrl, ctrl->device);
> +	nvme_rdma_free_qe(ibdev, &ctrl->async_event_sqe,
>   		sizeof(struct nvme_command), DMA_TO_DEVICE);
>   	ctrl->async_event_sqe.data = NULL;
>   out_free_queue:
> @@ -2027,9 +2059,8 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
>   	/* Delete all controllers using this device */
>   	mutex_lock(&nvme_rdma_ctrl_mutex);
>   	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
> -		if (ctrl->device->dev != ib_device)
> -			continue;
> -		nvme_delete_ctrl(&ctrl->ctrl);
> +		if (ctrl->device && ctrl->device->dev == ib_device)
> +			nvme_delete_ctrl(&ctrl->ctrl);
>   	}
>   	mutex_unlock(&nvme_rdma_ctrl_mutex);
>   
