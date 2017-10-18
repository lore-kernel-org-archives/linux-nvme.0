From: roy.shterman@gmail.com (roy)
Date: Wed, 18 Oct 2017 14:17:26 +0300
Subject: [PATCH] nvme-rdma: Add debug message when reaches timeout
In-Reply-To: <20171018074409.7483-1-nitzanc@mellanox.com>
References: <20171018074409.7483-1-nitzanc@mellanox.com>
Message-ID: <3ba18b22-755f-0c72-9432-b6a2c09f712d@gmail.com>

On 18/10/17 10:44, Nitzan Carmi wrote:
> Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/rdma.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
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
I guess cid is command id, I think it will be better to print the 
nvme_command attributes.
something like

struct nvme_command *cmd = req->sqe.data;

and to print
cmd->common.command_id, cmd->common.opcode and the queue_id like you 
printed.

Also why printing queue idx in little Indian format?
> +
>   	/* queue error recovery */
>   	nvme_rdma_error_recovery(req->queue->ctrl);
>
> --
> 2.9.4
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
