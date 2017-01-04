From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 4 Jan 2017 10:54:45 +0200
Subject: [PATCH] nvme-rdma: fix nvme_rdma_queue_is_ready
In-Reply-To: <1483507558-26861-1-git-send-email-hch@lst.de>
References: <1483507558-26861-1-git-send-email-hch@lst.de>
Message-ID: <5c351dc7-7674-248b-dda1-5f76c632bfba@mellanox.com>


On 1/4/2017 7:25 AM, Christoph Hellwig wrote:
> Now that we don't abuse the cmd field in struct request for nvme command
> passthrough this function needs to be converted to the proper accessor
> as well.
>
> Fixes: d49187e97e ("nvme: introduce struct nvme_request")
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f587af3..34e5648 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1422,7 +1422,7 @@ static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
>  		struct request *rq)
>  {
>  	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
> -		struct nvme_command *cmd = (struct nvme_command *)rq->cmd;
> +		struct nvme_command *cmd = nvme_req(rq)->cmd;
>
>  		if (rq->cmd_type != REQ_TYPE_DRV_PRIV ||
>  		    cmd->common.opcode != nvme_fabrics_command ||
>

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
