From: james.smart@broadcom.com (James Smart)
Date: Wed, 26 Oct 2016 11:05:19 -0700
Subject: [PATCH 1/2] nvme: introduce struct nvme_request
In-Reply-To: <1477411779-2993-2-git-send-email-hch@lst.de>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
 <1477411779-2993-2-git-send-email-hch@lst.de>
Message-ID: <9ca268e3-355c-578f-30ee-5c148a7d8c47@broadcom.com>



On 10/25/2016 9:09 AM, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 5a83881..0b8a161 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -66,6 +66,7 @@ struct nvme_rdma_qe {
>   
>   struct nvme_rdma_queue;
>   struct nvme_rdma_request {
> +	struct nvme_request	req;
>   	struct ib_mr		*mr;
>   	struct nvme_rdma_qe	sqe;
>   	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
> @@ -1117,13 +1118,10 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
>   static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
>   		struct nvme_completion *cqe, struct ib_wc *wc, int tag)
>   {
> -	u16 status = le16_to_cpu(cqe->status);
>   	struct request *rq;
>   	struct nvme_rdma_request *req;
>   	int ret = 0;
>   
> -	status >>= 1;
> -
>   	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
>   	if (!rq) {
>   		dev_err(queue->ctrl->ctrl.device,
> @@ -1134,9 +1132,6 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
>   	}
>   	req = blk_mq_rq_to_pdu(rq);
>   
> -	if (rq->cmd_type == REQ_TYPE_DRV_PRIV && rq->special)
> -		memcpy(rq->special, cqe, sizeof(*cqe));
> -
>   	if (rq->tag == tag)
>   		ret = 1;
>   
> @@ -1144,8 +1139,8 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
>   	    wc->ex.invalidate_rkey == req->mr->rkey)
>   		req->mr->need_inval = false;
>   
> -	blk_mq_complete_request(rq, status);
> -
> +	req->req.result = cqe->result;
> +	blk_mq_complete_request(rq, le16_to_cpu(cqe->status) >> 1);
>   	return ret;
>   }
>   


why do you add a "struct nvme_request" to the nvme_rdma_request 
structure?  Wouldn't a "union nvme_result" been sufficient given that's 
all the set ?

And as there's no other reference to it, and nothing in the second 
patch, why did you add it at all ?

-- james
