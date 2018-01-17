From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 17 Jan 2018 09:37:02 -0600
Subject: [PATCH 2/4] nvmet-rdma: notify QP on Last WQE Reached event
 arrival
In-Reply-To: <1516197178-26493-3-git-send-email-maxg@mellanox.com>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
 <1516197178-26493-3-git-send-email-maxg@mellanox.com>
Message-ID: <02bf01d38fa9$05254550$0f6fcff0$@opengridcomputing.com>

> 
> In order to avoid resource leakage for QP associated with
> a Shared Receive Queue (SRQ), notify it on Last WQE Reached
> event arrival.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  drivers/nvme/target/rdma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 4991290..99a14a7 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1151,6 +1151,9 @@ static void nvmet_rdma_qp_event(struct ib_event
> *event, void *priv)
>  	case IB_EVENT_COMM_EST:
>  		rdma_notify(queue->cm_id, event->event);
>  		break;
> +	case IB_EVENT_QP_LAST_WQE_REACHED:
> +		ib_notify_qp(queue->cm_id->qp, event->event);
> +		break;
>  	default:
>  		pr_err("received IB QP event: %s (%d)\n",
>  		       ib_event_msg(event->event), event->event);

I wonder if this could be handled in ib_dispatch_event() for all ULPS?
