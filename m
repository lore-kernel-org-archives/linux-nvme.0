From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 May 2017 13:18:34 +0200
Subject: [PATCH 06/11] nvme-rdma: rework rdma connection establishment
 error path
In-Reply-To: <1493893995-27063-7-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <1493893995-27063-7-git-send-email-sagi@grimberg.me>
Message-ID: <20170504111834.GB9686@lst.de>

On Thu, May 04, 2017@01:33:10PM +0300, Sagi Grimberg wrote:
> Instead of introducing a flag for if the queue is allocated,
> simply free the rdma resources when we get the error.
> 
> We allocate the queue rdma resources when we have an address
> resolution, their we allocate (or take a reference on) our device
> so we should free it when we have error after the address resolution
> namely:
> 1. route resolution error
> 2. connect reject
> 3. connect error
> 4. peer unreachable error
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/rdma.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 2dc381b57e4b..7df52896f321 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -81,9 +81,8 @@ struct nvme_rdma_request {
>  
>  enum nvme_rdma_queue_flags {
>  	NVME_RDMA_Q_CONNECTED		= 0,
> -	NVME_RDMA_IB_QUEUE_ALLOCATED	= 1,
> -	NVME_RDMA_Q_DELETING		= 2,
> -	NVME_RDMA_Q_LIVE		= 3,
> +	NVME_RDMA_Q_DELETING		= 1,
> +	NVME_RDMA_Q_LIVE		= 2,
>  };
>  
>  struct nvme_rdma_queue {
> @@ -466,9 +465,6 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
>  	struct nvme_rdma_device *dev;
>  	struct ib_device *ibdev;
>  
> -	if (!test_and_clear_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags))
> -		return;
> -
>  	dev = queue->device;
>  	ibdev = dev->dev;
>  	rdma_destroy_qp(queue->cm_id);
> @@ -525,7 +521,6 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>  		ret = -ENOMEM;
>  		goto out_destroy_qp;
>  	}
> -	set_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
>  
>  	return 0;
>  
> @@ -590,7 +585,6 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
>  	return 0;
>  
>  out_destroy_cm_id:
> -	nvme_rdma_destroy_queue_ib(queue);
>  	rdma_destroy_id(queue->cm_id);
>  	return ret;
>  }
> @@ -1362,12 +1356,14 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  		complete(&queue->cm_done);
>  		return 0;
>  	case RDMA_CM_EVENT_REJECTED:
> +		nvme_rdma_destroy_queue_ib(queue);
>  		cm_error = nvme_rdma_conn_rejected(queue, ev);
>  		break;
> -	case RDMA_CM_EVENT_ADDR_ERROR:
>  	case RDMA_CM_EVENT_ROUTE_ERROR:
>  	case RDMA_CM_EVENT_CONNECT_ERROR:
>  	case RDMA_CM_EVENT_UNREACHABLE:
> +		nvme_rdma_destroy_queue_ib(queue);
> +	case RDMA_CM_EVENT_ADDR_ERROR:

Please add a /*FALLTHRU*/ annotation here.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
