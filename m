From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 01:26:17 +0300
Subject: [PATCH 11/17] nvme-rdma: Introduce cqe for local invalidation
In-Reply-To: <1527436222-15494-12-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-12-git-send-email-maxg@mellanox.com>
Message-ID: <604569e7-7383-1a16-375b-e3e85743e73b@grimberg.me>


> Using the same cqe object for registration and invalidation completions
> is not safe.

Its perfectly safe as we never post invalidate before the reg_mr
completed as the subsequent send is fenced behind it.

> Separate them to use 2 cqe objects. Also pass the rkey and
> the cqe as arguments for local invalidation function, as a preparation
> for invalidating sig_mr keys.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/rdma.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 1eb4438..a240800 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -68,6 +68,7 @@ struct nvme_rdma_request {
>   	int			nents;
>   	struct ib_reg_wr	reg_wr;
>   	struct ib_cqe		reg_cqe;
> +	struct ib_cqe		inv_cqe;
>   	struct nvme_rdma_queue  *queue;
>   	struct sg_table		sg_table;
>   	struct scatterlist	first_sgl[];
> @@ -1020,7 +1021,7 @@ static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
>   static void nvme_rdma_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
>   {
>   	struct nvme_rdma_request *req =
> -		container_of(wc->wr_cqe, struct nvme_rdma_request, reg_cqe);
> +		container_of(wc->wr_cqe, struct nvme_rdma_request, inv_cqe);
>   	struct request *rq = blk_mq_rq_from_pdu(req);
>   
>   	if (unlikely(wc->status != IB_WC_SUCCESS)) {
> @@ -1033,8 +1034,8 @@ static void nvme_rdma_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
>   
>   }
>   
> -static int nvme_rdma_inv_rkey(struct nvme_rdma_queue *queue,
> -		struct nvme_rdma_request *req)
> +static int nvme_rdma_inv_rkey(struct nvme_rdma_queue *queue, u32 rkey,
> +		struct ib_cqe *cqe)
>   {
>   	struct ib_send_wr *bad_wr;
>   	struct ib_send_wr wr = {
> @@ -1042,11 +1043,10 @@ static int nvme_rdma_inv_rkey(struct nvme_rdma_queue *queue,
>   		.next		    = NULL,
>   		.num_sge	    = 0,
>   		.send_flags	    = IB_SEND_SIGNALED,
> -		.ex.invalidate_rkey = req->mr->rkey,
> +		.ex.invalidate_rkey = rkey,
>   	};
>   
> -	req->reg_cqe.done = nvme_rdma_inv_rkey_done;
> -	wr.wr_cqe = &req->reg_cqe;
> +	wr.wr_cqe = cqe;
>   
>   	return ib_post_send(queue->qp, &wr, &bad_wr);
>   }
> @@ -1141,6 +1141,7 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
>   	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
>   
>   	req->reg_cqe.done = nvme_rdma_memreg_done;
> +	req->inv_cqe.done = nvme_rdma_inv_rkey_done;
>   	memset(&req->reg_wr, 0, sizeof(req->reg_wr));
>   	req->reg_wr.wr.opcode = IB_WR_REG_MR;
>   	req->reg_wr.wr.wr_cqe = &req->reg_cqe;
> @@ -1348,7 +1349,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
>   			nvme_rdma_error_recovery(queue->ctrl);
>   		}
>   	} else if (req->mr) {
> -		ret = nvme_rdma_inv_rkey(queue, req);
> +		ret = nvme_rdma_inv_rkey(queue, req->mr->rkey, &req->inv_cqe);
>   		if (unlikely(ret < 0)) {
>   			dev_err(queue->ctrl->ctrl.device,
>   				"Queueing INV WR for rkey %#x failed (%d)\n",
> 
