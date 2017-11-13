From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 21:31:37 +0200
Subject: [PATCH v2 1/1] nvme-rdma: Fix memory leak during queue allocation
In-Reply-To: <1510481554-28106-1-git-send-email-maxg@mellanox.com>
References: <1510481554-28106-1-git-send-email-maxg@mellanox.com>
Message-ID: <9b3b8587-ae00-fff6-cf0d-7e02e091a143@grimberg.me>

Hi Max,

>   out_destroy_qp:
> -	rdma_destroy_qp(queue->cm_id);
> +	ib_destroy_qp(queue->qp);

Why was this changed? Any specific reason?>

>   out_destroy_ib_cq:
>   	ib_free_cq(queue->ib_cq);
>   out_put_dev:
> @@ -546,6 +555,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>   
>   out_destroy_cm_id:
>   	rdma_destroy_id(queue->cm_id);
> +	nvme_rdma_destroy_queue_ib(queue);
>   	return ret;
>   }
>   
> @@ -563,8 +573,8 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
>   	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
>   		return;
>   
> -	nvme_rdma_destroy_queue_ib(queue);
>   	rdma_destroy_id(queue->cm_id);
> +	nvme_rdma_destroy_queue_ib(queue);

Why was this changed? What race are you preventing here?
