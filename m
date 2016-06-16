From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 16 Jun 2016 10:17:03 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160616151048.GA13218@lst.de>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org> <20160616151048.GA13218@lst.de>
Message-ID: <00dc01d1c7e2$22f01230$68d03690$@opengridcomputing.com>

Hey Yoichi, can you please try this out on your setup?  I'm still trying to
reproduce this on mine.

Thanks!

Steve.

> I think nvmet_rdma_delete_ctrl is getting the exlusion vs other calls
> or __nvmet_rdma_queue_disconnect wrong as we rely on a queue that
> is undergoing deletion to not be on any list.  Additionally it also
> check the cntlid instead of the pointer, which would be harmful if
> multiple subsystems have the same cntlid.
> 
> Does the following patch help?
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index b1c6e5b..9ae65a7 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1293,19 +1293,21 @@ static int nvmet_rdma_cm_handler(struct
> rdma_cm_id *cm_id,
> 
>  static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
>  {
> -	struct nvmet_rdma_queue *queue, *next;
> -	static LIST_HEAD(del_list);
> +	struct nvmet_rdma_queue *queue, *found = NULL;
> 
>  	mutex_lock(&nvmet_rdma_queue_mutex);
> -	list_for_each_entry_safe(queue, next,
> -			&nvmet_rdma_queue_list, queue_list) {
> -		if (queue->nvme_sq.ctrl->cntlid == ctrl->cntlid)
> -			list_move_tail(&queue->queue_list, &del_list);
> +	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
> +		if (queue->nvme_sq.ctrl == ctrl) {
> +			list_del_init(&queue->queue_list);
> +			found = queue;
> +			break;
> +		}
>  	}
> +
>  	mutex_unlock(&nvmet_rdma_queue_mutex);
> 
> -	list_for_each_entry_safe(queue, next, &del_list, queue_list)
> -		nvmet_rdma_queue_disconnect(queue);
> +	if (found)
> +		__nvmet_rdma_queue_disconnect(queue);
>  }
> 
>  static int nvmet_rdma_add_port(struct nvmet_port *port)
