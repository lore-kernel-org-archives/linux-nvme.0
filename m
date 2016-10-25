From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 25 Oct 2016 08:51:46 -0700
Subject: [PATCH v3 6/6] rds_rdma: log the connection reject message
In-Reply-To: <21c48d771ab8a9d37ec19ea5f7a48ed5b84c8984.1477336045.git.swise@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <21c48d771ab8a9d37ec19ea5f7a48ed5b84c8984.1477336045.git.swise@opengridcomputing.com>
Message-ID: <928b6e33-992b-8b88-e224-224f19566623@oracle.com>

On 10/24/2016 12:07 PM, Steve Wise wrote:
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> ---
>  net/rds/rdma_transport.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
> index 345f090..6bd2814 100644
> --- a/net/rds/rdma_transport.c
> +++ b/net/rds/rdma_transport.c
> @@ -100,11 +100,14 @@ int rds_rdma_cm_event_handler(struct rdma_cm_id *cm_id,
>  		trans->cm_connect_complete(conn, event);
>  		break;
>
> +	case RDMA_CM_EVENT_REJECTED:
> +		rdsdebug("Connection rejected: %s\n",
> +			 rdma_reject_msg(cm_id, event->status));
For current code above is fine but I will need the other helper
while adding few connection cases where ARI field carries information
for the reason for the reject.

I assume, rdma_consumer_reject_data() is meant to be used for that ?

The patch looks fine to me.
FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar at oracle.com>
