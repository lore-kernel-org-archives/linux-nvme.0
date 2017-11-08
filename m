From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Nov 2017 19:21:17 +0100
Subject: [PATCH 1/3] nvmet-rdma: removed queues cleanup from module exit
In-Reply-To: <20171108100030.25745-2-sagi@grimberg.me>
References: <20171108100030.25745-1-sagi@grimberg.me>
 <20171108100030.25745-2-sagi@grimberg.me>
Message-ID: <20171108182117.GB512@lst.de>

On Wed, Nov 08, 2017@12:00:28PM +0200, Sagi Grimberg wrote:
> We already do that when we are notified in device removal
> which is triggered when unregistering as an ib client.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/target/rdma.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 98d7f2ded511..efcdc4991359 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1537,24 +1537,7 @@ static int __init nvmet_rdma_init(void)
>  
>  static void __exit nvmet_rdma_exit(void)
>  {
> -	struct nvmet_rdma_queue *queue;
> -
>  	nvmet_unregister_transport(&nvmet_rdma_ops);
> -
> -	flush_scheduled_work();
> -
> -	mutex_lock(&nvmet_rdma_queue_mutex);
> -	while ((queue = list_first_entry_or_null(&nvmet_rdma_queue_list,
> -			struct nvmet_rdma_queue, queue_list))) {
> -		list_del_init(&queue->queue_list);
> -
> -		mutex_unlock(&nvmet_rdma_queue_mutex);
> -		__nvmet_rdma_queue_disconnect(queue);
> -		mutex_lock(&nvmet_rdma_queue_mutex);
> -	}
> -	mutex_unlock(&nvmet_rdma_queue_mutex);
> -
> -	flush_scheduled_work();

Should we thrown in an assert here that the queue really is empty?

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
