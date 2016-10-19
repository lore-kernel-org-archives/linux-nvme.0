From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 12:41:02 +0200
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
Message-ID: <20161019104102.GD1191@lst.de>

On Tue, Oct 18, 2016@01:12:03PM -0700, Bart Van Assche wrote:
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
> @@ -1207,20 +1207,39 @@ static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
>  }
>  
>  static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
> -		struct rdma_cm_event *ev)
> +				   const struct rdma_cm_event *ev)

No need to reindent the prototype..

>  {
> +	char reason[32];
>  
> +	switch (ev->status) {
> +	case IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID:
> +		strlcpy(reason, "duplicate local comm id", sizeof(reason));
> +		break;
> +	case IB_CM_REJ_CONSUMER_DEFINED:
> +		if (ev->param.conn.private_data_len) {
> +			const struct nvme_rdma_cm_rej *rej =
> +				(const void *)ev->param.conn.private_data;

What's the point of this void pointer cast?

Otherwise the change looks fine to me.
