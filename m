From: hare@suse.de (Hannes Reinecke)
Date: Sat, 10 Aug 2019 14:06:48 +0200
Subject: [PATCH v3 2/7] nvme: return nvme_error_status for sync commands
 failure
In-Reply-To: <20190808205325.24036-3-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <20190808205325.24036-3-sagi@grimberg.me>
Message-ID: <306e0f03-a3a9-afe0-dfee-b6ba34c91102@suse.de>

On 8/8/19 10:53 PM, Sagi Grimberg wrote:
> callers should not rely on raw nvme status, blk_status_t
> is more appropriate.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d2b4f57fa67e..f435c85c4062 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -803,7 +803,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>   		ret = -EINTR;
>   	else
> -		ret = nvme_req(req)->status;
> +		ret = nvme_error_status(req);
>    out:
>   	blk_mq_free_request(req);
>   	return ret;
Please update the description for this function, too.

> @@ -894,7 +894,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>   		ret = -EINTR;
>   	else
> -		ret = nvme_req(req)->status;
> +		ret = nvme_error_status(req);
>   	if (result)
>   		*result = le32_to_cpu(nvme_req(req)->result.u32);
>   	if (meta && !ret && !write) {
> 
But even with this change we'll be leaking blk_status_t error code to 
things like nvme_ioctl(). I'd rather have it mapped to posix error codes 
here by calling blk_status_to_errno().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
