From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 20 Oct 2016 09:35:54 -0500
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
Message-ID: <00bf01d22adf$43370ac0$c9a52040$@opengridcomputing.com>

> 
> While I was figuring out how to make the nvme-rdma driver log in to
> the nvmet-rdma driver, the following message appeared in the system
> log:
> 
>     nvme nvme0: Connect rejected, status 0.
> 
> That message is not very helpful. Hence this patch that makes the
> messages reported by nvme_rdma_conn_rejected() more informative.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> ---
>  drivers/nvme/host/rdma.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9612ea0..df7f599 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1207,20 +1207,39 @@ static int nvme_rdma_conn_established(struct
> nvme_rdma_queue *queue)
>  }
> 
>  static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
> -		struct rdma_cm_event *ev)
> +				   const struct rdma_cm_event *ev)
>  {
> -	if (ev->param.conn.private_data_len) {
> -		struct nvme_rdma_cm_rej *rej =
> -			(struct nvme_rdma_cm_rej *)ev-
> >param.conn.private_data;
> +	char reason[32];
> 
> -		dev_err(queue->ctrl->ctrl.device,
> -			"Connect rejected, status %d.", le16_to_cpu(rej->sts));
> -		/* XXX: Think of something clever to do here... */
> -	} else {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"Connect rejected, no private data.\n");
> +	switch (ev->status) {
> +	case IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID:
> +		strlcpy(reason, "duplicate local comm id", sizeof(reason));
> +		break;
> +	case IB_CM_REJ_CONSUMER_DEFINED:
> +		if (ev->param.conn.private_data_len) {
> +			const struct nvme_rdma_cm_rej *rej =
> +				(const void *)ev->param.conn.private_data;
> +
> +			snprintf(reason, sizeof(reason), "status %d",
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

Hey Bart,

iWARP RDMA_CM_EVENT_REJECTED events have a -errno as the event status.  Perhaps
you could at the very least dump the error as an integer here?  But an  errno
string would be ideal. :)


Steve.
