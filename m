From: hare@suse.de (Hannes Reinecke)
Date: Sat, 10 Aug 2019 13:59:05 +0200
Subject: [PATCH v3 1/7] nvme: fail cancelled commands with
 NVME_SC_HOST_PATH_ERROR
In-Reply-To: <20190808205325.24036-2-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <20190808205325.24036-2-sagi@grimberg.me>
Message-ID: <6c97840c-0360-6503-ba5d-58d732b99a05@suse.de>

On 8/8/19 10:53 PM, Sagi Grimberg wrote:
> NVME_SC_ABORT_REQ means that the request was aborted due to
> an abort command received. In our case, this is a transport
> cancellation, so host pathing error is much more appropriate.
> 
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6956041224ec..d2b4f57fa67e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -294,7 +294,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>   				"Cancelling I/O %d", req->tag);
>   
> -	nvme_req(req)->status = NVME_SC_ABORT_REQ;
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>   	blk_mq_complete_request_sync(req);
>   	return true;
>   }
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
