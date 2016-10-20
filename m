From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 20 Oct 2016 12:45:33 -0500
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <0b3c125a-cdb8-7a28-deca-0ccad3d1ca22@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
 <00bf01d22adf$43370ac0$c9a52040$@opengridcomputing.com>
 <0b3c125a-cdb8-7a28-deca-0ccad3d1ca22@sandisk.com>
Message-ID: <010801d22af9$c202c370$46084a50$@opengridcomputing.com>

> On 10/20/2016 07:35 AM, Steve Wise wrote:
> > iWARP RDMA_CM_EVENT_REJECTED events have a -errno as the event status.
> Perhaps
> > you could at the very least dump the error as an integer here?  But an  errno
> > string would be ideal. :)
> 
> Hello Steve,
> 
> Is something like the patch below perhaps what you had in mind? While I was
> preparing this patch I was disappointed to see that another implementation
> is needed for IB/RoCE transports compared to iWARP transports.
>

I agree.  What if we add a helper function in the core to map the event->status value to something human readable?  That would at least push this into the core.   The nvme host really doesn't do anything other than display a different message...

Something like rdma_event_msg(), but using event->status.  

 
> Thanks,
> 
> Bart.
> 
> 
> [PATCH] nvme/rdma: Provide more information about rejected connection
> attempts
> 
> While I was figuring out how to make the nvme-rdma driver log in to
> the nvmet-rdma driver over an IB network, the following message
> appeared in the system log:
> 
>     nvme nvme0: Connect rejected, status 0.
> 
> That message is not very helpful. Hence this patch that makes the
> messages reported by nvme_rdma_conn_rejected() more informative.
> 
> ---
>  drivers/nvme/host/rdma.c | 79
> ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 8a80a04..c1b9fd6 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1206,24 +1206,82 @@ static int nvme_rdma_conn_established(struct
> nvme_rdma_queue *queue)
>  	return ret;
>  }
> 
> -static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
> -		struct rdma_cm_event *ev)
> +static int nvme_rdma_ib_conn_rejected(struct nvme_rdma_queue *queue,
> +		const struct rdma_cm_event *ev)
> +{
> +	char reason[32];
> +
> +	switch (ev->status) {
> +	case IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID:
> +		strlcpy(reason, "duplicate local comm id", sizeof(reason));
> +		break;
> +	case IB_CM_REJ_CONSUMER_DEFINED:
> +		if (ev->param.conn.private_data_len) {
> +			const struct nvme_rdma_cm_rej *rej =
> +				ev->param.conn.private_data;
> +
> +			snprintf(reason, sizeof(reason),
> +				 "NVMe RDMA CM status %d",
> +				 le16_to_cpu(rej->sts));
> +			/* XXX: Think of something clever to do here... */
> +		} else {
> +			strlcpy(reason, "no private data", sizeof(reason));
> +		}
> +		break;
> +	case IB_CM_REJ_INVALID_SERVICE_ID:
> +		strlcpy(reason, "invalid service ID", sizeof(reason));
> +		break;
> +	case IB_CM_REJ_STALE_CONN:
> +		strlcpy(reason, "stale connection", sizeof(reason));
> +		break;
> +	default:
> +		snprintf(reason, sizeof(reason), "REJ reason %#x", ev->status);
> +		break;
> +	}
> +
> +	dev_err(queue->ctrl->ctrl.device, "Connect rejected, %s.\n", reason);
> +
> +	return -ECONNRESET;
> +}
> +
> +static int nvme_rdma_iw_conn_rejected(struct nvme_rdma_queue *queue,
> +		const struct rdma_cm_event *ev)
>  {
> +	char reason[32];
> +
>  	if (ev->param.conn.private_data_len) {
> -		struct nvme_rdma_cm_rej *rej =
> -			(struct nvme_rdma_cm_rej *)ev-
> >param.conn.private_data;
> +		const struct nvme_rdma_cm_rej *rej =
> +			ev->param.conn.private_data;
> 
> -		dev_err(queue->ctrl->ctrl.device,
> -			"Connect rejected, status %d.", le16_to_cpu(rej->sts));
> -		/* XXX: Think of something clever to do here... */
> +		snprintf(reason, sizeof(reason),
> +			 "NVMe RDMA CM status %d",
> +			 le16_to_cpu(rej->sts));
> +			/* XXX: Think of something clever to do here... */
>  	} else {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"Connect rejected, no private data.\n");
> +		strlcpy(reason, "no private data", sizeof(reason));
>  	}
> 
> +	dev_err(queue->ctrl->ctrl.device, "Connect rejected, errno %d, %s.\n",
> +		ev->status, reason);
> +
>  	return -ECONNRESET;
>  }
> 
> +static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
> +		enum rdma_transport_type tt,
> +		const struct rdma_cm_event *ev)
> +{
> +	switch (tt) {
> +	case RDMA_TRANSPORT_IB:
> +		return nvme_rdma_ib_conn_rejected(queue, ev);
> +	case RDMA_TRANSPORT_IWARP:
> +		return nvme_rdma_iw_conn_rejected(queue, ev);
> +	default:
> +		WARN_ON_ONCE(true);
> +		return -ECONNRESET;
> +	}
> +}
> +
>  static int nvme_rdma_addr_resolved(struct nvme_rdma_queue *queue)
>  {
>  	struct nvme_rdma_device *dev;
> @@ -1331,7 +1389,8 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id
> *cm_id,
>  		complete(&queue->cm_done);
>  		return 0;
>  	case RDMA_CM_EVENT_REJECTED:
> -		cm_error = nvme_rdma_conn_rejected(queue, ev);
> +		cm_error = nvme_rdma_conn_rejected(queue,
> +				cm_id->route.addr.dev_addr.transport, ev);
>  		break;
>  	case RDMA_CM_EVENT_ADDR_ERROR:
>  	case RDMA_CM_EVENT_ROUTE_ERROR:
> --
> 2.10.1
> 
