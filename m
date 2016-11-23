From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 23 Nov 2016 10:25:53 -0800
Subject: [PATCH v3 1/2] nvmet-rdma: align to generic ib_event logging
 helper
In-Reply-To: <1479893928-32445-2-git-send-email-maxg@mellanox.com>
References: <1479893928-32445-1-git-send-email-maxg@mellanox.com>
 <1479893928-32445-2-git-send-email-maxg@mellanox.com>
Message-ID: <1479925553.5486.4.camel@linux.intel.com>

On Wed, 2016-11-23@11:38 +0200, Max Gurtovoy wrote:
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
> ?drivers/nvme/target/rdma.c |????3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 005ef5d..ddbae24 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1129,7 +1129,8 @@ static void nvmet_rdma_qp_event(struct ib_event
> *event, void *priv)
> ?		rdma_notify(queue->cm_id, event->event);
> ?		break;
> ?	default:
> -		pr_err("received unrecognized IB QP event %d\n",
> event->event);
> +		pr_err("received IB QP event: %s (%d)\n",
> +		???????ib_event_msg(event->event), event->event);

I liked the original print statement mentioning something that it hit
the default case ("received unrecognized IB QP event"). ?But if no one
else has a problem with it, then I'm ok with it.
