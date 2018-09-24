From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Sep 2018 20:59:16 -0700
Subject: [PATCH] nvme: call nvme_complete_rq on NVME_MPATH failures
In-Reply-To: <20180921184920.12902-1-jsmart2021@gmail.com>
References: <20180921184920.12902-1-jsmart2021@gmail.com>
Message-ID: <24baa855-d70a-55bc-5231-9f273e65d392@grimberg.me>


> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 206d63cb1afc..ed4b8e8e0249 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -548,11 +548,20 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>   		struct request *rq)
>   {
> +	struct nvme_request *nvmerq = nvme_req(rq);
> +

Maybe simply call it req?

>   	if (ctrl->state != NVME_CTRL_DELETING &&
>   	    ctrl->state != NVME_CTRL_DEAD &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> -	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
> +
> +	nvmerq->status = NVME_SC_ABORT_REQ;

Not introduced in this patch, but should be le16_to_cpu() >> 1,
but I guess the problem is that we need to open-code status setting
here...

> +	nvmerq->result.u64 = 0;
> +	if (rq->cmd_flags & REQ_NVME_MPATH) {
> +		blk_mq_start_request(rq);
> +		nvme_complete_rq(rq);

Why not calling nvme_end_request() directly instead?

You can also introduce marker helper for nvme_end_request to
use:
static inline void nvme_mark_request(struct request *req, __le16 status,
                 union nvme_result result)
{
         struct nvme_request *rq = nvme_req(req);

         rq->status = le16_to_cpu(status) >> 1;
         rq->result = result;
}

Something like:

	if (rq->cmd_flags & REQ_NVME_MPATH) {
		blk_mq_start_request(rq);
		nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
		return BLK_STS_OK;
	}

	nvme_mark_request(rq, NVME_SC_ABORT_REQ, res);
	return BLK_STS_IOERR;

Thoughts?
