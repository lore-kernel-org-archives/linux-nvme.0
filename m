From: bart.vanassche@wdc.com (Bart Van Assche)
Date: Mon, 26 Feb 2018 11:06:09 -0800
Subject: v4.16-rc2 nvme_rdma ib_destroy_qp() warns about MRs
In-Reply-To: <7b1527ec-8c2f-6bc6-37f8-56053882b328@grimberg.me>
References: <1519431811.2904.52.camel@wdc.com>
 <7b1527ec-8c2f-6bc6-37f8-56053882b328@grimberg.me>
Message-ID: <c93f2454-c997-c7b9-5489-93b64ee510da@wdc.com>

On 02/25/18 10:02, Sagi Grimberg wrote:
> Is this easy to reproduce Bart?

Yes, this behavior is 100% reproducible.

> Does this patch help?
> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 2ef761b5a26e..ffc9362a3a82 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1585,6 +1585,11 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
>  ???????????????? "I/O %d QID %d timeout, reset controller\n",
>  ???????????????? rq->tag, nvme_rdma_queue_idx(req->queue));
> 
> +?????? if (req->mr) {
> +?????????????? ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
> +?????????????? req->mr = NULL;
> +?????? }
> +
>  ??????? /* queue error recovery */
>  ??????? nvme_rdma_error_recovery(req->queue->ctrl);

Hello Sagi,

Has this patch perhaps been superseded by the BLK_EH_RESET_TIMER patch 
that you sent to Alon?

Thanks,

Bart.
