From: hare@suse.de (Hannes Reinecke)
Date: Mon, 24 Sep 2018 11:57:08 +0200
Subject: [PATCH] nvme: call nvme_complete_rq on NVME_MPATH failures
In-Reply-To: <20180921184920.12902-1-jsmart2021@gmail.com>
References: <20180921184920.12902-1-jsmart2021@gmail.com>
Message-ID: <16d6e0a9-0710-4bee-0638-b4e17d994a54@suse.de>

On 9/21/18 8:49 PM, James Smart wrote:
[ .. ]
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
>   	if (ctrl->state != NVME_CTRL_DELETING &&
>   	    ctrl->state != NVME_CTRL_DEAD &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> -	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
> +
> +	nvmerq->status = NVME_SC_ABORT_REQ;
> +	nvmerq->result.u64 = 0;
> +	if (rq->cmd_flags & REQ_NVME_MPATH) {
> +		blk_mq_start_request(rq);
> +		nvme_complete_rq(rq);
> +		return BLK_STS_OK;

BLK_STS_TRANSPORT ?

> +	}
>   	return BLK_STS_IOERR;
>   }
>   EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
