From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 13:44:32 +0300
Subject: [PATCH] nvme-rdma: Add debug message when reaches timeout
In-Reply-To: <20171018074409.7483-1-nitzanc@mellanox.com>
References: <20171018074409.7483-1-nitzanc@mellanox.com>
Message-ID: <06c1a240-c459-6db9-e8f7-2213ec052b36@grimberg.me>

> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 92a03ff..00c033e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1582,6 +1582,10 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
>   {
>   	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
> 
> +	dev_dbg_ratelimited(req->queue->ctrl->ctrl.device,
> +						"Reached timeout - cid %d qid %d", rq->tag,
> +						cpu_to_le16(nvme_rdma_queue_idx(req->queue)));
> +

The alignment needs fixing.
