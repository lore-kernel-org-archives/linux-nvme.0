From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Sep 2016 10:36:55 +0200
Subject: [PATCH WIP/RFC v3 6/6] nvme-rdma: use ib_client API to detect
 device removal
In-Reply-To: <71557e76dd8ad082badce2793aaa24105fc57406.1472574410.git.swise@opengridcomputing.com>
References: <cover.1472574410.git.swise@opengridcomputing.com>
 <71557e76dd8ad082badce2793aaa24105fc57406.1472574410.git.swise@opengridcomputing.com>
Message-ID: <20160901083655.GD3703@lst.de>

On Tue, Aug 30, 2016@09:25:46AM -0700, Steve Wise wrote:
> Change nvme-rdma to use the IB Client API to detect device removal.
> This has the wonderful benefit of being able to blow away all the
> ib/rdma_cm resources for the device being removed.  No craziness about
> not destroying the cm_id handling the event.  No deadlocks due to broken
> iw_cm/rdma_cm/iwarp dependencies.  And no need to have a bound cm_id
> around during controller recovery/reconnect to catch device removal
> events.
> 
> We don't use the device_add aspect of the ib_client service since we only
> want to create resources for an IB device if we have a target utilizing
> that device.
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> ---
>  drivers/nvme/host/rdma.c | 111 ++++++++++++++++++-----------------------------
>  1 file changed, 43 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 8036c23..ecb4162 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1322,64 +1322,6 @@ out_destroy_queue_ib:
>  	return ret;
>  }
>  
> -/**
> - * nvme_rdma_device_unplug() - Handle RDMA device unplug
> - * @queue:      Queue that owns the cm_id that caught the event
> - *
> - * DEVICE_REMOVAL event notifies us that the RDMA device is about
> - * to unplug so we should take care of destroying our RDMA resources.
> - * This event will be generated for each allocated cm_id.
> - *
> - * In our case, the RDMA resources are managed per controller and not
> - * only per queue. So the way we handle this is we trigger an implicit
> - * controller deletion upon the first DEVICE_REMOVAL event we see, and
> - * hold the event inflight until the controller deletion is completed.
> - *
> - * One exception that we need to handle is the destruction of the cm_id
> - * that caught the event. Since we hold the callout until the controller
> - * deletion is completed, we'll deadlock if the controller deletion will
> - * call rdma_destroy_id on this queue's cm_id. Thus, we claim ownership
> - * of destroying this queue before-hand, destroy the queue resources,
> - * then queue the controller deletion which won't destroy this queue and
> - * we destroy the cm_id implicitely by returning a non-zero rc to the callout.
> - */
> -static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
> -{
> -	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
> -	int ret = 0;
> -
> -	/* Own the controller deletion */
> -	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
> -		return 0;
> -
> -	dev_warn(ctrl->ctrl.device,
> -		"Got rdma device removal event, deleting ctrl\n");
> -
> -	/* Get rid of reconnect work if its running */
> -	cancel_delayed_work_sync(&ctrl->reconnect_work);
> -
> -	/* Disable the queue so ctrl delete won't free it */
> -	if (!test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags)) {
> -		/* Free this queue ourselves */
> -		nvme_rdma_stop_queue(queue);
> -		nvme_rdma_destroy_queue_ib(queue);
> -
> -		/* Return non-zero so the cm_id will destroy implicitly */
> -		ret = 1;
> -	}
> -
> -	/*
> -	 * Queue controller deletion. Keep a reference until all
> -	 * work is flushed since delete_work will free the ctrl mem
> -	 */
> -	kref_get(&ctrl->ctrl.kref);
> -	queue_work(nvme_rdma_wq, &ctrl->delete_work);
> -	flush_work(&ctrl->delete_work);
> -	nvme_put_ctrl(&ctrl->ctrl);
> -
> -	return ret;
> -}
> -
>  static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  		struct rdma_cm_event *ev)
>  {
> @@ -1421,8 +1363,8 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  		nvme_rdma_error_recovery(queue->ctrl);
>  		break;
>  	case RDMA_CM_EVENT_DEVICE_REMOVAL:
> -		/* return 1 means impliciy CM ID destroy */
> -		return nvme_rdma_device_unplug(queue);
> +		/* device removal is handled via the ib_client API */
> +		break;
>  	default:
>  		dev_err(queue->ctrl->ctrl.device,
>  			"Unexpected RDMA CM event (%d)\n", ev->event);
> @@ -2031,27 +1973,60 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
>  	.create_ctrl	= nvme_rdma_create_ctrl,
>  };
>  
> +static void nvme_rdma_add_one(struct ib_device *ib_device)
> +{
> +	pr_info("Device %s available for use\n", ib_device->name);
> +}
> +
> +static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
> +{
> +	struct nvme_rdma_ctrl *ctrl;
> +
> +	pr_info("Removing resources for device %s\n", ib_device->name);

Can we avoid these noisy printks?

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
