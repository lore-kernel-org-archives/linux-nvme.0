From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 16 Jun 2016 15:49:26 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160616203437.GA19079@lst.de>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <01b501d1c809$92cb1a60$b8614f20$@opengridcomputing.com>
 <576306EE.4020306@grimberg.me>
 <01b901d1c80b$72f83680$58e8a380$@opengridcomputing.com>
 <CAF1ivSYUG4c7Ej-gNqA=aPFR2zkNq8KhBoodhp64wdY=eQLx6g@mail.gmail.com>
 <01c101d1c80d$96d13c80$c473b580$@opengridcomputing.com>
 <20160616203437.GA19079@lst.de>
Message-ID: <01e701d1c810$91d851c0$b588f540$@opengridcomputing.com>

> Unfortunately I think it's still wrong because it will only delete
> a single queue per controller.  We'll probably need something
> like this instead, which does the same think but also has a retry
> loop for additional queues:
> 
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index b1c6e5b..425b55c 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1293,19 +1293,20 @@ static int nvmet_rdma_cm_handler(struct
> rdma_cm_id *cm_id,
> 
>  static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
>  {
> -	struct nvmet_rdma_queue *queue, *next;
> -	static LIST_HEAD(del_list);
> +	struct nvmet_rdma_queue *queue;
> 
> +restart:
>  	mutex_lock(&nvmet_rdma_queue_mutex);
> -	list_for_each_entry_safe(queue, next,
> -			&nvmet_rdma_queue_list, queue_list) {
> -		if (queue->nvme_sq.ctrl->cntlid == ctrl->cntlid)
> -			list_move_tail(&queue->queue_list, &del_list);
> +	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
> +		if (queue->nvme_sq.ctrl == ctrl) {
> +			list_del_init(&queue->queue_list);
> +			mutex_unlock(&nvmet_rdma_queue_mutex);
> +
> +			__nvmet_rdma_queue_disconnect(queue);
> +			goto restart;
> +		}
>  	}
>  	mutex_unlock(&nvmet_rdma_queue_mutex);
> -
> -	list_for_each_entry_safe(queue, next, &del_list, queue_list)
> -		nvmet_rdma_queue_disconnect(queue);
>  }
> 
>  static int nvmet_rdma_add_port(struct nvmet_port *port)
> 

This patch works.

Tested-by: Steve Wise <swise at opengridcomputing.com>
